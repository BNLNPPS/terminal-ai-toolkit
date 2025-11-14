#!/usr/bin/env python3

"""
pilot-chat.py - Simple Python script to chat with GitHub Copilot API using gpt-5-mini model
"""

import argparse
import json
import os
import sys
import uuid
from pathlib import Path

try:
    import requests
except ImportError:
    print("Error: requests library not found. Installing...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests"])
    import requests


# Configuration
VSCODE_VERSION = "1.96.0"
COPILOT_VERSION = "0.26.7"
EDITOR_PLUGIN_VERSION = f"copilot-chat/{COPILOT_VERSION}"
USER_AGENT = f"GitHubCopilotChat/{COPILOT_VERSION}"
API_VERSION = "2025-04-01"


def get_github_token(args=None):
    """Get GitHub token from command line args, environment variable, or print error and exit"""
    github_token = None

    # Check if token was provided via --token option
    if args and hasattr(args, 'token') and args.token:
        github_token = args.token
    elif not github_token:
        # Check if token is in environment variable GITHUB_TOKEN
        github_token = os.environ.get('GITHUB_TOKEN')

    if not github_token:
        print("Warning: No GitHub token provided. Please provide a token using --token option or GITHUB_TOKEN environment variable.", file=sys.stderr)
        sys.exit(1)

    return github_token


def get_copilot_token(github_token):
    """Exchange GitHub token for Copilot token"""
    print("Step 1: Getting Copilot token from GitHub API...")
    
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": f"token {github_token}",
        "editor-version": f"vscode/{VSCODE_VERSION}",
        "editor-plugin-version": EDITOR_PLUGIN_VERSION,
        "user-agent": USER_AGENT,
        "x-github-api-version": API_VERSION,
        "x-vscode-user-agent-library-version": "electron-fetch",
    }
    
    response = requests.get(
        "https://api.github.com/copilot_internal/v2/token",
        headers=headers
    )
    
    if not response.ok:
        print(f"Error: Failed to get Copilot token. Status: {response.status_code}")
        print(response.text)
        sys.exit(1)
    
    data = response.json()
    print("✓ Successfully obtained Copilot token\n")
    return data["token"]


def chat_completion(copilot_token, message, model="gpt-5-mini", temperature=0.7, max_tokens=1000):
    """Make a chat completion request to GitHub Copilot API"""
    print(f"Step 2: Making chat completion request with {model} model...")
    print(f"User: {message}\n")
    
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {copilot_token}",
        "copilot-integration-id": "vscode-chat",
        "editor-version": f"vscode/{VSCODE_VERSION}",
        "editor-plugin-version": EDITOR_PLUGIN_VERSION,
        "user-agent": USER_AGENT,
        "openai-intent": "conversation-panel",
        "x-github-api-version": API_VERSION,
        "x-request-id": str(uuid.uuid4()),
        "x-vscode-user-agent-library-version": "electron-fetch",
        "X-Initiator": "user",
    }
    
    payload = {
        "messages": [
            {
                "role": "user",
                "content": message
            }
        ],
        "model": model,
        "temperature": temperature,
        "max_tokens": max_tokens,
    }
    
    response = requests.post(
        "https://api.githubcopilot.com/chat/completions",
        headers=headers,
        json=payload
    )
    
    if not response.ok:
        print(f"Error: Failed to get chat completion. Status: {response.status_code}")
        print(response.text)
        sys.exit(1)
    
    return response.json()


def main():
    """Main function"""
    # Set up argument parser
    parser = argparse.ArgumentParser(
        description="Chat with GitHub Copilot API using gpt-5-mini model"
    )
    parser.add_argument("--token", help="GitHub token to use for authentication")
    parser.add_argument("--model", default="gpt-5-mini", help="Model to use for chat completion (default: gpt-5-mini)")
    parser.add_argument("message", nargs="*", help="Message to send to Copilot (or use default)")

    # Parse arguments
    args = parser.parse_args()

    # Get GitHub token
    github_token = get_github_token(args)

    # Get Copilot token
    copilot_token = get_copilot_token(github_token)

    # Get user message from command line or use default
    if args.message:
        message = " ".join(args.message)
    else:
        message = "Hello! What is 2+2?"

    # Make chat completion request with specified model
    result = chat_completion(copilot_token, message, model=args.model)

    # Display response
    assistant_message = result["choices"][0]["message"]["content"]
    print(f"Assistant: {assistant_message}\n")

    # Display token usage
    usage = result.get("usage", {})
    if usage:
        print(f"Token usage: {usage.get('total_tokens', 0)} total "
              f"({usage.get('prompt_tokens', 0)} prompt + "
              f"{usage.get('completion_tokens', 0)} completion)")

    print("\n✓ Request completed successfully")

    # Return full response for programmatic use
    return result


if __name__ == "__main__":
    main()
