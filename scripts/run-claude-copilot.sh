#!/usr/bin/env bash

# Author: Shuwei Ye (yesw@bnl.gov)
# Date: 2025-09-26
#
# Script to run Claude Code with GitHub Copilot models

# Check if script is being sourced
if [[ "${BASH_SOURCE[0]}" != "${0}" ]] || [[ -n "$ZSH_EVAL_CONTEXT" && "$ZSH_EVAL_CONTEXT" =~ :file$ ]]; then
  echo "Warning: This script should be executed directly, not sourced!" >&2
  return 1
fi

set -e  # Exit on any error
# Note: Removed 'set -u' to avoid conflicts with nvm.sh which has undefined variables

# Configuration
readonly SCRIPT_VERSION="20260116-r1"
COPILOT_API_PORT=8181
COPILOT_API_URL=""

# Known script options (for validation and help messages)
readonly KNOWN_SHORT_OPTIONS="h m l c u n"
readonly KNOWN_LONG_OPTIONS="help model list-models check-usage update-pkgs not-start-claude verbose version"

# Default values
readonly NVM_INSTALL_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh"
readonly FREE_DEFAULT_MODEL="claude-haiku-4.5"
readonly PREMIUM_DEFAULT_MODEL="claude-sonnet-4.5"
DEFAULT_MODEL=""  # Selected from available models; falls back to FREE_DEFAULT_MODEL
MODEL_NAME=""
COPILOT_PID=""
LIST_MODELS=false
CHECK_USAGE=false
UPDATE_PKGS=false

VERBOSE=false
NOT_START_CLAUDE=false
IS_NVM_AVAILABLE=false

# Color definitions using tput
bold=$(tput bold 2>/dev/null || echo '')
red=$(tput setaf 1 2>/dev/null || echo '')
green=$(tput setaf 2 2>/dev/null || echo '')
yellow=$(tput setaf 3 2>/dev/null || echo '')
blue=$(tput setaf 4 2>/dev/null || echo '')
magenta=$(tput setaf 5 2>/dev/null || echo '')
cyan=$(tput setaf 6 2>/dev/null || echo '')
reset=$(tput sgr0 2>/dev/null || echo '')

# Helper functions for colored output
error_msg() {
  echo "${red}${bold}❌ Error:${reset} $*" >&2
}

success_msg() {
  echo "${green}${bold}✅ ${reset}$*"
}

info_msg() {
  echo "${blue}ℹ️  ${reset}$*"
}

warn_msg() {
  echo "${yellow}${bold}⚠️  Warning:${reset} $*" >&2
}

step_msg() {
  echo "${cyan}${bold}➜${reset} $*"
}


# Help message
show_help() {
  cat << EOF
${bold}Usage:${reset} $0 [OPTIONS] [--] [CLAUDE ARGS...]

${blue}Options:${reset}
   ${cyan}-h, --help${reset}              Show this help message
   ${cyan}-m, --model NAME${reset}        Specify the model name to use (default: varies by subscription)
   ${cyan}-l, --list-models${reset}       List available Copilot models
   ${cyan}-c, --check-usage${reset}       Check Copilot API usage
   ${cyan}-u, --update-pkgs${reset}       Update npm, copilot-api, and claude
   ${cyan}-n, --not-start-claude${reset}  Print the command to start claude without executing it
   ${cyan}    --verbose${reset}           Show detailed output
   ${cyan}    --version${reset}           Show script version

${blue}Pass-through to Claude:${reset}
- To pass options to the 'claude' CLI, use the '--' separator to stop this script's option parsing.
- Everything after '--' is forwarded verbatim to 'claude'.
- Positional arguments (non-option arguments) can be passed without '--'.
- Examples:
    $0 -- -p "Your prompt" --temperature 0.7
    $0 -- --help         # show Claude's own help
    $0 -- --version      # show Claude's version
    $0 "Your prompt"     # positional argument, no -- needed

This script sets up and runs Claude Code with GitHub Copilot models.
Any additional arguments are passed directly to the 'claude' command.

${bold}Examples:${reset}
  $0 --help
  $0 -m claude-sonnet-4 'What is the capital of France'
  $0 --list-models
  $0 --check-usage
  $0 --update-pkgs
  $0 --version
  $0 -n
  $0 --not-start-claude
  $0 -- -p "Summarize this repository"
EOF
}

# Print version information
print_version() {
  echo "${bold}📦 Script Version:${reset} $SCRIPT_VERSION"
  exit 0
}


# Parse command line arguments
CLAUDE_CODE_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      exit 0
      ;; 
    -m|--model)
      if [[ -z "$2" ]] || [[ "$2" == -* ]]; then
        echo "${red}${bold}❌ Error:${reset} --model requires a model name argument" >&2
        show_help
        exit 1
      fi
      MODEL_NAME="$2"
      shift 2
      ;;
    -l|--list-models)
      LIST_MODELS=true
      shift
      ;; 
    -c|--check-usage)
      CHECK_USAGE=true
      shift
      ;;
    -u|--update-pkgs)
      UPDATE_PKGS=true
      shift
      ;;
    -n|--not-start-claude)
      NOT_START_CLAUDE=true
      shift
      ;;
    --verbose)
      VERBOSE=true
      shift
      ;;
    --version)
      print_version
      ;;
    --)
      shift
      while [[ $# -gt 0 ]]; do
        CLAUDE_CODE_ARGS+=("$1")
        shift
      done
      break
      ;;
    --*)
      # Check for unknown long options
      option_name="${1#--}"  # Remove leading --
      
      if [[ ! " $KNOWN_LONG_OPTIONS " =~ " $option_name " ]]; then
        error_msg "Unknown option: $1"
        echo "Known long options: --${KNOWN_LONG_OPTIONS// /, --}" >&2
        echo "" >&2
        echo "To pass options to Claude, use the '--' separator:" >&2
        echo "  $0 -- $1 [more options...]" >&2
        echo "" >&2
        echo "Use -h or --help for usage information." >&2
        exit 1
      fi
      
      # This shouldn't happen if case statement above is complete
      error_msg "Unhandled option: $1"
      echo "This is a bug in the script. Please report it." >&2
      exit 1
      ;;
    -*)
      # Check for unknown short options
      option_char="${1#-}"  # Remove leading dash
      
      # Check for bundled options (not supported)
      if [[ ${#option_char} -gt 1 ]]; then
        error_msg "Unknown or bundled option: $1"
        echo "This script does not support bundled short options." >&2
        echo "Known short options: -${KNOWN_SHORT_OPTIONS// /, -}" >&2
        echo "" >&2
        echo "To pass options to Claude, use the '--' separator:" >&2
        echo "  $0 -- $1 [more options...]" >&2
        echo "" >&2
        echo "Use -h or --help for usage information." >&2
        exit 1
      fi
      
      # Single character option - check if it's known
      if [[ ! " $KNOWN_SHORT_OPTIONS " =~ " $option_char " ]]; then
        error_msg "Unknown option: $1"
        echo "Known short options: -${KNOWN_SHORT_OPTIONS// /, -}" >&2
        echo "" >&2
        echo "To pass options to Claude, use the '--' separator:" >&2
        echo "  $0 -- $1 [more options...]" >&2
        echo "" >&2
        echo "Use -h or --help for usage information." >&2
        exit 1
      fi
      
      # This shouldn't happen if case statement above is complete
      error_msg "Unhandled option: $1"
      echo "This is a bug in the script. Please report it." >&2
      exit 1
      ;;
    *)
      # Positional arguments are passed to Claude
      CLAUDE_CODE_ARGS+=("$1")
      shift
      ;; 
  esac
done


# Cleanup function to kill copilot-api processes
# Only skips cleanup when --not-start-claude is used (to keep server running)
cleanup() {
  if [[ "$NOT_START_CLAUDE" == true ]]; then
    verbose_echo "Skipping cleanup for --not-start-claude mode"
    return 0
  fi

  verbose_echo "Cleaning up copilot-api processes..."

  # Kill the specific PID we're tracking with graceful shutdown first
  if [[ -n "$COPILOT_PID" ]]; then
    verbose_echo "Gracefully stopping tracked copilot-api process (PID: $COPILOT_PID)..."
    kill -TERM "$COPILOT_PID" 2>/dev/null || true
    
    # Wait up to 5 seconds for graceful shutdown
    local wait_count=0
    while [[ $wait_count -lt 5 ]] && kill -0 "$COPILOT_PID" 2>/dev/null; do
      sleep 1
      wait_count=$((wait_count + 1))
    done
    
    # Force kill if still running
    if kill -0 "$COPILOT_PID" 2>/dev/null; then
      verbose_echo "Force killing tracked copilot-api process (PID: $COPILOT_PID)..."
      kill -KILL "$COPILOT_PID" 2>/dev/null || true
    fi
    
    wait "$COPILOT_PID" 2>/dev/null || true
  fi

  # Kill any remaining copilot-api processes that might be running
  local copilot_pids
  copilot_pids=$(pgrep -f "copilot-api start" 2>/dev/null || true)
  if [[ -n "$copilot_pids" ]]; then
    verbose_echo "Gracefully stopping remaining copilot-api processes: $copilot_pids"
    echo "$copilot_pids" | xargs kill -TERM 2>/dev/null || true

    # Wait a moment for graceful shutdown
    sleep 2
    copilot_pids=$(pgrep -f "copilot-api start" 2>/dev/null || true)
    if [[ -n "$copilot_pids" ]]; then
      verbose_echo "Force killing stubborn copilot-api processes: $copilot_pids"
      echo "$copilot_pids" | xargs kill -KILL 2>/dev/null || true
    fi
  fi

  # Remove the log files if they exist
  if [[ -f "copilot-api.log" ]]; then
    verbose_echo "Removing copilot-api.log file..."
    rm -f "copilot-api.log"
  fi
}

# Set trap to ensure cleanup happens on exit, interrupt, or termination
trap cleanup EXIT INT TERM

# Output function that only prints when --verbose flag is used
verbose_echo() {
  if [[ "$VERBOSE" == true ]]; then
    echo "$@" >&2
  fi
}

# Helper function to run commands with optional verbose output
# Usage: run_with_verbosity <command> [args...]
# If VERBOSE=true, shows command output; otherwise suppresses it
run_with_verbosity() {
  if [[ "$VERBOSE" == true ]]; then
    "$@"
  else
    "$@" >/dev/null 2>&1
  fi
}

# Helper function to parse JSON values with fallback to sed
# Usage: parse_json_value <json_string> <key_path>
# Example: parse_json_value "$response" ".limited_user_quotas.chat"
parse_json_value() {
  local json_string="$1"
  local key_path="$2"
  
  if command -v jq >/dev/null 2>&1; then
    echo "$json_string" | jq -r "${key_path} // empty" 2>/dev/null || echo ""
  else
    # Fallback to sed-based parsing for simple cases
    case "$key_path" in
      ".access_type_sku")
        echo "$json_string" | sed -n 's/.*"access_type_sku"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' || echo ""
        ;;
      ".copilot_plan")
        echo "$json_string" | sed -n 's/.*"copilot_plan"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' || echo ""
        ;;
      ".limited_user_quotas.chat")
        echo "$json_string" | sed -n 's/.*"chat"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1/p' | head -1 || echo ""
        ;;
      ".limited_user_quotas.completions")
        echo "$json_string" | sed -n 's/.*"completions"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1/p' | head -1 || echo ""
        ;;
      ".quota_snapshots.premium_interactions.entitlement")
        echo "$json_string" | sed -n 's/.*"premium_interactions"[[:space:]]*:[[:space:]]*[{][^}]*"entitlement"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1/p' | head -1 || echo ""
        ;;
      ".quota_snapshots.premium_interactions.remaining")
        echo "$json_string" | sed -n 's/.*"premium_interactions"[[:space:]]*:[[:space:]]*[{][^}]*"remaining"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1/p' | head -1 || echo ""
        ;;
      ".token")
        echo "$json_string" | sed -n 's/.*"token"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' || echo ""
        ;;
      *)
        echo ""
        ;;
    esac
  fi
}

# Helper function to download and verify scripts
# Usage: download_and_verify_script <url> [expected_pattern]
download_and_verify_script() {
  local url="$1"
  local expected_pattern="${2:-}"
  
  verbose_echo "Downloading script from: $url"
  
  # Download to temporary file first
  local temp_script
  temp_script=$(mktemp) || {
    error_msg "Failed to create temporary file"
    return 1
  }
  
  # Ensure cleanup of temp file
  trap 'rm -f "$temp_script"' RETURN
  
  # Download with timeout
  if ! curl -sSf --connect-timeout 10 --max-time 60 "$url" -o "$temp_script"; then
    error_msg "Failed to download script from $url"
    return 1
  fi
  
  # Basic verification - check if it looks like a shell script
  if ! head -1 "$temp_script" | grep -q "^#!/"; then
    error_msg "Downloaded file doesn't appear to be a shell script"
    return 1
  fi
  
  # Additional pattern verification if provided
  if [[ -n "$expected_pattern" ]] && ! grep -q "$expected_pattern" "$temp_script"; then
    error_msg "Downloaded script doesn't contain expected pattern: $expected_pattern" >&2
    return 1
  fi
  
  # Execute the verified script
  bash "$temp_script"
}

# Helper function to read and validate GitHub token from file
# Usage: read_github_token
# Returns: Prints the token to stdout and returns 0 on success, 1 on failure
read_github_token() {
  local github_token_file="$HOME/.local/share/copilot-api/github_token"
  
  verbose_echo "Checking for GitHub token file at: $github_token_file"
  
  # Check and fix file permissions for security
  if [[ -f "$github_token_file" ]]; then
    local current_perms
    current_perms=$(stat -c %a "$github_token_file" 2>/dev/null || echo "")
    if [[ "$current_perms" != "600" ]]; then
      verbose_echo "Fixing token file permissions (was $current_perms, setting to 600)"
      chmod 600 "$github_token_file" || {
        error_msg "Failed to set secure permissions on token file" >&2
        return 1
      }
    fi
  fi
  
  verbose_echo "GitHub token file found, reading content..."
  
  local GITHUB_TOKEN
  GITHUB_TOKEN=$(cat "$github_token_file")

  # Validate that token was read successfully (following project specifications)
  if [[ -z "$GITHUB_TOKEN" ]]; then
    error_msg "Token file exists but contains no token data" >&2
    return 1
  fi
  
  # Additional validation: ensure token content is valid (no newlines, reasonable length)
  if [[ "$GITHUB_TOKEN" == *$'\n'* ]] || [[ ${#GITHUB_TOKEN} -le 10 ]]; then
    error_msg "Token file contains invalid token data" >&2
    verbose_echo "Token content preview: '${GITHUB_TOKEN:0:20}...'"
    return 1
  fi
  
  echo "$GITHUB_TOKEN"
  return 0
}

# Helper function to make GitHub API calls with standard headers
# Usage: github_api_call <url> [additional_headers...]
# Returns: API response on stdout, returns curl exit code
github_api_call() {
  local url="$1"
  shift

  # read the file-based token
  local github_token
  if ! github_token=$(read_github_token); then
    return 1
  fi

  # Standard headers for GitHub API calls
  local base_headers=(
    "-H" "Authorization: Bearer ${github_token}"
    "-H" "Content-Type: application/json"
  )

  # Add any additional headers passed as arguments
  local additional_headers=("$@")

  verbose_echo "Making GitHub API call to: $url"

  # Make the API call with timeout and standard + additional headers
  curl -sSf --connect-timeout 10 --max-time 30 "${base_headers[@]}" "${additional_headers[@]}" "$url"
}

# Check GitHub token file and authenticate if missing or empty
# Usage: check_github_token_file
# Returns 0 if token file exists with valid content or was successfully created, 1 on failure
check_github_token_file() {
  local github_token_file="$HOME/.local/share/copilot-api/github_token"
  
  # Check if file doesn't exist OR exists but is empty
  if [[ ! -f "$github_token_file" ]] || [[ ! -s "$github_token_file" ]]; then
    if [[ ! -f "$github_token_file" ]]; then
      echo "GitHub Copilot token file not found at: $github_token_file"
    else
      echo "GitHub Copilot token file is empty at: $github_token_file"
    fi
    step_msg "Running 'copilot-api auth' to authenticate with GitHub Copilot..."
    echo "Please follow the authentication prompts."
    echo ""
    
    if ! copilot-api auth; then
      error_msg "Failed to authenticate with GitHub Copilot" >&2
      return 1
    fi
    
    # Verify the token file was created and has content
    if [[ -f "$github_token_file" ]] && [[ -s "$github_token_file" ]]; then
      # Additional validation: ensure the token actually contains readable content
      local test_token
      test_token=$(cat "$github_token_file" 2>/dev/null || echo "")
      if [[ -n "$test_token" ]] && [[ "$test_token" != *$'\n'* ]] && [[ ${#test_token} -gt 10 ]]; then
        echo "Successfully authenticated! Token file created at: $github_token_file"
        return 0
      else
        error_msg "Authentication completed but token file contains invalid data" >&2
        verbose_echo "Token content preview: '${test_token:0:20}...'"
        return 1
      fi
    else
      error_msg "Authentication completed but token file was not created or is empty" >&2
      return 1
    fi
  fi
  
  return 0
}

# Get Copilot subscription data - consolidated API call to avoid duplication
get_copilot_subscription_data() {
  verbose_echo "Fetching Copilot subscription data..."

  local response
  response=$(github_api_call "https://api.github.com/copilot_internal/user")
  local curl_exit_code=$?

  verbose_echo "Curl exit code: $curl_exit_code"
  verbose_echo "API Response: $response"

  if [[ $curl_exit_code -eq 0 && -n "$response" ]]; then
    echo "$response"
    return 0
  else
    verbose_echo "Could not retrieve Copilot subscription data from GitHub API"
    return 1
  fi
}

# Display basic subscription information
display_basic_info() {
  local response="$1"
  
  local access_type_sku
  local copilot_plan
  access_type_sku=$(parse_json_value "$response" ".access_type_sku")
  copilot_plan=$(parse_json_value "$response" ".copilot_plan")
  
  # Extract reset date
  local reset_date=""
  if command -v jq >/dev/null 2>&1; then
    reset_date=$(echo "$response" | jq -r '.quota_reset_date // .quota_reset_date_utc // .limited_user_reset_date // empty' 2>/dev/null || echo "")
  fi

  echo ""
  echo "${bold}${blue}════════════════════════════════════════════════════════════${reset}"
  echo "${bold}${blue}         📊 GitHub Copilot Usage Information${reset}"
  echo "${bold}${blue}════════════════════════════════════════════════════════════${reset}"
  echo ""
  
  # Display reset date at top if available
  if [[ -n "$reset_date" ]]; then
    echo "${bold}📅 Next Reset Date: ${yellow}$reset_date${reset}"
    echo ""
  fi
  
  # Display subscription info
  if [[ -n "$access_type_sku" ]]; then
    echo "${bold}📋 Subscription: ${cyan}$access_type_sku${reset}"
  elif [[ -n "$copilot_plan" ]]; then
    echo "${bold}📋 Subscription: ${cyan}$copilot_plan${reset}"
  fi
  echo ""
}

# Display free subscription quota information
display_free_subscription_info() {
  local response="$1"
  
  echo "${bold}${magenta}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset}"
  echo "${bold}${cyan}  💬 Chat Requests${reset}"
  echo "${bold}${magenta}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset}"
  echo ""

  local chat_quota
  chat_quota=$(parse_json_value "$response" ".limited_user_quotas.chat")
  
  # Extract monthly quotas for reference
  local monthly_chat=""
  if command -v jq >/dev/null 2>&1; then
    monthly_chat=$(echo "$response" | jq -r '.monthly_quotas.chat // empty' 2>/dev/null || echo "")
  fi

  if [[ -n "$monthly_chat" && -n "$chat_quota" ]]; then
    local chat_used=$((monthly_chat - chat_quota))
    local copilot_requests=$((chat_quota / 10))
    
    echo "  ${bold}Monthly Quota:${reset} $monthly_chat"
    echo "  ${bold}Used:${reset}          $chat_used"
    echo ""
    
    # Color code remaining based on amount
    local chat_color="$green"
    if [[ $chat_quota -le 200 ]]; then
      chat_color="$red"
    elif [[ $chat_quota -le 500 ]]; then
      chat_color="$yellow"
    fi
    
    echo "  ${bold}${chat_color}💬 Remaining Chat Requests: ${bold}$chat_quota${reset}"
    echo "  ${cyan}   (≈ ${bold}$copilot_requests${reset}${cyan} Copilot requests @ 10 chats each)${reset}"
  else
    echo "  Chat Requests: ${chat_quota:-"N/A"}"
  fi
  
  echo ""
}

# Display premium subscription quota information
display_premium_subscription_info() {
  local response="$1"
  
  # Premium Interactions Section
  echo "${bold}${magenta}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset}"
  echo "${bold}${cyan}  ⚡ Premium Interactions${reset}"
  echo "${bold}${magenta}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset}"
  echo ""

  local premium_entitlement
  local premium_remaining
  premium_entitlement=$(parse_json_value "$response" ".quota_snapshots.premium_interactions.entitlement")
  premium_remaining=$(parse_json_value "$response" ".quota_snapshots.premium_interactions.remaining")
  local premium_unlimited=""
  
  if command -v jq >/dev/null 2>&1; then
    premium_unlimited=$(echo "$response" | jq -r '.quota_snapshots.premium_interactions.unlimited // false' 2>/dev/null)
  fi

  if [[ "$premium_unlimited" == "true" ]]; then
    echo "  ${bold}${green}🚀 Status: ${bold}UNLIMITED${reset}"
  elif [[ -n "$premium_entitlement" && -n "$premium_remaining" ]]; then
    local used_requests=$((premium_entitlement - premium_remaining))
    
    echo "  ${bold}Monthly Quota:${reset} $premium_entitlement"
    echo "  ${bold}Used:${reset}          $used_requests"
    echo ""
    
    # Color code remaining based on amount
    local premium_color="$green"
    if [[ $premium_remaining -le 10 ]]; then
      premium_color="$red"
    elif [[ $premium_remaining -le 50 ]]; then
      premium_color="$yellow"
    fi
    
    echo "  ${bold}${premium_color}⚡ Remaining Premium Requests: ${bold}$premium_remaining${reset}"
    
    # Add warning if low
    if [[ $premium_remaining -le 10 ]]; then
      echo "  ${bold}${red}⚠️  WARNING: Low quota! Only $premium_remaining requests left${reset}"
    elif [[ $premium_remaining -le 50 ]]; then
      echo "  ${bold}${yellow}⚠️  NOTICE: $premium_remaining requests remaining${reset}"
    fi
  else
    echo "  Premium Interactions: Unable to parse quota data"
  fi
  
  echo ""
}

# Check GitHub Copilot usage and subscription details with detailed output
check_usage() {
  verbose_echo "Fetching Copilot usage information..."

  # Make the API request using consolidated function
  local response
  response=$(get_copilot_subscription_data)
  local curl_exit_code=$?

  if [[ $curl_exit_code -eq 0 && -n "$response" ]]; then
    verbose_echo "Copilot API response received, parsing usage information..."

    # Display basic subscription information
    display_basic_info "$response"

    # Check subscription type and display appropriate information
    if echo "$response" | grep -q "limited_user_quotas"; then
      display_free_subscription_info "$response"
    elif echo "$response" | grep -q "quota_snapshots"; then
      display_premium_subscription_info "$response"
    else
      echo "=== Subscription Type Unknown ==="
      echo "Unable to determine subscription type from response"
      echo ""
    fi

    # Footer
    echo "${bold}${blue}════════════════════════════════════════════════════════════${reset}"
    echo ""

    return 0
  else
    error_msg "Could not retrieve Copilot usage information from GitHub API"
    if [[ -n "$response" ]]; then
      verbose_echo "Response: $response"
    fi
    return 1
  fi
}

# Extract the listening URL from copilot-api log file
# Usage: extract_copilot_url <log_file>
# Returns: The URL (without trailing slash) or empty string if not found
extract_copilot_url() {
  local log_file="$1"
  local max_attempts=30
  local attempt=0

  while [[ $attempt -lt $max_attempts ]]; do
    if [[ -f "$log_file" ]]; then
      # Extract URL from "Listening on: http://xxx:xxx/" line, removing trailing slash
      # The line may contain a leading arrow character (➜) which we need to handle
      local url
      # Use grep with Perl-compatible regex to extract URL after "Listening on:"
      # The pattern matches "Listening on:" followed by optional whitespace, then captures http:// until whitespace
      url=$(grep -oP 'Listening on:\s*\Khttp://[^[:space:]]+' "$log_file" 2>/dev/null | head -1 | sed 's|/$||') || true
      if [[ -n "$url" ]]; then
        echo "$url"
        return 0
      fi
    fi
    sleep 0.5
    attempt=$((attempt + 1))
  done

  return 1
}

# Start copilot-api with port retry logic
start_copilot_api() {
  local ports=(8181 4141 8182 8183 8184 8185 8186 8187 8188 8189)
  local attempt=0

  while [[ $attempt -lt ${#ports[@]} ]]; do
    local current_port=${ports[$attempt]}
    verbose_echo "Attempt $((attempt + 1)): Starting copilot-api on port $current_port..."

    # Update global port variable
    COPILOT_API_PORT=$current_port

    # Clear log file before starting
    rm -f copilot-api.log

    copilot-api start --port "$COPILOT_API_PORT" > copilot-api.log 2>&1 &
    local pid=$!

    # Wait a moment to see if it starts successfully
    sleep 1

    # Check if the process is still running
    if ! kill -0 "$pid" 2>/dev/null; then
      # Process died, check if it was due to port being in use
      if grep -q "EADDRINUSE" copilot-api.log 2>/dev/null; then
        verbose_echo "Port $current_port is in use, trying next port..."
        attempt=$((attempt + 1))
        continue
      else
        error_msg "copilot-api failed to start for unknown reason" >&2
        if [[ -f "copilot-api.log" ]]; then
          echo "Last 10 lines from copilot-api.log:"
          tail -n 10 copilot-api.log
        fi
        exit 1
      fi
    fi

    # Extract the actual listening URL from the log
    verbose_echo "Waiting for copilot-api to report listening URL..."
    local extracted_url
    extracted_url=$(extract_copilot_url "copilot-api.log")

    if [[ -n "$extracted_url" ]]; then
      verbose_echo "Successfully started copilot-api at $extracted_url"
      # Output both URL and PID separated by a pipe for the caller to parse
      echo "${extracted_url}|${pid}"
      return 0
    else
      # Failed to extract URL, kill the process and try next port
      verbose_echo "Could not extract listening URL from copilot-api log, trying next port..."
      kill "$pid" 2>/dev/null || true
      wait "$pid" 2>/dev/null || true
      attempt=$((attempt + 1))
      continue
    fi
  done

  error_msg "Failed to start copilot-api on any of the attempted ports: ${ports[*]}" >&2
  exit 1
}

# Try to source nvm from common shell configuration files
try_source_nvm() {
  # Common nvm installation paths
  if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
    export NVM_DIR="$HOME/.nvm"
    verbose_echo "Attempting to source nvm from $HOME/.nvm/nvm.sh"
    
    # Source nvm.sh directly (set -u is now disabled)
    # shellcheck source=/dev/null
    \. "$HOME/.nvm/nvm.sh"
    
    if command -v nvm >/dev/null 2>&1; then
      verbose_echo "Successfully sourced nvm from $HOME/.nvm/nvm.sh"
      IS_NVM_AVAILABLE=true
    else
      error_msg "Failed to source nvm properly"
      exit 1
    fi
  fi
}

# Check and fix npm prefix if not managed by nvm
check_npm_prefix() {
  verbose_echo "Checking npm prefix configuration..."
  local nvm_managed=false
  local npm_prefix
  local nvm_home
  npm_prefix=$(npm config get prefix 2>/dev/null || echo "")
  nvm_home=$(cd "$NVM_DIR" && pwd -P 2>/dev/null || echo "")
  
  if [[ -n "$npm_prefix" ]]; then
    # Check if npm prefix is under nvm management
    if [[ "$npm_prefix" == "${nvm_home}/"* ]]; then
      nvm_managed=true
      verbose_echo "Detected nvm-managed npm prefix ($npm_prefix)"
    fi
  fi

  if [[ "$nvm_managed" != true ]]; then
    local global_packages=()

    if [[ -n "$npm_prefix" ]]; then
      echo "npm prefix is not set to nvm path. Current prefix: $npm_prefix"

      # Get list of globally installed packages before changing prefix
      verbose_echo "Backing up globally installed packages..."
      while IFS= read -r package_path; do
        if [[ -n "$package_path" && "$package_path" != "$npm_prefix" ]]; then
          local package_name
          package_name=$(basename "$package_path")
          # Skip npm itself and node_modules directories
          if [[ "$package_name" != "npm" && "$package_name" != "node_modules" ]]; then
            global_packages+=("$package_name")
          fi
        fi
      done < <(npm list -g --parseable --depth=0 2>/dev/null || true)

      if [[ ${#global_packages[@]} -gt 0 ]]; then
        echo "Found ${#global_packages[@]} global package(s) to reinstall:"
        if [[ "$VERBOSE" == true ]]; then
          printf '  - %s\n' "${global_packages[@]}"
        fi
      else
        verbose_echo "No global packages found to backup."
      fi

      verbose_echo "Removing npm prefix configuration..."
      npm config delete prefix >/dev/null 2>&1 || true
    fi
      
    npm_prefix=$(npm config get prefix 2>/dev/null || echo "")
    echo "npm prefix is now set to: $npm_prefix"
    
    # Reinstall global packages if any were found
    if [[ ${#global_packages[@]} -gt 0 ]]; then
      echo "Reinstalling global packages under new prefix..."
      for pkg in "${global_packages[@]}"; do
        verbose_echo "  Installing $pkg..."
        if ! run_with_verbosity npm install -g "$pkg"; then
          echo "  Warning: Failed to install $pkg"
        fi
      done
      verbose_echo "Global package restoration complete."
    fi
  else
    verbose_echo "npm prefix is correctly set to nvm path: $npm_prefix"
  fi
}

# Install nvm
install_nvm() {
  step_msg "Installing nvm"
  if ! download_and_verify_script "$NVM_INSTALL_URL" "nvm"; then
    error_msg "Failed to install nvm" >&2
    exit 1
  fi
}

# Ensure npm is available and from correct path
ensure_npm() {
  local npm_path
  npm_path=$(type -f -p npm 2>/dev/null || echo "")
  if [[ -z "$npm_path" ]]; then
    run_with_verbosity nvm install node
    npm_path=$(type -f -p npm 2>/dev/null || echo "")
  fi

  if [[ -z "$npm_path" ]]; then
    error_msg "npm not found"
    exit 1
  else
    verbose_echo "npm is available at: $npm_path"
  fi

  check_npm_prefix
}

# Install or update a package globally via npm
# if the second arg is missing, always install/update the package 
install_package_if_not_installed() {
  local package_name=$1
  local command_name=$2
  if [[ -n "$command_name" ]]; then
    if command -v "$command_name" &> /dev/null; then
      verbose_echo "$command_name is already installed"
      return 0
    fi
  fi
  
  verbose_echo "Installing/updating $package_name..."
  run_with_verbosity npm install -g "$package_name"
}

# List available models using direct API call to GitHub Copilot
# Outputs plain format: one model name per line (no colors, headers, or formatting)
# For formatted display, use print_models() instead
list_models() {
  verbose_echo "Fetching available models from GitHub Copilot API..."

  # Get the Copilot token first
  local copilot_response copilot_token
  copilot_response=$(github_api_call "https://api.github.com/copilot_internal/v2/token")
  local curl_exit_code=$?

  if [[ $curl_exit_code -eq 0 && -n "$copilot_response" ]]; then
    copilot_token=$(parse_json_value "$copilot_response" ".token")
  fi

  if [[ -z "$copilot_token" ]]; then
    error_msg "Failure in getting the copilot token, exit now"
    return 1
  fi
  
  # Use the direct API call to get models (same endpoint as copilot-api)
  local base_headers=(
    "-H" "Authorization: Bearer $copilot_token"
    "-H" "Content-Type: application/json"
    "-H" "Copilot-Integration-Id: vscode-chat"
    "-H" "X-GitHub-Api-Version: 2025-04-01"
  )
  local models_response
  models_response=$(curl -sSf "${base_headers[@]}" "https://api.githubcopilot.com/models")
  local curl_exit_code=$?

  if [[ $curl_exit_code -eq 0 && -n "$models_response" ]]; then
    verbose_echo "Models API response received"

    # Check if jq is available for parsing
    if command -v jq >/dev/null 2>&1; then
      local models
      models=$(echo "$models_response" | jq -r '.data[].id' 2>/dev/null)

      if [[ -n "$models" ]]; then
        # Always output plain format (one model per line)
        echo "$models"
        return 0
      else
        echo ""
        echo "${bold}${blue}📋 Available models:${reset}"
        warn_msg "No models found in API response"
        echo "  Raw API response:"
        echo "$models_response"
        return 1
      fi
    else
      echo ""
      echo "${bold}${blue}📋 Available models:${reset}"
      warn_msg "jq is required for parsing model list, but it's not installed"
      echo "  Raw API response:"
      echo "$models_response"
      return 1
    fi
  else
    error_msg "Could not retrieve models from GitHub Copilot API"
    if [[ -n "$models_response" ]]; then
      echo "Response: $models_response"
    fi
    return 1
  fi
}

# Print available models with formatted output (colors, headers)
# For use with --list-models option
print_models() {
  local models
  models=$(list_models 2>/dev/null)
  local exit_code=$?
  
  if [[ $exit_code -eq 0 && -n "$models" ]]; then
    echo ""
    echo "${bold}${blue}📋 Available models:${reset}"
    echo "${yellow}Note: Not all listed models may be accessible. Please verify by trying them first.${reset}"
    echo "$models" | while IFS= read -r model; do
      if [[ -n "$model" ]]; then
        echo "  ${cyan}•${reset} $model"
      fi
    done
    echo ""
    echo "${yellow}⚙️  Note: Some models need to be enabled at${reset}"
    echo "${cyan}   https://github.com/settings/copilot/features${reset}"
    echo "${yellow}   before they become available for use.${reset}"
    return 0
  else
    return $exit_code
  fi
}


# Install or update copilot-api from the responses-api feature branch
# Clones the source, modifies the version string, builds and installs globally via npm
install_copilot_api() {
  if command -v copilot-api &> /dev/null; then
    INSTALLED_VERSION=$(copilot-api --version 2>/dev/null)
    if [[ "$INSTALLED_VERSION" == *"-responses-api" ]]; then
      BASE_VERSION="${INSTALLED_VERSION%-responses-api}"
      REMOTE_VERSION=$(curl -s https://raw.githubusercontent.com/caozhiyuan/copilot-api/feature/responses-api/package.json | grep '"version":' | cut -d'"' -f4)
      if [[ "$BASE_VERSION" == "$REMOTE_VERSION" ]]; then
        verbose_echo "copilot-api $INSTALLED_VERSION is already installed and up-to-date. Skipping installation."
        return 0
      fi
    fi
  fi

  step_msg "Installing copilot-api from responses-api branch..."

  # Get the package source code
  local build_dir
  build_dir=$(mktemp -d)
  git clone -b feature/responses-api https://github.com/caozhiyuan/copilot-api.git "$build_dir/copilot-api"

  pushd "$build_dir/copilot-api" > /dev/null

  # Extract the version (e.g., 0.7.0)
  OLD_VERSION=$(grep '"version":' package.json | cut -d'"' -f4)
  NEW_VERSION="${OLD_VERSION}-responses-api"

  # Apply changes to enable the --version flag and custom naming
  sed -i "s/\"version\": \"$OLD_VERSION\"/\"version\": \"$NEW_VERSION\"/" package.json
  sed -i "/name: \"copilot-api\",/a \    version: \"$NEW_VERSION\"," src/main.ts

  # Install dependencies and build the project
  run_with_verbosity npm install
  run_with_verbosity npx tsdown

  # Create a production tarball (bypassing the bun-based prepack script)
  run_with_verbosity npm pack --ignore-scripts

  # Install the generated tarball globally
  run_with_verbosity npm install -g "./copilot-api-${NEW_VERSION}.tgz"

  popd > /dev/null

  # Cleanup
  rm -rf "$build_dir"
  npm cache clean --force > /dev/null 2>&1 || true

  success_msg "copilot-api $NEW_VERSION installed successfully"
}

# Install claude CLI using the official installer
install_claude() {
  if command -v claude &> /dev/null; then
    verbose_echo "claude is already installed"
    return 0
  fi

  step_msg "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
  success_msg "Claude Code installed successfully"
}

# Update packages: npm, nvm, node, copilot-api, and claude-code
update_pkgs() {
  # update npm
  verbose_echo "Updating npm..."
  if ! run_with_verbosity npm update npm -g; then
    warn_msg "Failed to update npm, continuing..." >&2
  fi

  # update/install required packages
  install_copilot_api
  install_claude
}

# Main execution function - handles all script logic and flow
main() {
  # Skip nvm/npm setup if npm is already available
  if command -v npm &> /dev/null; then
    verbose_echo "npm is already available at: $(command -v npm)"
  else
    # First try to source nvm from common locations
    try_source_nvm

    # Install nvm if not available
    if [[ $IS_NVM_AVAILABLE != true ]]; then
      install_nvm
      try_source_nvm
      if [[ $IS_NVM_AVAILABLE != true ]]; then
        error_msg "Failed to install nvm"
        exit 1
      fi
    fi

    verbose_echo "Ensuring npm is available..."
    ensure_npm
  fi

  # Handle update commands first (no token needed)
  if [[ "$UPDATE_PKGS" == true ]]; then
    update_pkgs
    exit 0
  fi
  
  # Check if copilot-ai is available, install if not
  verbose_echo "Checking copilot-api and install it if not available"
  install_copilot_api
  
  # Check token file (updates handled earlier)
  if ! check_github_token_file; then
    exit 1
  fi

  # Handle simple commands that require token
  if [[ "$LIST_MODELS" == true ]]; then
    if ! print_models; then
      exit 1
    else
      exit 0
    fi
  fi

  if [[ "$CHECK_USAGE" == true ]]; then
    if ! check_usage; then
      exit 1
    else
      exit 0
    fi
  fi

  # For full execution, we need claude code
  
  verbose_echo "Installing/updating Claude Code..."
  install_claude

  verbose_echo "Starting copilot-api in background..."
  local copilot_result
  copilot_result=$(start_copilot_api)

  # Parse the result (format: "URL|PID")
  COPILOT_API_URL="${copilot_result%|*}"
  COPILOT_PID="${copilot_result#*|}"

  # Validate that COPILOT_API_URL was properly set
  if [[ -z "$COPILOT_API_URL" ]] || [[ -z "$COPILOT_PID" ]]; then
    error_msg "Failed to extract COPILOT_API_URL from copilot-api log"
    echo "Last 20 lines from copilot-api.log:"
    tail -n 20 copilot-api.log 2>/dev/null || echo "(log file not found)"
    exit 1
  fi

  verbose_echo "COPILOT_API_URL is set to: $COPILOT_API_URL"
  verbose_echo "COPILOT_PID is set to: $COPILOT_PID"

  # Detect subscription type to choose appropriate default model
  verbose_echo "Detecting subscription type..."
  local subscription_response
  subscription_response=$(get_copilot_subscription_data 2>/dev/null || echo "")
  
  local is_premium=false
  if [[ -n "$subscription_response" ]]; then
    # Check if this is a premium subscription (has quota_snapshots instead of limited_user_quotas)
    if echo "$subscription_response" | grep -q "quota_snapshots"; then
      verbose_echo "Detected premium subscription"
      is_premium=true
    elif echo "$subscription_response" | grep -q "limited_user_quotas"; then
      verbose_echo "Detected free subscription"
      is_premium=false
    else
      verbose_echo "Could not determine subscription type, assuming free"
      is_premium=false
    fi
  else
    verbose_echo "Could not retrieve subscription data, assuming free"
    is_premium=false
  fi
  
  # Get available models
  verbose_echo "Getting available models..."
  local models=()
  mapfile -t models < <(list_models)

  if [[ ${#models[@]} -eq 0 ]]; then
    error_msg "No models available from GitHub Copilot API"
    exit 1
  fi
  verbose_echo "Available models: ${models[*]}"

  # Helper function to check if a model is available
  model_is_available() {
    local target_model="$1"
    for model in "${models[@]}"; do
      if [[ "$model" == "$target_model" ]]; then
        return 0
      fi
    done
    return 1
  }

  # Determine preferred default based on subscription type
  local preferred_default="$FREE_DEFAULT_MODEL"
  if [[ "$is_premium" == "true" ]]; then
    preferred_default="$PREMIUM_DEFAULT_MODEL"
    verbose_echo "Premium subscription detected, preferring: $preferred_default"
  else
    verbose_echo "Free subscription detected, preferring: $preferred_default"
  fi

  # Select model: use user-specified if valid, otherwise use preferred default if available, otherwise first available
  if [[ -n "$MODEL_NAME" ]]; then
    # User specified a model - validate it
    if model_is_available "$MODEL_NAME"; then
      verbose_echo "Using user-specified model: $MODEL_NAME"
    else
      warn_msg "Requested model '$MODEL_NAME' is not available"
      MODEL_NAME=""
    fi
  fi

  # If no valid user-specified model, select from defaults
  if [[ -z "$MODEL_NAME" ]]; then
    if model_is_available "$preferred_default"; then
      MODEL_NAME="$preferred_default"
      verbose_echo "Using preferred default model: $MODEL_NAME"
    else
      MODEL_NAME="${models[0]}"
      warn_msg "Preferred model '$preferred_default' not available, using: $MODEL_NAME"
    fi
  fi

  verbose_echo "Using model: $MODEL_NAME"
  
  # Display or run the main job
  echo ""
  step_msg "${bold}${magenta}🚀 Running Claude Code with model: ${cyan}$MODEL_NAME${reset}"
  echo ""
  
  if [[ "$NOT_START_CLAUDE" == true ]]; then
    # Print available models for user reference
    if [[ ${#models[@]} -gt 0 ]]; then
      echo "${bold}${blue}📋 Available models:${reset}"
      echo "${yellow}Note: Not all listed models may be accessible. Please verify by trying them first.${reset}"
      for model in "${models[@]}"; do
        if [[ "$model" == "$MODEL_NAME" ]]; then
          echo "  ${green}${bold}✓${reset} $model ${green}(selected)${reset}"
        else
          echo "  ${cyan}•${reset} $model"
        fi
      done
      echo ""
      echo "${yellow}⚙️  Note: Some models need to be enabled at${reset}"
      echo "${cyan}   https://github.com/settings/copilot/features${reset}"
      echo "${yellow}   before they become available for use.${reset}"
    fi

    # Print the command without executing it
    echo ""
    info_msg "${bold}To start Claude Code manually, run:${reset}"
    echo "  ${cyan}ANTHROPIC_BASE_URL=$COPILOT_API_URL ANTHROPIC_AUTH_TOKEN=dummy ANTHROPIC_MODEL=$MODEL_NAME claude [your-claude-options]${reset}"
    echo ""
    echo "${bold}Examples with common claude options:${reset}"
    echo "  ${cyan}ANTHROPIC_BASE_URL=$COPILOT_API_URL ANTHROPIC_AUTH_TOKEN=dummy ANTHROPIC_MODEL=$MODEL_NAME claude -p \"Your prompt here\"${reset}"
    echo "  ${cyan}ANTHROPIC_BASE_URL=$COPILOT_API_URL ANTHROPIC_AUTH_TOKEN=dummy ANTHROPIC_MODEL=$MODEL_NAME claude --help${reset}"
    echo ""
    info_msg "The copilot-api server will continue running in the background (PID: ${bold}$COPILOT_PID${reset})."
    echo "To stop it manually when you're done, run: ${yellow}kill $COPILOT_PID${reset}"
    echo ""
    warn_msg "Server will remain running until manually stopped"
  else
    # Pass any additional arguments to claude command
    export ANTHROPIC_BASE_URL=$COPILOT_API_URL ANTHROPIC_AUTH_TOKEN=dummy ANTHROPIC_MODEL=$MODEL_NAME
    if [[ ${#CLAUDE_CODE_ARGS[@]} -gt 0 ]]; then
      claude "${CLAUDE_CODE_ARGS[@]}"
    else
      claude
    fi

    success_msg "Claude Code execution completed"
    # Cleanup is handled automatically by trap
  fi
}

# Run main function
main
