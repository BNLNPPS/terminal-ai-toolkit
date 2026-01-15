<div align="center">

# 🤖 GitHub Copilot CLI

*Your AI-powered terminal companion for smarter, faster coding*

[![GitHub](https://img.shields.io/badge/GitHub-copilot--cli-blue?logo=github)](https://github.com/github/copilot-cli)
[![Documentation](https://img.shields.io/badge/Docs-Official-green?logo=github)](https://docs.github.com/copilot/concepts/agents/about-copilot-cli)
[![Stars](https://img.shields.io/badge/Stars-6.6k-yellow?logo=github)](https://github.com/github/copilot-cli/stargazers)
[![Latest Release](https://img.shields.io/badge/Version-v0.0.382-blue?logo=github)](https://github.com/github/copilot-cli/releases/latest)

</div>

---

## 🌟 Overview

> **🚀 Public Preview:** GitHub Copilot CLI is currently in public preview. Expect frequent updates and new features!

GitHub Copilot CLI brings AI-powered coding assistance directly to your command line, enabling you to **build**, **debug**, and **understand** code through natural language conversations. Powered by the same agentic harness as GitHub's Copilot coding agent, it provides intelligent assistance while staying deeply integrated with your GitHub workflow.

> **💡 Pro Tip:** Work entirely in your terminal without context switching—just describe what you need in plain English!

## ✨ Key Features

<table>
<tr>
<td width="50%">

### 🖥️ Terminal-Native Development
Work with Copilot coding agent directly in your command line—no context switching required.

</td>
<td width="50%">

### 🔗 GitHub Integration
Access repositories, issues, and PRs using natural language, authenticated with your GitHub account.

</td>
</tr>
<tr>
<td width="50%">

### 🤖 Agentic Capabilities
Build, edit, debug, and refactor code with an AI collaborator that plans and executes complex tasks.

</td>
<td width="50%">

### 🔌 MCP-Powered Extensibility
Ships with GitHub's MCP server and supports custom MCP servers for extended capabilities.

</td>
</tr>
<tr>
<td colspan="2" align="center">

### 🛡️ Full Control
Preview every action before execution—nothing happens without your explicit approval.

</td>
</tr>
</table>

---

## 🚀 Getting Started

### Prerequisites

> **⚠️ Important:** You need an active Copilot subscription to use this tool.
> 
> 📋 [View Available Plans](https://github.com/features/copilot/plans)

### 📦 Installation

### Supported Platforms

- **Linux**
- **macOS**
- **Windows** (requires PowerShell v6 or higher)

### Installation Methods

<details open>
<summary><b>Option 1: Homebrew (macOS & Linux)</b> 👈 Recommended</summary>

<br>

```bash
# Install stable version
brew install copilot-cli

# Or install prerelease version
brew install copilot-cli@prerelease

# Verify installation
copilot --version
```

</details>

<details>
<summary><b>Option 2: npm (All Platforms)</b></summary>

<br>

If you don't have Node.js installed, first install NVM and Node.js:

```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# Load NVM (add to ~/.bashrc or ~/.zshrc for persistence)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install the latest Node.js version
nvm install node

# Verify installation
npm --version
```

Then install GitHub Copilot CLI:

```bash
# Install stable version
npm install -g @github/copilot

# Or install prerelease version
npm install -g @github/copilot@prerelease

# Verify installation
copilot --version
```

</details>

<details>
<summary><b>Option 3: WinGet (Windows)</b></summary>

<br>

```bash
# Install stable version
winget install GitHub.Copilot

# Or install prerelease version
winget install GitHub.Copilot.Prerelease

# Verify installation
copilot --version
```

</details>

<details>
<summary><b>Option 4: Install Script (macOS & Linux)</b></summary>

<br>

```bash
# Using curl
curl -fsSL https://gh.io/copilot-install | bash

# Or using wget
wget -qO- https://gh.io/copilot-install | bash

# Install as root to /usr/local/bin
curl -fsSL https://gh.io/copilot-install | sudo bash

# Install to custom directory
curl -fsSL https://gh.io/copilot-install | PREFIX="$HOME/custom" bash

# Install specific version
curl -fsSL https://gh.io/copilot-install | VERSION="v0.0.382" bash
```

> **💡 Note:** Use `| sudo bash` to install to `/usr/local/bin`. Set `PREFIX` to install to `$PREFIX/bin/` (defaults to `/usr/local` as root or `$HOME/.local` as non-root). Set `VERSION` to install a specific version.

</details>

### Launch and Authenticate

```bash
# Launch Copilot CLI
copilot
```

On first launch, you'll see an animated banner. If you're not logged in, you'll be prompted to use the `/login` command.

### 🔐 Authentication Options

<details>
<summary><b>Option 1: Interactive Login</b> (Recommended) 👈</summary>

<br>

The easiest way to get started:

```bash
# Launch copilot
copilot

# Inside the CLI, use the login command
/login
```

Follow the on-screen instructions to complete the OAuth authentication flow.

</details>

<details>
<summary><b>Option 2: Personal Access Token (PAT)</b></summary>

<br>

Use a fine-grained PAT with the "Copilot Requests" permission:

1. 🌐 Visit [GitHub Settings → Personal Access Tokens](https://github.com/settings/personal-access-tokens/new)
2. 🔑 Under "Permissions," click "add permissions" and select **"Copilot Requests"**
3. ✅ Generate your token
4. 💾 Add the token to your environment:

```bash
# Add to ~/.bashrc or ~/.zshrc
export GH_TOKEN="ghu_your_token_here"
# or
export GITHUB_TOKEN="ghu_your_token_here"
```

</details>

---

## 🎓 Free Access to GitHub Copilot Pro for Educators

GitHub Education offers **free access to GitHub Copilot Pro** for verified teachers and educators. This provides you with premium features at no cost!

### 📋 Eligibility & Benefits

Teachers and educators can get:
- ✨ **Full GitHub Copilot Pro subscription** at no cost
- 🤖 Access to premium models (claude-sonnet-4.5, gpt-5.1)
- ⚡ Higher premium request limits
- 🎯 All Copilot Pro features

### 🚀 How to Get Free Access

Follow these steps to obtain your free Copilot Pro subscription:

<details open>
<summary><b>Step 1: Apply to GitHub Education as a Teacher</b></summary>

<br>

Visit the GitHub Education application page and submit your teacher verification:

📝 **[Apply to GitHub Education as a Teacher](https://docs.github.com/en/education/explore-the-benefits-of-teaching-and-learning-with-github-education/github-education-for-teachers/apply-to-github-education-as-a-teacher)**

You'll need to provide:
- Proof of academic affiliation
- School-issued email address or other documentation
- Information about how you'll use GitHub in teaching

</details>

<details open>
<summary><b>Step 2: Join GitHub Education</b></summary>

<br>

After your application is approved:
1. 📧 You'll receive an invitation email from GitHub Education
2. ✅ Follow the link in the email to accept and join GitHub Education
3. 🎓 Your account will be verified as an educator

</details>

<details open>
<summary><b>Step 3: Start Your Copilot Pro Trial</b></summary>

<br>

Once you're verified:
1. 🌐 Visit [GitHub Copilot Plans](https://github.com/features/copilot/plans)
2. 💎 Start a free trial of **Copilot Pro**
3. 🎯 Complete the subscription setup

</details>

<details open>
<summary><b>Step 4: Receive Confirmation</b></summary>

<br>

Shortly after starting your trial:
1. 📧 You'll receive an email titled **"Accessing your free Copilot subscription"**
2. 💰 GitHub will send you a refund receipt for your subscription
3. ✨ Your free access is automatically activated—no additional steps needed!

> **🎉 Success!** As a verified educator, you now have free access to GitHub Copilot Pro. The subscription will remain free as long as you maintain your GitHub Education status.

</details>

### 📚 Additional Information

For more details about the free access program:

📖 **[Get Free Access to Copilot Pro](https://docs.github.com/en/copilot/how-tos/manage-your-account/get-free-access-to-copilot-pro)**

> **💡 Note:** You must maintain active GitHub Education status to continue receiving free access. Renew your verification periodically as required by GitHub Education.

---

## 💻 Usage Guide

### 🎯 Quick Start

Launch `copilot` in any directory containing the code you want to work with:

```bash
cd your-project
copilot
```

### 🧠 Model Selection

By default, Copilot uses **claude-sonnet-4.5**. Switch models using the `--model` flag or the `/model` command:

```bash
/model
```

#### Available Models by Subscription

**🆓 Free Subscription:**
- **claude-haiku-4.5** (default)
- gpt-5-mini
- gpt-4.1

**⭐ Pro & Pro+ Subscriptions:**

| Multiplier | Models |
|:-----------|:-------|
| **Default (1x)** | claude-sonnet-4.5 ✓ |
| **Standard (1x)** | claude-sonnet-4, gemini-3-pro-preview |
| | gpt-5.2, gpt-5.1, gpt-5 |
| | gpt-5.2-codex, gpt-5.1-codex-max, gpt-5.1-codex |
| **Budget (0.33x)** | claude-haiku-4.5, gpt-5.1-codex-mini |
| **Premium (3x)** | claude-opus-4.5 |
| **Free (0x)** | gpt-5-mini, gpt-4.1 |

> **📌 Note:** Model multipliers affect premium request consumption: 0x (free), 0.33x (budget), 1x (standard), 3x (premium).
>
> **🔧 Important:** All models need to be enabled at [GitHub Copilot Features Settings](https://github.com/settings/copilot/features) before they become available for use. If you select a disabled model, `copilot` will prompt you to enable it from the command line.

### 🎨 Common Use Cases

<details open>
<summary><b>💡 Code Development</b></summary>

<br>

```plaintext
"Create a REST API endpoint for user management"
"Add error handling to this function"
"Refactor this code to use async/await"
"Generate unit tests for the authentication module"
```

</details>

<details>
<summary><b>🔍 Codebase Exploration</b></summary>

<br>

```plaintext
"Describe the main pieces of this system's architecture"
"What are the key dependencies and how do they interact?"
"Find all API endpoints and their authentication methods"
```

</details>

<details>
<summary><b>🐛 Debugging & Analysis</b></summary>

<br>

```plaintext
"Why is this function throwing an error?"
"Identify performance bottlenecks in this component"
"Check for potential security vulnerabilities"
```

</details>

<details>
<summary><b>🔗 GitHub Integration</b></summary>

<br>

```plaintext
"Show me the open issues assigned to me"
"Create a pull request with my current changes"
"Summarize the latest commits in this repository"
```

</details>

### ⚡ Essential Slash Commands

| Command | Description |
|:--------|:------------|
| `/login` | 🔐 Authenticate with GitHub |
| `/logout` | 👋 Sign out from your GitHub account |
| `/model` | 🧠 Select a different AI model |
| `/feedback` | 📝 Submit confidential feedback survey |
| `/help` | ❓ Show available commands |

---

## 🛠️ Command-Line Options

GitHub Copilot CLI provides extensive command-line options for controlling behavior, permissions, and integrations.

### 🚀 Basic Usage Patterns

<details open>
<summary><b>Interactive Mode</b></summary>

<br>

```bash
# Start interactive mode
copilot

# Start interactive mode with an initial prompt
copilot -i "Fix the bug in main.js"

# Start with specific model
copilot --model gpt-5

# Resume most recent session
copilot --continue

# Resume a previous session (shows picker)
copilot --resume

# Resume specific session by ID
copilot --resume session-id-here
```

</details>

<details>
<summary><b>Non-Interactive Mode</b></summary>

<br>

```bash
# Execute a single prompt (exits after completion)
copilot -p "Fix the bug in main.js" --allow-all-tools

# Silent mode (output only the agent response, no stats)
copilot -p "What is the purpose of main.js?" --silent

# Non-interactive with all permissions enabled
copilot -p "Refactor the code" --allow-all
copilot -p "Refactor the code" --yolo  # Same as --allow-all

# Share session to markdown file after completion
copilot -p "Add error handling" --share ./session.md

# Share session to GitHub Gist
copilot -p "Add tests" --share-gist --allow-all
```

</details>

### 🔐 Permission Management

<details>
<summary><b>Tool Permissions</b></summary>

<br>

```bash
# Allow all tools to run automatically (required for non-interactive mode)
copilot --allow-all-tools

# Allow specific tools
copilot --allow-tool write --allow-tool 'shell(git:*)'

# Allow all git commands except git push
copilot --allow-tool 'shell(git:*)' --deny-tool 'shell(git push)'

# Deny specific tools (takes precedence over allow)
copilot --deny-tool 'MyMCP(dangerous_tool)'

# Allow specific MCP server's all tools except one
copilot --deny-tool 'MyMCP(denied_tool)' --allow-tool 'MyMCP'

# Only make specific tools available to the model
copilot --available-tools write --available-tools read

# Exclude specific tools from the model
copilot --excluded-tools dangerous_command
```

</details>

<details>
<summary><b>File & Directory Access</b></summary>

<br>

```bash
# Add additional directories to allowed list
copilot --add-dir /home/user/projects

# Add multiple directories
copilot --add-dir ~/workspace --add-dir /tmp

# Allow access to any path (disable verification)
copilot --allow-all-paths

# Prevent automatic access to system temp directory
copilot --disallow-temp-dir
```

</details>

<details>
<summary><b>URL Access Control</b></summary>

<br>

```bash
# Allow specific URLs or domains (defaults to HTTPS)
copilot --allow-url github.com

# Allow multiple URLs
copilot --allow-url github.com --allow-url api.example.com

# Deny specific URLs (takes precedence over allow)
copilot --deny-url https://malicious-site.com
copilot --deny-url malicious-site.com

# Allow all URLs without confirmation
copilot --allow-all-urls
```

</details>

<details>
<summary><b>All Permissions Shortcuts</b></summary>

<br>

```bash
# Enable all permissions (tools + paths + URLs)
copilot --allow-all
copilot --yolo  # Same as --allow-all

# Equivalent to:
copilot --allow-all-tools --allow-all-paths --allow-all-urls
```

</details>

### 🔌 MCP Server Configuration

<details>
<summary><b>GitHub MCP Server</b></summary>

<br>

```bash
# Enable all GitHub MCP server tools (instead of default CLI subset)
copilot --enable-all-github-mcp-tools

# Add specific tools to GitHub MCP server
copilot --add-github-mcp-tool search_issues

# Add multiple tools
copilot --add-github-mcp-tool search_issues --add-github-mcp-tool create_pr

# Enable all tools using wildcard
copilot --add-github-mcp-tool '*'

# Add toolsets instead of individual tools
copilot --add-github-mcp-toolset issues --add-github-mcp-toolset prs

# Enable all toolsets
copilot --add-github-mcp-toolset all
```

</details>

<details>
<summary><b>Custom MCP Servers</b></summary>

<br>

```bash
# Add additional MCP server configuration (JSON string)
copilot --additional-mcp-config '{"server": "config"}'

# Load from file (prefix with @)
copilot --additional-mcp-config @/path/to/config.json

# Multiple configurations
copilot --additional-mcp-config @config1.json --additional-mcp-config @config2.json

# Disable all built-in MCP servers
copilot --disable-builtin-mcps

# Disable specific MCP server
copilot --disable-mcp-server github-mcp-server
```

> **💡 Note:** Additional MCP configs augment the configuration from `~/.copilot/mcp-config.json` for the current session.

</details>

### ⚙️ General Options

<details>
<summary><b>Configuration & Customization</b></summary>

<br>

```bash
# Use custom configuration directory
copilot --config-dir /path/to/config

# Use specific agent
copilot --agent custom-agent-name

# Disable custom instructions from AGENTS.md
copilot --no-custom-instructions

# Disable automatic CLI updates
copilot --no-auto-update

# Show startup banner
copilot --banner
```

</details>

<details>
<summary><b>Output & Display</b></summary>

<br>

```bash
# Disable all color output
copilot --no-color

# Disable rich diff rendering
copilot --plain-diff

# Enable screen reader optimizations
copilot --screen-reader

# Control streaming mode
copilot --stream on
copilot --stream off
```

</details>

<details>
<summary><b>Logging & Debugging</b></summary>

<br>

```bash
# Set custom log directory
copilot --log-dir /path/to/logs

# Set log level
copilot --log-level debug
copilot --log-level error
copilot --log-level none

# Available log levels: none, error, warning, info, debug, all, default
```

</details>

<details>
<summary><b>Tool Execution</b></summary>

<br>

```bash
# Disable parallel tool execution
# (LLM can still make parallel calls, but they execute sequentially)
copilot --disable-parallel-tools-execution
```

</details>

### 📚 Help Topics

Access detailed help on specific topics:

```bash
# General help
copilot --help
copilot help

# Configuration settings
copilot help config

# Interactive mode commands
copilot help commands

# Environment variables
copilot help environment

# Logging information
copilot help logging

# Permissions details
copilot help permissions
```

### 🎯 Common Usage Examples

```bash
# Quick bug fix with auto-approval
copilot -p "Fix the bug in main.js" --yolo

# Code review with specific model
copilot --model claude-opus-4.5 -i "Review my recent changes"

# Batch processing with session sharing
copilot -p "Refactor all API endpoints" --allow-all --share-gist

# Restricted access for security
copilot --allow-tool read --deny-url '*' --add-dir ./src

# Resume with full permissions
copilot --continue --allow-all

# Custom MCP integration
copilot --additional-mcp-config @my-tools.json --enable-all-github-mcp-tools
```

---

## 📊 Premium Requests & Quotas

Each prompt submitted to GitHub Copilot CLI consumes **one premium request** from your monthly quota.

### Subscription Tiers

**Available Models:**
- **Free Subscription:** claude-haiku-4.5 (default), gpt-5-mini, gpt-4.1
- **Pro & Pro+ Subscriptions:** claude-sonnet-4.5 (default, 1x), claude-sonnet-4 (1x), gpt-5.2-codex (1x), gpt-5.1-codex-max (1x), gpt-5.1-codex (1x), gpt-5.2 (1x), gpt-5.1 (1x), gpt-5 (1x), gemini-3-pro-preview (1x), claude-haiku-4.5 (0.33x), gpt-5.1-codex-mini (0.33x), claude-opus-4.5 (3x), gpt-5-mini (0x), gpt-4.1 (0x)

| Tier | Monthly Premium Requests | Best For |
|:-----|:------------------------|:---------|
| 🆓 **Individual/Free** | 50 | Personal projects & learning |
| ⭐ **Individual/Pro** | 300 | Active development work |
| 💎 **Individual/Pro+** | 1,500 | Heavy usage & large projects |

> 📚 Learn more: [About Premium Requests](https://docs.github.com/copilot/managing-copilot/monitoring-usage-and-entitlements/about-premium-requests)

---

## 📈 Monitoring Your Usage

### 🛠️ Using the `copilot-usage.sh` Script

This repository includes a powerful script to monitor your GitHub Copilot usage:

```bash
./scripts/copilot-usage.sh
```

#### ✨ Features

- ✅ Shows subscription type (Individual, Business, Enterprise)
- 🤖 Shows available models for your subscription
- 📊 Displays used/remaining monthly premium requests
- 📅 Shows next quota reset date
- 🎨 Color-coded output with warning indicators
- 📄 Supports plain text output with `--no-color`
- 💡 Shows installation instructions if `copilot` is not available

#### 📖 Usage Examples

```bash
# Basic usage
./scripts/copilot-usage.sh

# Plain text output (no colors)
./scripts/copilot-usage.sh --no-color

# Verbose output for debugging
./scripts/copilot-usage.sh --verbose

# Show help
./scripts/copilot-usage.sh --help

# Show script version
./scripts/copilot-usage.sh --version
```

#### 📋 Requirements

- ✅ The `copilot` command must be installed
- 🔑 Valid GitHub authentication (`GH_TOKEN` or `GITHUB_TOKEN` starting with `ghu_`)
- 🔧 `jq` for JSON parsing

#### 🔐 Authentication Priority

The script checks for authentication in this order:

1. `GH_TOKEN` environment variable
2. `GITHUB_TOKEN` environment variable
3. Token from `~/.copilot/config.json`
4. OAuth device flow (interactive)

#### 📸 Example Output

```
📊 GitHub Copilot Usage Information
════════════════════════════════════════════════════════════
  👤 User: yourusername
════════════════════════════════════════════════════════════

📅 Next Reset Date: 2025-12-01T00:00:00Z

📋 Subscription: copilot_pro 💎

Available Models:
  claude-sonnet-4.5, claude-sonnet-4, claude-haiku-4.5
  gpt-5, gpt-5.1, gpt-5.1-codex-mini, gpt-5.1-codex
  gemini-3-pro-preview

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ⚡ Premium Interactions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Monthly Quota: 300
  Used:          67

  ⚡ Remaining Premium Requests: 233

════════════════════════════════════════════════════════════
```

---

## 💡 Tips & Best Practices

<table>
<tr>
<td width="33%">

### 🔄 Keep Updated
```bash
# npm
npm update -g @github/copilot

# Homebrew
brew upgrade copilot-cli

# WinGet
winget upgrade GitHub.Copilot
```
Run regularly for latest features and fixes.

</td>
<td width="33%">

### 📂 Context Matters
Launch `copilot` in your project directory for better context awareness.

</td>
<td width="33%">

### 🎯 Be Specific
Provide clear, detailed prompts for optimal results.

</td>
</tr>
<tr>
<td width="33%">

### 👀 Review First
Always review suggested changes before accepting them.

</td>
<td width="33%">

### ⚡ Master Shortcuts
Use `-p` for quick tasks, `-i` for interactive sessions, and `--yolo` when you trust the agent.

</td>
<td width="33%">

### 📊 Monitor Usage
Track your quota with the `copilot-usage.sh` script.

</td>
</tr>
<tr>
<td width="33%">

### 🔒 Control Permissions
Start with restricted permissions and expand as needed using `--allow-tool` and `--allow-url`.

</td>
<td width="33%">

### 💾 Session Management
Use `--continue` to resume work and `--share` to save sessions for documentation.

</td>
<td width="33%">

### 🔌 Extend with MCP
Leverage MCP servers to add custom tools and integrations.

</td>
</tr>
<tr>
<td colspan="3" align="center">

### 💬 Give Feedback
Use `/feedback` to help improve the tool—your input matters! Also visit [GitHub Discussions](https://github.com/github/copilot-cli/discussions) for community support.

</td>
</tr>
</table>

---

## 🔧 Troubleshooting

<details>
<summary><b>🔐 Authentication Issues</b></summary>

<br>

If you encounter authentication problems, try these steps:

```bash
# Log out and log back in
copilot
/logout
/login

# Or use a GitHub token
export GH_TOKEN="ghu_your_token_here"
```

**Common Solutions:**
- Ensure your token starts with `ghu_`
- Verify token has "Copilot Requests" permission
- Check token hasn't expired

</details>

<details>
<summary><b>💾 Installation Problems</b></summary>

<br>

```bash
# Reinstall with cache clean
npm cache clean --force
npm uninstall -g @github/copilot
npm install -g @github/copilot

# Check Node.js version (requires v20+)
node --version
```

</details>

<details>
<summary><b>🐌 Performance Issues</b></summary>

<br>

- Launch in a smaller directory scope
- Avoid extremely large codebases (>100MB)
- Check your internet connection
- Try switching to a different model with `/model`

</details>

---

## 📚 Additional Resources

<div align="center">

| Resource | Description |
|:---------|:------------|
| 📖 [Official Documentation](https://docs.github.com/copilot/concepts/agents/about-copilot-cli) | Complete reference guide |
| 🐙 [GitHub Repository](https://github.com/github/copilot-cli) | Source code & issues |
| 💬 [Discussions](https://github.com/github/copilot-cli/discussions) | Community forum & support |
| 🐛 [Issues](https://github.com/github/copilot-cli/issues) | Bug reports & feature requests |
| 📝 [Changelog](https://github.com/github/copilot-cli/blob/main/changelog.md) | Release notes & updates |
| 💳 [Copilot Plans](https://github.com/features/copilot/plans) | Subscription options |
| 💰 [Individual Plans & Benefits](https://docs.github.com/en/copilot/concepts/billing/individual-plans) | Detailed pricing info |
| ⚡ [About Premium Requests](https://docs.github.com/copilot/managing-copilot/monitoring-usage-and-entitlements/about-premium-requests) | Usage & quota details |
| 🔀 [Model Multipliers](https://docs.github.com/en/copilot/concepts/billing/copilot-requests#model-multipliers) | Models with zero multiplier (not counted toward premium usage) |

</div>

---

<div align="center">

**Made with ❤️ by GitHub**

*Happy Coding! 🚀*

</div>
