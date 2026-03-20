<div align="center">

# 💎 Gemini CLI

*Open-source AI agent bringing Google's Gemini power to your terminal*

[![GitHub](https://img.shields.io/badge/GitHub-gemini--cli-blue?logo=github)](https://github.com/google-gemini/gemini-cli)

</div>

---

## 🌟 Overview

Gemini CLI is an open-source AI agent that brings the power of **Google's Gemini** directly into your terminal. It's designed for developers who prefer working in command-line environments.

> **💡 Pro Tip:** Access Gemini 3 models with 1M token context window—perfect for handling massive codebases!

## ✨ Key Features

<table>
<tr>
<td width="50%">

### 💻 Code Understanding & Generation
Query and edit large codebases, generate apps from PDFs, images, and sketches.

</td>
<td width="50%">

### ⚙️ Automation & Integration
Automate tasks, use MCP servers, and run in non-interactive mode.

</td>
</tr>
<tr>
<td width="50%">

### 🔍 Google Search Grounding
Real-time information with Google Search integration.

</td>
<td width="50%">

### 💾 Conversation Checkpointing
Save and resume sessions with custom context files (GEMINI.md).

</td>
</tr>
<tr>
<td width="50%">

### 🆓 Free Tier Access
- **Rate Limits:** 60 requests/minute and 1,000 requests/day with personal Google account
- Reference: https://geminicli.com/docs/resources/quota-and-pricing/

> [!NOTE]
> The generous 60 RPM / 1,000 RPD limits apply specifically to the Gemini 2.5 Pro and Gemini 2.5 Flash models when using the Gemini CLI with a personal Google account.
>
> **Preview Models:** Gemini 3 models are currently in "Preview" and subject to tighter constraints.

</td>
<td width="50%">

### 🔌 Built-in Tools
File operations, shell commands, web fetching, and Google Search grounding.

</td>
</tr>
<tr>
<td width="50%">

### 🚀 MCP Extensibility
Model Context Protocol support for custom integrations.

</td>
<td width="50%">

### 🧩 Extensions & Hooks
Custom extensions, skills, and hooks for tailored workflows.

</td>
</tr>
</table>

---

## 🚀 Installation

### Prerequisites

> **📋 Requirement:** Node.js version 20 or higher

### 📦 Installation Options

<details open>
<summary><b>Option 1: NPM Installation</b> (Recommended) 👈</summary>

<br>

```bash
npm install -g @google/gemini-cli
```

</details>

<details>
<summary><b>Option 2: Run instantly with npx</b></summary>

<br>

```bash
npx @google/gemini-cli
```

</details>

<details>
<summary><b>Option 3: Homebrew</b> (macOS/Linux)</summary>

<br>

```bash
brew install gemini-cli
```

</details>

<details>
<summary><b>Option 4: MacPorts</b> (macOS)</summary>

<br>

```bash
sudo port install gemini-cli
```

</details>

<details>
<summary><b>Option 5: Anaconda</b> (for restricted environments)</summary>

<br>

```bash
conda create -y -n gemini_env -c conda-forge nodejs
conda activate gemini_env
npm install -g @google/gemini-cli
```

</details>

---

## 🔐 Authentication Options

| Method | Best For | Features |
|:-------|:---------|:---------|
| 🔑 **OAuth Login** | Individual developers | Google account authentication |
| 🔐 **Gemini API Key** | Specific model control | Direct API access |
| 🏢 **Vertex AI** | Enterprise teams | Advanced security & compliance |

> **⚠️ Note:** Under Google account authentication, the model may automatically switch to the *flash* model after a few prompts.

---

## 💻 Usage Guide

### 🎯 Quick Start

```bash
gemini
```

### 🎨 Common Use Cases

<details open>
<summary><b>🔍 Codebase Exploration</b></summary>

<br>

```plaintext
"Explain how the authentication system works in this project"
"Find all API endpoints and their rate limits"
"What are the key dependencies and how do they interact?"
```

</details>

<details>
<summary><b>💡 Code Development</b></summary>

<br>

```plaintext
"Generate a new React component for user profiles"
"Refactor this function to improve readability"
"Create unit tests for the payment processing module"
```

</details>

<details>
<summary><b>⚙️ Workflow Automation</b></summary>

<br>

```plaintext
"Automate the process of updating dependencies"
"Run a security audit on all package.json files"
"Format all code according to project standards"
```

</details>

<details>
<summary><b>🐛 Debugging & Analysis</b></summary>

<br>

```plaintext
"Help me understand this error log"
"Identify potential performance bottlenecks"
"Check for security vulnerabilities in this code"
```

</details>

### 🛠️ CLI Reference

| Flag | Description |
|:-----|:------------|
| `-m, --model` | Specify the model to use |
| `-p, --prompt` | Run in non-interactive (headless) mode |
| `-i, --prompt-interactive` | Execute prompt and continue in interactive mode |
| `-y, --yolo` | Automatically accept all actions |
| `--approval-mode` | Set approval mode (`default`, `auto_edit`, `yolo`, `plan`) |
| `--policy` | Additional policy files or directories to load |
| `-r, --resume` | Resume a previous session (`latest` or index number) |
| `--list-sessions` | List available sessions and exit |
| `--delete-session` | Delete a session by index number |
| `--include-directories` | Add additional directories to workspace context |
| `-e, --extensions` | Specify extensions to use |
| `-l, --list-extensions` | List all available extensions and exit |
| `-s, --sandbox` | Run in sandbox mode |
| `-o, --output-format` | Set output format (`text`, `json`, `stream-json`) |
| `--raw-output` | Disable sanitization of model output |
| `--screen-reader` | Enable screen reader mode for accessibility |
| `-d, --debug` | Run in debug mode |
| `--allowed-mcp-server-names` | Specify allowed MCP server names |

#### Subcommands

| Command | Description |
|:--------|:------------|
| `gemini mcp` | Manage MCP servers |
| `gemini extensions` | Manage Gemini CLI extensions |
| `gemini skills` | Manage agent skills |
| `gemini hooks` | Manage Gemini CLI hooks |

### 🎨 Approval Modes

| Mode | Description |
|:-----|:------------|
| `default` | Prompt for approval before each action |
| `auto_edit` | Auto-approve edit tools, prompt for others |
| `yolo` | Auto-approve all tools |
| `plan` | Read-only mode (no changes) |

```bash
gemini --approval-mode auto_edit
gemini --approval-mode plan
```

### 🔗 GitHub Integration

Gemini CLI integrates with GitHub workflows via the [Gemini CLI GitHub Action](https://github.com/google-github-actions/run-gemini-cli):

- **Pull Request Reviews**: Automated code review with contextual feedback
- **Issue Triage**: Automated labeling and prioritization
- **On-demand Assistance**: Mention `@gemini-cli` in issues and PRs
- **Custom Workflows**: Build automated workflows tailored to your team


---

<div align="center">

**Made with ❤️ by Google**

*Happy Coding! 🚀*

</div>
