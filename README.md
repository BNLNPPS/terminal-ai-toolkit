<div align="center">

# 🛠️ Terminal AI Toolkit

*Supercharge your terminal with AI-powered tools and scripts*

[![Awesome](https://img.shields.io/badge/Awesome-Terminals--AI-orange?logo=awesome-lists)](https://github.com/BNLNPPS/awesome-terminals-ai)
[![Scripts](https://img.shields.io/badge/Scripts-Included-green?logo=gnu-bash)](./scripts/)

</div>

---

## 📑 Table of Contents

- [🌟 Overview](#-overview)
- [📜 Scripts](#-scripts)
- [🆓 Free API Providers](#-free-api-providers)
  - [💎 Gemini API](#-gemini-api)
  - [🐙 GitHub Models](#-github-models)
    - [🤖 GitHub Copilot Models](#-github-copilot-models)
    - [🛒 GitHub Market Models](#-github-market-models)
  - [🔀 OpenRouter](#-openrouter)
  - [⚡ Groq](#-groq)
  - [🚀 NVIDIA Build](#-nvidia-build)
  - [🦙 Ollama Cloud Models](#-ollama-cloud-models)
- [💻 Local Model Providers](#-local-model-providers)
  - [🦙 Ollama](#-ollama)
  - [🧠 LM Studio](#-lm-studio)
- [🔀 API Proxies](#-api-proxies)
  - [🔄 Claude Code Router](#-claude-code-router)
  - [🌉 Copilot API Bridge](#-copilot-api-bridge)
- [📚 Detailed Tool Guides](#-detailed-tool-guides)
- [🖥️ AI-Enhanced Terminals](#%EF%B8%8F-ai-enhanced-terminals)
  - [⚡ Warp Terminal](#-warp-terminal)
  - [🌊 Wave Terminal](#-wave-terminal)
  - [📟 iTerm2 AI](#-iterm2-ai)
  - [🧩 TmuxAI](#-tmuxai)

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

| Feature | Gemini 2.5 Pro (Free) | Gemini 2.5 Flash (Free) |
|:--------|:----------------------|:------------------------|
| ⚡ **Rate Limit** | 2 requests/minute | 15 requests/minute |
| 📅 **Daily Limit** | 50 requests/day | 1,500 requests/day |

- 📚 [Rate Limits Documentation](https://ai.google.dev/gemini-api/docs/rate-limits)
- 🔑 [Create API Key](https://aistudio.google.com/app/apikey)

### 🐙 GitHub Models

GitHub provides two types of AI model access for developers:

- 🤖 GitHub Copilot Models
- 🛒 GitHub Market Models

#### 🤖 GitHub Copilot Models

**Overview:**
- 🌐 **Endpoint:** `https://api.githubcopilot.com`
- 📖 **Documentation:** [Supported Models](https://docs.github.com/en/copilot/reference/ai-models/supported-models)
- ⚡ **Rate Limits:** see [Individual Plan Comparison](https://docs.github.com/en/copilot/concepts/billing/individual-plans#comparing-plans)

**Premium request limits (per month):**

| Feature             | GitHub Copilot Free | GitHub Copilot Pro | GitHub Copilot Pro+ |
|:--------------------|:--------------------|:-------------------|:--------------------|
| Premium requests    | 0 per month         | 300 per month      | 1,500 per month     |

> ℹ️ Exact limits and availability may change over time—always confirm via the official docs above.

**Model multipliers:**

- 📖 [Model Multipliers Documentation](https://docs.github.com/en/copilot/concepts/billing/copilot-requests#model-multipliers)
- Models (accessible via API) with a **0× multiplier** for non-free plans (not counted toward premium usage): `gpt-4.1`, `gpt-5-mini`, `gpt-4o`

> **⚙️ Note:** Some models need to be enabled at [GitHub Copilot Features Settings](https://github.com/settings/copilot/features) before they become available for use.

> ⚠️ **Integration Note:** The endpoint `https://api.githubcopilot.com` supports OpenAI-compatible interface with GitHub OAuth Access Token (prefixed in `gho_`). However, the open-source proxy **[🌉 Copilot API Bridge](#-copilot-api-bridge)**, authenticated with GitHub User Access Token (prefixed in `ghu_`), provides both OpenAI and Anthropic compatible interfaces.

**List available models:**

```bash
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${OAUTH_TOKEN}" \
  https://api.githubcopilot.com/models | jq -r '.data[].id'
```

#### 🛒 GitHub Market Models

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
| Grok 4.1 Fast | [Try it](https://openrouter.ai/x-ai/grok-4.1-fast:free) |

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

### 🚀 NVIDIA Build

[NVIDIA Build](https://build.nvidia.com/models) provides **free API access** to a wide selection of AI models optimized on NVIDIA infrastructure.

#### 🆓 Example Models Available

| Model | Full Model Name | Link |
|:------|:----------------|:-----|
| Qwen3 Next 80B | `qwen/qwen3-next-80b-a3b-instruct` | [Try it](https://build.nvidia.com/qwen/qwen3-next-80b-a3b-instruct) |
| Qwen3 Coder 480B | `qwen/qwen3-coder-480b-a35b-instruct` | [Try it](https://build.nvidia.com/qwen/qwen3-coder-480b-a35b-instruct) |
| GPT-OSS 120B | `openai/gpt-oss-120b` | [Try it](https://build.nvidia.com/openai/gpt-oss-120b) |
| Kimi K2 Instruct | `moonshotai/kimi-k2-instruct-0905` | [Try it](https://build.nvidia.com/moonshotai/kimi-k2-instruct-0905) |
| DeepSeek V3.1 | `deepseek-ai/deepseek-v3_1` | [Try it](https://build.nvidia.com/deepseek-ai/deepseek-v3_1) |
| MiniMax M2 | `minimaxai/minimax-m2` | [Try it](https://build.nvidia.com/minimaxai/minimax-m2) |

**Setup:**
- 🔑 [Generate API Key](https://build.nvidia.com/settings/api-keys)
- 🔍 [Browse All Models](https://build.nvidia.com/models)

> **💡 Note:** Use the full model name (with namespace) when making API requests.

### 🦙 Ollama Cloud Models

Ollama now provides **cloud-hosted models** via API access, offering powerful AI capabilities without the need for local infrastructure. These models are accessible through a simple API and integrate seamlessly with popular AI coding tools.

**💰 Pricing:**
- 🆓 **Free Plan** - Available with hourly and daily usage limits
- 📈 **Pay-per-use** - No upfront costs or hardware investment required

#### 🆓 Available Cloud Models

> 🔍 [Search all cloud models](https://ollama.com/search?c=cloud)

| Model | Full Name | Use Case |
|:------|:----------|:---------|
| 🤖 **DeepSeek V3.1** | `deepseek-v3.1:671b` | Advanced reasoning and code generation |
| 🔥 **GPT-OSS 20B** | `gpt-oss:20b` | Efficient coding and text tasks |
| 🚀 **GPT-OSS 120B** | `gpt-oss:120b` | High-capacity reasoning and analysis |
| 🌙 **Kimi K2** | `kimi-k2:1t` | Long-context understanding and generation |
| 💻 **Qwen3 Coder** | `qwen3-coder:480b` | Specialized code completion and programming |
| ⚡ **GLM 4.6** | `glm-4.6` | Balanced performance for diverse tasks |
| 🎯 **MiniMax M2** | `minimax-m2` | Optimized for productivity and speed |

#### 🔗 Integration with AI Coding Tools

Ollama Cloud Models integrate seamlessly with popular AI coding tools and IDEs through native integrations and OpenAI-compatible APIs:

**🎯 Supported AI Coding Tools & IDEs:**

| Tool | Integration Type | Documentation |
|:-----|:-----------------|:--------------|
| **VS Code** | Native Extension | [View Guide](https://docs.ollama.com/integrations/vscode) |
| **JetBrains** | Native Plugin | [View Guide](https://docs.ollama.com/integrations/jetbrains) |
| **Codex** | API Integration | [View Guide](https://docs.ollama.com/integrations/codex) |
| **Cline** | API Integration | [View Guide](https://docs.ollama.com/integrations/cline) |
| **Droid** | API Integration | [View Guide](https://docs.ollama.com/integrations/droid) |
| **Goose** | API Integration | [View Guide](https://docs.ollama.com/integrations/goose) |
| **Zed** | Native Extension | [View Guide](https://docs.ollama.com/integrations/zed) |

**Key Benefits:**
- **OpenAI-compatible API** - Use existing OpenAI client libraries
- **Direct terminal integration** - Run queries from command line
- **No local setup required** - Access powerful models via API
- **Cost-effective** - Pay-per-use without hardware investment
- **Zero local storage** - Models run in the cloud

**Example API Usage:**

```bash
# Query via REST API
curl https://api.ollama.ai/v1/chat/completions \
  -H "Authorization: Bearer ${OLLAMA_API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3-coder:480b",
    "messages": [
      {"role": "user", "content": "Write a Python function to parse JSON"}
    ]
  }'
```

**Setup:**
- 🔑 [Generate API Key](https://ollama.ai/cloud)
- 📚 [View Documentation](https://docs.ollama.com/cloud)
- 🆓 **Free Plan Available** - Includes hourly and daily usage limits

> **💡 Pro Tip:** Most integrations support both local and cloud models. For cloud models, append `-cloud` to the model name in your tool's configuration.

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

#### ☁️ Access to Cloud Models

Ollama also provides access to cloud-hosted models via the `ollama` command. Simply append `-cloud` (or `:cloud` for some models) to the model name:

```bash
# Example: Run a cloud-hosted model
ollama run qwen3-coder:480b-cloud
```

For details, see the [🦙 Ollama Cloud Models](#-ollama-cloud-models) section.

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

The GitHub Copilot API (https://api.githubcopilot.com) supports OpenAI-compatible interface with GitHub OAuth Access Token (prefixed in `gho_`).
**[copilot‑api](https://github.com/ericc-ch/copilot-api)**, an open‑source proxy authenticated with GitHub User Access Token (prefixed in `ghu_`),
provides the necessary bridge: it exposes an OpenAI‑compatible interface as well as an Anthropic‑compatible interface,
at the endpoint **https://localhost:4141**.

**Installation and Authentication:**

```bash
# Install copilot-api globally
npm install -g copilot-api

# Device authentication
copilot-api auth

# Start the API proxy
copilot-api start
```

The `copilot-api` tool is also available in specialized environments like the modern-linuxtools Singularity image on CVMFS.

**CVMFS Setup:**

```bash
# Setup the environment
source /cvmfs/atlas.sdcc.bnl.gov/users/yesw/singularity/alma9-x86/modern-linuxtools/setupMe.sh

# Then use copilot-api as normal
copilot-api auth
copilot-api start
```

<details>
<summary><b>💻 Usage Examples</b></summary>

<br>

```bash
# Use with Aider
export ANTHROPIC_BASE_URL=http://localhost:4141 && aider --no-git --anthropic-api-key dummy --model anthropic/claude-sonnet-4.5

# Or use with Claude Code CLI
export ANTHROPIC_BASE_URL=http://localhost:4141 ANTHROPIC_AUTH_TOKEN=dummy ANTHROPIC_MODEL=claude-sonnet-4.5 && claude-code
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

| Feature | Description |
| :--- | :--- |
| 💬 **Natural Language Commands** | Generate commands with `#` trigger |
| 🤖 **Real-time AI** | Autosuggestions and error detection |
| 🎤 **Voice Commands** | Multi-agent parallel workflows |
| 🏢 **Enterprise Ready** | SAML SSO, BYOL, zero data retention |

**📊 Usage Limits:**
- 🆓 Free tier: 150 requests/month
- 💎 Paid plans available for higher usage

**📦 Installation:**

```bash
brew install --cask warp    # macOS
winget install Warp.Warp    # Windows

# Linux - Multiple package formats available
# See: https://www.warp.dev/blog/warp-for-linux
# Packages include: .deb (apt), .rpm (yum/dnf/zypper), Snap, Flatpak, AppImage, and AUR
```

### 🌊 Wave Terminal

**Open-source terminal** that brings graphical capabilities into the command line.

**✨ Key Features:**

| Feature | Description |
| :--- | :--- |
| 🖼️ **Inline Previews** | Images, markdown, CSV, video files |
| 📝 **VSCode-like Editor** | Integrated editor for remote files |
| 🌐 **Built-in Browser** | Web browser and SSH connection manager |
| 📊 **Custom Widgets** | Dashboard creation capabilities |
| 🖥️ **Cross-platform** | Local data storage for privacy |

**🤖 AI Integration:**
- ✅ Built-in AI assistance for command suggestions
- ⚙️ Configurable AI models via "Add AI preset..."
- 🦙 Support for Ollama and other local models
- 🎯 Context-aware recommendations

**📦 Installation:**

Download from [waveterm.dev/download](https://waveterm.dev/download)

Available as: Snap, AppImage, .deb, .rpm, and Windows installers

### 📟 iTerm2 AI

**Native AI integration** for macOS's most popular terminal emulator.

**✨ Key Features:**
- 🧠 **Built-in AI Chat:** Interact with LLMs directly within iTerm2 windows
- ✍️ **Command Composer:** Describe what you want to do in English, and it generates the shell command
- 🔍 **Code Explanation:** Highlight output or commands to get instant explanations
- 🔑 **BYOK:** Bring Your Own Key (OpenAI, Gemini, etc.) for privacy and control

**📦 Setup:**
1. Install iTerm2 (v3.5+)
2. Install the AI plugin (Settings > General > AI > Install)
3. Configure your provider (OpenAI, Gemini, etc.) and API key
4. Use `Cmd-Y` to open the AI Composer

### 🧩 TmuxAI

**AI-Powered, Non-Intrusive Terminal Assistant** that works wherever tmux runs.

**✨ Key Features:**
- 🚀 **Universal Compatibility:** Works with any terminal emulator via tmux
- 👻 **Non-Intrusive:** Runs in a separate pane or window, keeping your workflow clean
- 🤖 **Model Flexibility:** Supports OpenAI and other compatible APIs
- ⌨️ **Keyboard Centric:** Designed for efficiency with tmux keybindings

**📦 Installation:**
Prerequisite: `tmux` must be installed.
Follow instructions at [github.com/alvinunreal/tmuxai](https://github.com/alvinunreal/tmuxai)

---

<div align="center">

**Made with ❤️ by the Community**

[⭐ Star on GitHub](https://github.com/BNLNPPS/terminal-ai-toolkit) | [🐛 Report Issues](https://github.com/BNLNPPS/terminal-ai-toolkit/issues) | [💡 Contribute](https://github.com/BNLNPPS/terminal-ai-toolkit/pulls)

*Supercharge your terminal workflow! 🚀*

</div>
