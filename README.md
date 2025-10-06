<div align="center">

# 🛠️ Terminal AI Toolkit

*Supercharge your terminal with AI-powered tools and scripts*

[![Awesome](https://img.shields.io/badge/Awesome-Terminals--AI-orange?logo=awesome-lists)](https://github.com/BNLNPPS/awesome-terminals-ai)
[![Scripts](https://img.shields.io/badge/Scripts-Included-green?logo=gnu-bash)](./scripts/)

</div>

---

## 🌟 Overview

This repository is your **comprehensive guide** to getting the most out of AI tools in your terminal. It contains curated scripts, expert tips, and detailed guides for terminal-based AI development.

> **💡 Pro Tip:** This is a companion to the [awesome-terminals-ai](https://github.com/BNLNPPS/awesome-terminals-ai) list—your one-stop resource for terminal AI tools!

---

## 📜 Scripts

Useful scripts to enhance your AI terminal workflow:

| Script | Description | Guide |
|:-------|:------------|:------|
| 📊 **copilot-usage.sh** | Check your GitHub Copilot usage and quota | [Copilot CLI Guide](Copilot.md) |
| 🤖 **run-claude-copilot.sh** | Run Claude Code with GitHub Copilot models | See below ⬇️ |

---

## 🆓 Free API Providers

### 💎 Gemini API

Access powerful Google Gemini models with generous free tier limits:

| Feature | Free Tier |
|:--------|:----------|
| 🚀 **Model** | Gemini 2.5 Pro |
| ⚡ **Rate Limit** | 5 requests/minute |
| 📅 **Daily Limit** | 100 requests/day |

- 📚 [Rate Limits Documentation](https://ai.google.dev/gemini-api/docs/rate-limits)
- 🔑 [Create API Key](https://aistudio.google.com/app/apikey)

### 🐙 GitHub Models

GitHub provides two types of AI model access for developers:

<details open>
<summary><b>🤖 GitHub Copilot Models</b></summary>

<br>

**Overview:**
- 🌐 **Endpoint:** `https://api.githubcopilot.com`
- 📖 **Documentation:** [Supported Models](https://docs.github.com/en/copilot/reference/ai-models/supported-models)
- ⚡ **Rate Limits:** 300 premium requests/month (Copilot Pro)

**List available models:**

```bash
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${OAUTH_TOKEN}" \
  https://api.githubcopilot.com/models | jq -r '.data[].id'
```

</details>

<details>
<summary><b>🛒 GitHub Market Models</b></summary>

<br>

**Overview:**
- 🌐 **Endpoint:** `https://models.github.ai/inference`
- 🔍 **Browse:** [GitHub Marketplace Models](https://github.com/marketplace/models)
- 📊 **Rate Limits:** 4k input tokens, 4k output tokens per request

**List available models:**

```bash
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${OAUTH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://models.github.ai/catalog/models | jq -r '.[].id'
```

</details>

### 🔀 OpenRouter

[OpenRouter](https://openrouter.ai/) provides **unified API access** to multiple AI models—try different models using one API to find your best fit!

#### 🆓 Free Models Available

| Model | Link |
|:------|:-----|
| GPT OSS 20B | [Try it](https://openrouter.ai/openai/gpt-oss-20b:free) |
| Qwen3 Coder | [Try it](https://openrouter.ai/qwen/qwen3-coder:free) |
| GLM 4.5 Air | [Try it](https://openrouter.ai/z-ai/glm-4.5-air:free) |
| Kimi K2 | [Try it](https://openrouter.ai/moonshotai/kimi-k2:free) |
| DeepSeek Chat v3.1 | [Try it](https://openrouter.ai/deepseek/deepseek-chat-v3.1:free) |

**Setup:** 🔑 [Generate API Key](https://openrouter.ai/settings/keys)

> **💡 Rate Limits:** 
> - With 10+ credits purchased: 1,000 requests/day
> - Otherwise: 50 requests/day

### ⚡ Groq

[Groq](https://console.groq.com/) offers **high-speed inference** with free tier access.

#### 🆓 Free Models

Available models from [Rate Limits](https://console.groq.com/docs/rate-limits) documentation:

- `openai/gpt-oss-120b`
- `openai/gpt-oss-20b`
- `qwen/qwen3-32b`
- `moonshotai/kimi-k2-instruct-0905`

**Setup:** 🔑 [Generate API Key](https://console.groq.com/keys)

---

## 💻 Local Model Providers

### 🦙 Ollama

**[Ollama](https://ollama.ai/)** - Lightweight framework for running LLMs locally via command line.

**Key Features:**
- ⚡ Simple CLI interface
- 🌐 RESTful API
- 🐳 Docker-like model management
- 🤖 Popular models: LLaMA, Gemma, DeepSeek
- 🔌 OpenAI-compatible API
- 🖥️ Cross-platform support

#### 📊 Ollama Model Performance

**Model Sizes:**

| Model | Size |
|:------|:-----|
| gpt-oss:120b | 65 GB |
| gpt-oss:20b | 13 GB |
| qwen3:8b | 5.2 GB |
| qwen3:30b | 18 GB |

**Performance Benchmark (tokens/second):**

| Machine | gpt-oss:120b | gpt-oss:20b | qwen3:8b | qwen3:30b |
|:--------|:------------:|:-----------:|:--------:|:---------:|
| 🖥️ **Windows PC (Intel i9)** | - | 15 t/s | 12 t/s | 22 t/s |
| 💻 **MacBook Pro (M3 Max)** | - | 70 t/s | 57 t/s | 74 t/s |
| 🖥️ **Linux Server (Dual RTX 4090)** | 36 t/s | 156 t/s | 140 t/s | 163 t/s |

<details>
<summary><b>📋 Machine Specifications</b></summary>

<br>

- **Windows PC (Intel i9):** 
  - CPU: Intel i9-12900
  - GPU: Intel UHD Graphics 770 (2 GB)
  - RAM: 64 GB

- **MacBook Pro (M3 Max):** 
  - Apple M3 Max with 64 GB RAM

- **Linux Server (Dual RTX 4090):** 
  - CPU: Xeon(R) w7-3445 (40 CPUs)
  - GPU: 2 × Nvidia RTX 4090
  - RAM: 128 GB

</details>

### 🖥️ LM Studio

**[LM Studio](https://lmstudio.ai/)** - User-friendly desktop GUI for running local LLMs with no technical setup required.

**Key Features:**
- 🛍️ Model marketplace
- 🌐 OpenAI-compatible API server
- 💬 Chat interface
- 📦 GGUF model support
- 💰 Free for personal & commercial use

---

## 🔀 API Proxies

Most AI tools support OpenAI-compatible APIs. For tools requiring Anthropic-compatible APIs, these solutions provide compatibility:

### 🔄 Claude Code Router

**[Claude Code Router](https://github.com/musistudio/claude-code-router)** - Routes Claude Code requests to different models with request customization.

<details>
<summary><b>📦 Installation (Linux/macOS)</b></summary>

<br>

```bash
# Install Claude Code CLI (prerequisite)
npm install -g @anthropic-ai/claude-code

# Install Claude Code Router
npm install -g @musistudio/claude-code-router
```

</details>

<details>
<summary><b>⚙️ Configuration Examples</b></summary>

<br>

Create `~/.claude-code-router/config.json` with your preferred providers:

```json
{
  "LOG": true,
  "API_TIMEOUT_MS": 600000,
  "Providers": [
    {
      "name": "gemini",
      "api_base_url": "https://generativelanguage.googleapis.com/v1beta/models/",
      "api_key": "$GEMINI_API_KEY",
      "models": ["gemini-2.5-flash", "gemini-2.5-pro"],
      "transformer": { "use": ["gemini"] }
    },
    {
      "name": "openrouter",
      "api_base_url": "https://openrouter.ai/api/v1/chat/completions",
      "api_key": "$OPENROUTER_API_KEY",
      "models": ["google/gemini-2.5-pro-preview", "anthropic/claude-sonnet-4"],
      "transformer": { "use": ["openrouter"] }
    },
    {
      "name": "grok",
      "api_base_url": "https://api.x.ai/v1/chat/completions",
      "api_key": "$GROK_API_KEY",
      "models": ["grok-beta"]
    },
    {
      "name": "github-copilot",
      "api_base_url": "https://api.githubcopilot.com/chat/completions",
      "api_key": "$GITHUB_TOKEN",
      "models": ["gpt-4o", "claude-3-7-sonnet", "o1-preview"]
    },
    {
      "name": "github-marketplace",
      "api_base_url": "https://models.github.ai/inference/chat/completions",
      "api_key": "$GITHUB_TOKEN",
      "models": ["openai/gpt-4o", "openai/o1-preview", "xai/grok-3"]
    },
    {
      "name": "ollama",
      "api_base_url": "http://localhost:11434/v1/chat/completions",
      "api_key": "ollama",
      "models": ["qwen3:30b", "gpt-oss:20b", "llama3.2:latest"]
    }
  ],
  "Router": {
    "default": "gemini,gemini-2.5-flash",
    "background": "ollama,qwen3:30b",
    "longContext": "openrouter,google/gemini-2.5-pro-preview"
  }
}
```

</details>

<details>
<summary><b>💻 Usage Commands</b></summary>

<br>

```bash
# Start Claude Code with router
ccr code

# Use UI mode for configuration
ccr ui

# Restart after config changes
ccr restart

# Switch models dynamically in Claude Code
/model ollama,llama3.2:latest
```

</details>

> **⚠️ Known Issue:** The proxy for Ollama models does not work properly with Claude Code.

### 🌉 Copilot API Bridge

**[copilot-api](https://github.com/ericc-ch/copilot-api)** - Converts GitHub Copilot into OpenAI/Anthropic API compatible server for use with Claude Code.

<details>
<summary><b>🚀 Deployment Example (Singularity/CVMFS)</b></summary>

<br>

The `copilot-api` tool is available in the modern-linuxtools Singularity image on CVMFS:

```bash
# Setup the environment
$ source /cvmfs/atlas.sdcc.bnl.gov/users/yesw/singularity/alma9-x86/modern-linuxtools/setupMe.sh

# Start the API wrapper
$ copilot-api start -c
[...]
  ➜ Listening on: http://130.199.48.146:4141/

# In another terminal, use with Aider
$ export ANTHROPIC_BASE_URL=http://130.199.48.146:4141 && aider --no-git --anthropic-api-key dummy --model anthropic/claude-sonnet-4

# Or use with Claude Code CLI (also included in modern-linuxtools)
$ export ANTHROPIC_BASE_URL=http://130.199.48.146:4141 && claude-code
```

</details>

> **📌 Important Notes:**
> - Use your own URL in `ANTHROPIC_BASE_URL` and remove trailing `/`
> - Enable X11 forwarding when SSH-ing: `ssh -X username@hostname`
> - All GitHub Copilot models (excluding Market models) become accessible

#### 🤖 Automated Setup with `run-claude-copilot.sh`

For a **streamlined experience**, this script automates the entire setup process for using Claude Code with GitHub Copilot models.

**✨ Key Features:**

| Feature | Description |
|:--------|:------------|
| 📦 **Auto Dependency Management** | Installs `nvm`, `npm`, `copilot-api`, and `claude-code` |
| ⚡ **Simplified Usage** | Single command to start fully configured Claude session |
| 🔄 **Model Selection** | Specify which Copilot model to use |
| 🛠️ **Utility Functions** | Check usage, list models, update packages |
| 🔗 **Transparent Args** | Forwards arguments directly to `claude` command |

**💻 Usage Examples:**

```bash
# Run Claude with default settings
./scripts/run-claude-copilot.sh

# List available Copilot models
./scripts/run-claude-copilot.sh --list-models

# Check your Copilot API usage
./scripts/run-claude-copilot.sh --check-usage

# Run Claude with a specific model and pass a prompt
./scripts/run-claude-copilot.sh --model claude-sonnet-4 -- -p "Explain quantum computing"

# Get help on the script's options
./scripts/run-claude-copilot.sh --help

# Get help on Claude's own options
./scripts/run-claude-copilot.sh -- --help
```

---

## 📚 Detailed Tool Guides

Comprehensive documentation for each AI terminal tool:

| Tool | Description | Guide |
|:-----|:------------|:------|
| 🤝 **Aider** | AI pair programming in your terminal | [Read Guide](Aider.md) |
| 🤖 **GitHub Copilot CLI** | Copilot coding agent directly in your terminal | [Read Guide](Copilot.md) |
| 💎 **Gemini CLI** | Google's Gemini in your terminal | [Read Guide](Gemini.md) |
| 🚀 **Qwen Code** | Qwen3-Coder models in your terminal | [Read Guide](Qwen.md) |

---

## 🖥️ AI-Enhanced Terminals

### ⚡ Warp Terminal

**AI-first terminal** that integrates intelligent agents directly into the command line.

**✨ Key Features:**

<table>
<tr>
<td width="50%">

#### 💬 Natural Language Commands
Generate commands with `#` trigger

</td>
<td width="50%">

#### 🤖 Real-time AI
Autosuggestions and error detection

</td>
</tr>
<tr>
<td width="50%">

#### 🎤 Voice Commands
Multi-agent parallel workflows

</td>
<td width="50%">

#### 🏢 Enterprise Ready
SAML SSO, BYOL, zero data retention

</td>
</tr>
</table>

**📊 Usage Limits:**
- 🆓 Free tier: 150 requests/month
- 💎 Paid plans available for higher usage

**📦 Installation:**

```bash
brew install --cask warp    # macOS
winget install Warp.Warp    # Windows
```

### 🌊 Wave Terminal

**Open-source terminal** that brings graphical capabilities into the command line.

**✨ Key Features:**

<table>
<tr>
<td width="50%">

#### 🖼️ Inline Previews
Images, markdown, CSV, video files

</td>
<td width="50%">

#### 📝 VSCode-like Editor
Integrated editor for remote files

</td>
</tr>
<tr>
<td width="50%">

#### 🌐 Built-in Browser
Web browser and SSH connection manager

</td>
<td width="50%">

#### 📊 Custom Widgets
Dashboard creation capabilities

</td>
</tr>
<tr>
<td colspan="2" align="center">

#### 🖥️ Cross-platform
Local data storage for privacy

</td>
</tr>
</table>

**🤖 AI Integration:**
- ✅ Built-in AI assistance for command suggestions
- ⚙️ Configurable AI models via "Add AI preset..."
- 🦙 Support for Ollama and other local models
- 🎯 Context-aware recommendations

**📦 Installation:**

Download from [waveterm.dev/download](https://waveterm.dev/download)

Available as: Snap, AppImage, .deb, .rpm, and Windows installers

---

<div align="center">

**Made with ❤️ by the Community**

[⭐ Star on GitHub](https://github.com/BNLNPPS/terminal-ai-toolkit) | [🐛 Report Issues](https://github.com/BNLNPPS/terminal-ai-toolkit/issues) | [💡 Contribute](https://github.com/BNLNPPS/terminal-ai-toolkit/pulls)

*Supercharge your terminal workflow! 🚀*

</div>
