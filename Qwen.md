<div align="center">

# 🚀 Qwen Code

*Powerful CLI tool for intelligent code understanding and editing*

[![GitHub](https://img.shields.io/badge/GitHub-qwen--code-blue?logo=github)](https://github.com/QwenLM/qwen-code)

</div>

---

## 🌟 Overview

Qwen Code is an open-source AI agent for the terminal, optimized for **Qwen 3.6 Plus** models. It helps you understand large codebases, automate tedious work, and ship faster. Based on [Gemini CLI](https://github.com/google-gemini/gemini-cli), Qwen Code focuses on parser-level adaptations to better support Qwen models.

> **💡 Pro Tip:** Use OpenRouter, Fireworks AI, or Alibaba Cloud ModelStudio for free API access—no upfront cost required!

## ✨ Key Features

<table>
<tr>
<td width="50%">

### 📝 Code Understanding & Editing
Query and edit large codebases beyond traditional context window limits.

</td>
<td width="50%">

### ⚙️ Workflow Automation
Automate operational tasks like handling pull requests and complex rebases.

</td>
</tr>
<tr>
<td width="50%">

### 🔌 Multi-Protocol Support
Supports OpenAI, Anthropic, Gemini, and Vertex AI compatible APIs.

</td>
<td width="50%">

### 💾 Session Management
Continue and resume sessions with configurable session limits.

</td>
</tr>
<tr>
<td width="50%">

### 🖥️ IDE Integration
Works with VS Code, Zed, and JetBrains IDEs.

</td>
<td width="50%">

### 🧩 Extensions & MCP
Extensible with custom extensions and MCP server integration.

</td>
</tr>
</table>

---

## 🚀 Installation

### Prerequisites

> **📋 Requirement:** Node.js version 20 or higher

### 📦 Installation Options

<details open>
<summary><b>Option 1: Quick Install Script</b> (Recommended) 👈</summary>

<br>

**Linux / macOS:**
```bash
curl -fsSL https://qwen-code-assets.oss-cn-hangzhou.aliyuncs.com/installation/install-qwen.sh | bash
```

**Windows (Run as Administrator CMD):**
```cmd
curl -fsSL -o %TEMP%\install-qwen.bat https://qwen-code-assets.oss-cn-hangzhou.aliyuncs.com/installation/install-qwen.bat && %TEMP%\install-qwen.bat
```

> **Note:** Restart your terminal after installation to ensure environment variables take effect.

</details>

<details>
<summary><b>Option 2: NPM Installation</b></summary>

<br>

```bash
npm install -g @qwen-code/qwen-code@latest
qwen --version
```

</details>

<details>
<summary><b>Option 3: From Source</b></summary>

<br>

```bash
git clone https://github.com/QwenLM/qwen-code.git
cd qwen-code
npm install
npm install -g .
```

</details>

<details>
<summary><b>Option 4: Homebrew</b> (macOS/Linux)</summary>

<br>

```bash
brew install qwen-code
```

</details>

---

## 💻 Usage Guide

### 🎯 Quick Start

```bash
qwen
```

### 🎨 Common Use Cases

<details open>
<summary><b>🔍 Codebase Exploration</b></summary>

<br>

```plaintext
"Describe the main pieces of this system's architecture"
"What are the key dependencies and how do they interact?"
"Find all API endpoints and their authentication methods"
```

</details>

<details>
<summary><b>💡 Code Development</b></summary>

<br>

```plaintext
"Refactor this function to improve readability and performance"
"Create a REST API endpoint for user management"
"Generate unit tests for the authentication module"
```

</details>

<details>
<summary><b>⚙️ Workflow Automation</b></summary>

<br>

```plaintext
"Analyze git commits from the last 7 days, grouped by feature"
"Convert all images in this directory to PNG format"
"Find and remove all console.log statements"
```

</details>

<details>
<summary><b>🐛 Debugging & Analysis</b></summary>

<br>

```plaintext
"Identify performance bottlenecks in this React component"
"Check for potential SQL injection vulnerabilities"
```

</details>

### 🛠️ CLI Reference

| Flag | Description |
|:-----|:------------|
| `-m, --model` | Specify the model to use |
| `-i, --prompt-interactive` | Execute prompt and continue in interactive mode |
| `-y, --yolo` | Automatically accept all actions |
| `--approval-mode` | Set approval mode (`plan`, `default`, `auto-edit`, `yolo`) |
| `-c, --continue` | Resume the most recent session |
| `-r, --resume` | Resume a specific session by ID |
| `--include-directories` | Add additional directories to workspace |
| `-e, --extensions` | Specify extensions to use |
| `-l, --list-extensions` | List all available extensions and exit |
| `-s, --sandbox` | Run in sandbox mode |
| `-o, --output-format` | Set output format (`text`, `json`, `stream-json`) |
| `--screen-reader` | Enable screen reader mode for accessibility |
| `--experimental-lsp` | Enable experimental LSP for code intelligence |
| `--auth-type` | Authentication type (`openai`, `anthropic`, `qwen-oauth`, `gemini`, `vertex-ai`) |
| `--max-session-turns` | Maximum number of session turns |
| `--allowed-tools` | Tools to allow without confirmation |
| `--exclude-tools` | Tools to exclude from the model |
| `--allowed-mcp-server-names` | Specify allowed MCP server names |
| `--acp` | Start agent in ACP mode |
| `--system-prompt` | Override the main session system prompt for this run |
| `--append-system-prompt` | Append instructions to the main session system prompt |
| `--channel` | Channel identifier (`VSCode`, `ACP`, `SDK`, `CI`) |
| `--web-search-default` | Default web search provider (`dashscope`, `tavily`, `google`) |

#### Subcommands

| Command | Description |
|:--------|:------------|
| `qwen mcp` | Manage MCP servers |
| `qwen extensions` | Manage Qwen Code extensions |
| `qwen auth` | Configure Qwen authentication (Qwen-OAuth or Alibaba Cloud Coding Plan) |
| `qwen hooks` | Manage Qwen Code hooks |
| `qwen channel` | Manage messaging channels (Telegram, Discord, etc.) |

#### Session Commands

| Command | Description |
|:--------|:------------|
| `/help` | Display available commands |
| `/auth` | Switch authentication methods |
| `/clear` | Clear conversation history |
| `/compress` | Compress history to save tokens |
| `/stats` | Show current session information |
| `/bug` | Submit a bug report |
| `/exit` or `/quit` | Exit Qwen Code |

### 🎨 Approval Modes

| Mode | Description |
|:-----|:------------|
| `plan` | Read-only planning mode |
| `default` | Prompt for approval before each action |
| `auto-edit` | Auto-approve edit tools, prompt for others |
| `yolo` | Auto-approve all tools |

```bash
qwen --approval-mode auto-edit
qwen --approval-mode plan
```


---

## 🔐 Authentication

Qwen Code supports two authentication methods:

### Qwen OAuth (Recommended & Free)

Start `qwen`, then run `/auth` and choose **Qwen OAuth** to complete the browser flow. Credentials are cached locally.

> **Note:** In non-interactive or headless environments (e.g., CI, SSH, containers), use the API-KEY method instead.

### API-KEY (Flexible)

Use an API key to connect to any supported provider. Supports multiple protocols:

| Protocol | Providers |
|:---------|:----------|
| `openai` | OpenAI, Alibaba Cloud Bailian, and compatible endpoints |
| `anthropic` | Anthropic |
| `gemini` | Google GenAI |
| `vertex-ai` | Google Cloud Vertex AI |

### Free Tier Options

> **⚠️ Note:** Qwen OAuth free tier has been discontinued as of 2026-04-15. Use the alternatives below.

| Option | Daily Limit | Best For |
|:-------|:-----------|:---------|
| 🌍 **OpenRouter** | Free API calls | International users |
| 🔥 **Fireworks AI** | Free API calls | Alternative provider |
| 🌏 **ModelScope** | Free API calls | Users in China |
| ☁️ **Alibaba Cloud ModelStudio** | Pay-per-use | Higher quotas & production |

### 🖥️ IDE Integration

Qwen Code works inside your favorite editor:

| Editor | Support |
|:-------|:--------|
| **VS Code** | Full integration |
| **Zed** | Full integration |
| **JetBrains IDEs** | Full integration |

### 🎯 Optimization

The tool is specifically optimized for **Qwen 3.6 Plus models** and adapts the Gemini CLI for enhanced code understanding capabilities.

---

<div align="center">

**Made with ❤️ for Developers**

*Happy Coding! 🚀*

</div>