<div align="center">

# 🤖 GitHub Copilot CLI

*Your AI-powered terminal companion for smarter, faster coding*

[![GitHub](https://img.shields.io/badge/GitHub-copilot--cli-blue?logo=github)](https://github.com/github/copilot-cli)
[![Documentation](https://img.shields.io/badge/Docs-Official-green?logo=github)](https://docs.github.com/copilot/concepts/agents/about-copilot-cli)

</div>

---

## 🌟 Overview

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

#### Step 1: Install NVM and Node.js

NVM (Node Version Manager) allows you to easily manage multiple Node.js versions on your system.

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

#### Step 2: Install GitHub Copilot CLI

Once Node.js and npm are installed:

```bash
# Install globally with npm
npm install -g @github/copilot

# Verify installation
copilot --version
```

#### Step 3: Launch and Authenticate

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

## 💻 Usage Guide

### 🎯 Quick Start

Launch `copilot` in any directory containing the code you want to work with:

```bash
cd your-project
copilot
```

### 🧠 Model Selection

By default, Copilot uses **Claude Sonnet 4**. Switch models using the `--model` flag or the `/model` command:

```bash
/model
```

#### Available Models by Subscription

| Subscription Type | Available Models |
|:-----------------|:-----------------|
| 💎 **Non-free** | • Claude Sonnet 4.5<br> • Claude Sonnet 4<br> • GPT-5 |
| 🆓 **Free** | • Claude Sonnet 4<br> • GPT-5 |

> **📌 Note:** Model availability depends on your subscription tier.

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

## 📊 Premium Requests & Quotas

Each prompt submitted to GitHub Copilot CLI consumes **one premium request** from your monthly quota.

### Subscription Tiers

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

📅 Next Reset Date: 2025-11-01T00:00:00Z

📋 Subscription: copilot_pro 💎

🤖 Available Models: Claude Sonnet 4.5, Claude Sonnet 4, GPT-5

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ⚡ Premium Interactions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Monthly Quota: 300
  Used:          125

  ⚡ Remaining Premium Requests: 175

════════════════════════════════════════════════════════════
```

---

## 💡 Tips & Best Practices

<table>
<tr>
<td width="33%">

### 🔄 Keep Updated
```bash
npm update -g @github/copilot
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

### ⚡ Master Slash Commands
Familiarize yourself with shortcuts for quick actions.

</td>
<td width="33%">

### 📊 Monitor Usage
Track your quota with the `copilot-usage.sh` script.

</td>
</tr>
<tr>
<td colspan="3" align="center">

### 💬 Give Feedback
Use `/feedback` to help improve the tool—your input matters!

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
| 💳 [Copilot Plans](https://github.com/features/copilot/plans) | Subscription options |
| 💰 [Individual Plans & Benefits](https://docs.github.com/en/copilot/concepts/billing/individual-plans) | Detailed pricing info |
| ⚡ [About Premium Requests](https://docs.github.com/copilot/managing-copilot/monitoring-usage-and-entitlements/about-premium-requests) | Usage & quota details |

</div>

---

<div align="center">

**Made with ❤️ by GitHub**

*Happy Coding! 🚀*

</div>
