#!/bin/bash

# curl-copilot.sh - Test GitHub Copilot API with gpt-5-mini model
# This script demonstrates how to authenticate and make a chat completion request

set -e

# Initialize variables
SHOW_HELP=false
TOKEN_PROVIDED_VIA_ARG=false
MODEL="gpt-5-mini"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      SHOW_HELP=true
      shift
      ;;
    --token)
      if [[ -n "$2" ]]; then
        GITHUB_TOKEN="$2"
        TOKEN_PROVIDED_VIA_ARG=true
        shift 2
      else
        echo "Error: --token requires an argument" >&2
        exit 1
      fi
      ;;
    --model)
      if [[ -n "$2" ]]; then
        MODEL="$2"
        shift 2
      else
        echo "Error: --model requires an argument" >&2
        exit 1
      fi
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Use -h or --help for usage information" >&2
      exit 1
      ;;
  esac
done

# If help was requested, show usage and exit
if [ "$SHOW_HELP" = true ]; then
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo "  -h, --help     Show this help message"
  echo "  --token TOKEN  Specify the GitHub token to use"
  echo "  --model MODEL  Specify the model to use (default: gpt-5-mini)"
  echo ""
  echo "If --token is not provided, the script will try to use the GITHUB_TOKEN environment variable."
  exit 0
fi

# If token wasn't provided via command line argument, check environment variable
if [ "$TOKEN_PROVIDED_VIA_ARG" = false ]; then
  # Use a subshell to get the environment variable value safely
  env_value=$(bash -c 'echo $GITHUB_TOKEN')
  if [ -n "$env_value" ]; then
    GITHUB_TOKEN="$env_value"
  fi
fi

# Check if token is still empty after trying both command line and environment variable
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Warning: No GitHub token provided. Please provide a token using --token option or GITHUB_TOKEN environment variable." >&2
  exit 1
fi

# Configuration
VSCODE_VERSION="1.96.0"
COPILOT_VERSION="0.26.7"
EDITOR_PLUGIN_VERSION="copilot-chat/${COPILOT_VERSION}"
USER_AGENT="GitHubCopilotChat/${COPILOT_VERSION}"
API_VERSION="2025-04-01"

echo "Step 1: Getting Copilot token from GitHub API..."

# Get Copilot token
COPILOT_TOKEN_RESPONSE=$(curl -s -X GET "https://api.github.com/copilot_internal/v2/token" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "editor-version: vscode/${VSCODE_VERSION}" \
  -H "editor-plugin-version: ${EDITOR_PLUGIN_VERSION}" \
  -H "user-agent: ${USER_AGENT}" \
  -H "x-github-api-version: ${API_VERSION}" \
  -H "x-vscode-user-agent-library-version: electron-fetch")

# Extract token
COPILOT_TOKEN=$(echo "$COPILOT_TOKEN_RESPONSE" | grep -o '"token":"[^"]*"' | sed 's/"token":"\(.*\)"/\1/')

if [ -z "$COPILOT_TOKEN" ]; then
  echo "Error: Failed to get Copilot token"
  exit 1
fi

echo "✓ Successfully obtained Copilot token"
echo ""
echo "Step 2: Making chat completion request with ${MODEL} model..."
echo ""

# Generate unique request ID
REQUEST_ID=$(uuidgen)

# Make chat completion request
curl -X POST "https://api.githubcopilot.com/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${COPILOT_TOKEN}" \
  -H "copilot-integration-id: vscode-chat" \
  -H "editor-version: vscode/${VSCODE_VERSION}" \
  -H "editor-plugin-version: ${EDITOR_PLUGIN_VERSION}" \
  -H "user-agent: ${USER_AGENT}" \
  -H "openai-intent: conversation-panel" \
  -H "x-github-api-version: ${API_VERSION}" \
  -H "x-request-id: ${REQUEST_ID}" \
  -H "x-vscode-user-agent-library-version: electron-fetch" \
  -H "X-Initiator: user" \
  -d "{
    \"messages\": [
      {
        \"role\": \"user\",
        \"content\": \"Hello! What is 2+2?\"
      }
    ],
    \"model\": \"${MODEL}\",
    \"temperature\": 0.7,
    \"max_tokens\": 1000
  }"

echo ""
echo ""
echo "✓ Request completed successfully"
