<div align="center">

# 💎 Gemini CLI

*Open-source AI agent bringing Google's Gemini power to your terminal*

[![GitHub](https://img.shields.io/badge/GitHub-gemini--cli-blue?logo=github)](https://github.com/google-gemini/gemini-cli)

</div>

---

## 🌟 Overview

Gemini CLI is an open-source AI agent that brings the power of **Google's Gemini** directly into your terminal. It's designed for developers who prefer working in command-line environments.

> **💡 Pro Tip:** Access Gemini 2.5 Pro with 1M token context window—perfect for handling massive codebases!

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
Save and resume sessions with custom context files.

</td>
</tr>
<tr>
<td width="50%">

### 🆓 Free Tier Access
60 requests/minute and 1,000 requests/day with personal Google account.

</td>
<td width="50%">

### 🔌 Built-in Tools
File operations, shell commands, web fetching, and search.

</td>
</tr>
<tr>
<td colspan="2" align="center">

### 🚀 MCP Extensibility
Model Context Protocol support for custom integrations.

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
<summary><b>Option 2: Homebrew</b> (macOS/Linux)</summary>

<br>

```bash
brew install google-gemini/tap/gemini
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

---

<div align="center">

**Made with ❤️ by Google**

*Happy Coding! 🚀*

</div>
