<div align="center">

# 🤝 Aider

*AI pair programming in your terminal*

[![Python](https://img.shields.io/badge/Python-pip%20install-blue?logo=python)](https://pypi.org/project/aider-chat/)
[![GitHub](https://img.shields.io/badge/GitHub-aider-black?logo=github)](https://github.com/Aider-AI/aider)

</div>

---

## 🌟 Overview

Aider is an AI-powered terminal-based coding tool that enables **AI pair programming** directly in your local git repository. It brings the power of large language models (LLMs) directly to your command line, allowing you to collaborate with AI on code editing tasks.

> **💡 Pro Tip:** Aider integrates seamlessly with Git, automatically committing changes with meaningful commit messages!

---

## 🚀 Installation

### 📦 Quick Install

```bash
pip install aider-chat
```

After installation, run Aider by simply typing:
```bash
aider
```

### 🔧 Optional Setup Steps

<details>
<summary><b>1. Git Integration</b></summary>

<br>

Install Git for best experience with change tracking:
```bash
# macOS
brew install git

# Ubuntu/Debian
sudo apt-get install git

# Windows
winget install Git.Git
```

</details>

<details>
<summary><b>2. API Keys Setup</b></summary>

<br>

Set up API keys for your preferred LLM providers:

```bash
# OpenAI
export OPENAI_API_KEY="sk-..."

# Anthropic
export ANTHROPIC_API_KEY="sk-ant-..."

# Google Gemini
export GEMINI_API_KEY="AIza..."
```

</details>

### 🌐 Alternative Installation Methods

| Method | Description |
|:-------|:------------|
| 🐳 **Docker** | Run Aider in containerized environments |
| 🚀 **GitHub Codespaces** | Ready-to-use cloud development environment |
| 🌍 **Replit** | Browser-based coding with Aider pre-installed |

---

## 💻 Basic Usage

### 🎯 Getting Started

Aider is AI pair programming in your terminal that works with your local Git repository.

#### Starting Aider

1. Navigate to your project directory:
   ```bash
   cd /path/to/your/project
   ```

2. Run aider:
   ```bash
   aider
   ```

### ⚡ Essential In-Chat Commands

| Command | Description |
|:--------|:------------|
| `/add filename` | ➕ Add a file to the chat context |
| `/drop filename` | ➖ Remove a file from the chat context |
| `/clear` | 🧹 Clear the chat history and start fresh |
| `/model model_name` | 🔄 Switch to a different LLM |
| `/undo` | ⏮️ Undo the last git commit |
| `/ls` | 📂 List all files in the repository |
| `/run command` | ▶️ Execute shell commands |
| `/test command` | 🧪 Run test commands with automatic error fixing |
| `/help` | ❓ Show available commands |

### 🎨 Workflow Examples

<details open>
<summary><b>💡 Creating a New File</b></summary>

<br>

```plaintext
user: Create a new Python file called hello.py that prints "Hello, World!"
```

</details>

<details>
<summary><b>✏️ Modifying an Existing File</b></summary>

<br>

```plaintext
user: Can you add a function to calculate the factorial of a number in math_utils.py?
```

</details>

<details>
<summary><b>📝 Working with Multiple Files</b></summary>

<br>

```plaintext
user: I need to update the README.md to document the new factorial function I added to math_utils.py
```

</details>

---

## ✨ Main Features

### 🤖 Multi-LLM Support

Aider connects to a wide range of LLMs:

<table>
<tr>
<td width="33%">

**Major Providers**
- OpenAI
- Anthropic
- Google Gemini
- Groq

</td>
<td width="33%">

**Enterprise**
- Azure
- Vertex AI
- Amazon Bedrock
- GitHub Copilot

</td>
<td width="33%">

**Open Source**
- Ollama
- LM Studio
- OpenRouter
- OpenAI-compatible APIs

</td>
</tr>
</table>

#### 🔍 Listing Available Models

You can list available models matching a specific pattern using the `--list-models` flag:

```bash
aider --no-git --list-models gemini
aider --no-git --list-models claude
aider --no-git --list-models deepseek
```

### 🎯 Advanced Editing Capabilities

<table>
<tr>
<td width="50%">

#### 💬 Chat Modes
Different modes for various workflows: code, architect, ask, and help.

</td>
<td width="50%">

#### ⚡ In-Chat Commands
Control Aider with commands like `/add`, `/model`, and more.

</td>
</tr>
<tr>
<td width="50%">

#### 🎤 Voice-to-Code
Speak with Aider about your code using voice input.

</td>
<td width="50%">

#### 🖼️ Image & Web Integration
Add images and web pages to your coding chats.

</td>
</tr>
<tr>
<td width="50%">

#### 💾 Prompt Caching
Save costs and speed up coding with intelligent caching.

</td>
<td width="50%">

#### 🔧 IDE Integration
Works seamlessly with your favorite IDE or text editor.

</td>
</tr>
<tr>
<td colspan="2" align="center">

#### 🌐 Browser Support
Run Aider in your browser in addition to the command line.

</td>
</tr>
</table>

### 🛠️ Development Workflow Features

<table>
<tr>
<td width="50%">

#### 📊 Git Integration
Tightly integrated with git for version control and change tracking.

</td>
<td width="50%">

#### 🗺️ Repository Mapping
Uses a map of your git repository to provide context to LLMs.

</td>
</tr>
<tr>
<td width="50%">

#### 🧪 Linting and Testing
Automatically fix linting and testing errors with AI assistance.

</td>
<td width="50%">

#### 📝 Config File Editing
Edit config files, documentation, and text-based formats.

</td>
</tr>
<tr>
<td width="50%">

#### 🔄 Scripting Support
Can be scripted via command line or Python for automation.

</td>
<td width="50%">

#### 🌍 Multiple Language Support
Supports most popular coding languages out of the box.

</td>
</tr>
<tr>
<td colspan="2" align="center">

#### 🖥️ Shell Command Execution
Run and fix shell commands with automatic error detection and repair.

</td>
</tr>
</table>

### ⚙️ Configuration & Customization

- ✅ **Flexible Configuration**: YAML config files, `.env` files for API keys
- 🏷️ **Model Aliases**: Assign convenient short names to models
- 🎛️ **Advanced Model Settings**: Configure reasoning models and LLM settings
- 📐 **Coding Conventions**: Specify coding conventions for AI to follow

---

## ⚙️ Detailed Configuration

### 🔑 Multiple API Keys Configuration

<details>
<summary><b>Using YAML Configuration File</b></summary>

<br>

Create a `.aider.conf.yml` file in your project or home directory:

```yaml
# API Keys for different providers
api-key:
  - gemini=AIzaSyDWk2...
  - openrouter=sk-or-v1-...
  - groq=gsk_...
  - openai=sk-...
  - anthropic=sk-ant-...
```

</details>

<details>
<summary><b>Using Environment Variables</b></summary>

<br>

Create a `.env` file in your project directory:

```env
GEMINI_API_KEY=AIzaSyDWk2...
OPENROUTER_API_KEY=sk-or-v1-...
GROQ_API_KEY=gsk_...
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
```

</details>

#### Model Aliases Configuration

Create convenient shortcuts for frequently used models:

```yaml
# aliases for models
alias:
  - "gemini-2.5-flash:gemini/gemini-2.5-flash-preview-05-20"
  - "gemini-2.5-pro:gemini/gemini-2.5-pro-exp-03-25"
  - "ds-r1:groq/deepseek-r1-distill-llama-70b"
  - "kimi-k2:groq/moonshotai/kimi-k2-instruct-0905"
  - "qwen3-32b:groq/qwen/qwen3-32b"
  - "or-ds-r1:openrouter/deepseek/deepseek-r1:free"
  - "or-qwen3-coder:openrouter/qwen/qwen3-coder:free"
  - "or-ds-v3.1:openrouter/deepseek/deepseek-chat-v3.1:free"
  - "or-glm4.5-air:openrouter/z-ai/glm-4.5-air:free"
  - "llama-3:groq/llama3-70b-8192"
  - "or-mistral:openrouter/mistralai/mistral-7b-instruct"
```

Once configured, you can use these aliases with the `/model` command:
```
/model gemini-2.5-pro
/model or-qwen3-coder
/model ds-r1
```

#### Using Configuration Files

Create a `.aider.conf.yml` file in your home directory or project root:

```yaml
# .aider.conf.yml
model: gemini-2.5-flash
api-key:
  - gemini=AIzaSyDWk2...
  - openrouter=sk-or-v1-...
  - groq=gsk_...
alias:
  - "flash:gemini/gemini-2.5-flash-preview-05-20"
  - "pro:gemini/gemini-2.5-pro-exp-03-25"
  - "ds-r1:groq/deepseek-r1-distill-llama-70b"
dark-mode: true
auto-test: true
test-cmd: "python -m pytest tests/"
```

### Additional Features
- **Notifications**: Get notified when aider is waiting for your input
- **Copy/Paste with Web Chat**: Works with LLM web chat UIs
- **Infinite Output**: Handle "infinite output" from models that support prefill
- **Edit Formats**: Various formats for LLMs to edit source files
- **Analytics**: Opt-in anonymous analytics with no personal information

## File Watching Capability

Aider's file watching feature allows you to use AI coding instructions directly in your code files through special comments. To use this feature, run aider with the `--watch-files` option.

### Using the --watch-files Option

To enable file watching, start aider with the `--watch-files` flag:

```bash
aider --watch-files
```

This will monitor all files in your repository for special AI comments and automatically respond to them.

### How It Works

Aider looks for one-liner comments that start or end with `AI`, `AI!`, or `AI?`:
- `# Make a snake game. AI!` (Python-style)
- `// Write a protein folding prediction engine. AI!` (JavaScript-style)
- `-- Add error handling. AI!` (SQL-style)

### Special Comment Types

1. **`AI!`** - Triggers aider to make changes to your code
2. **`AI?`** - Triggers aider to answer your question

### Examples

1. **Simple Implementation Request**:
   ```javascript
   function factorial(n) // Implement this. AI!
   ```
   Aider would then implement the function:
   ```javascript
   function factorial(n) {
     if (n === 0 || n === 1) {
       return 1;
     } else {
       return n * factorial(n - 1);
     }
   }
   ```

2. **In-Context Instructions**:
   ```javascript
   app.get('/sqrt/:n', (req, res) => {
       const n = parseFloat(req.params.n);
   
       // Add error handling for NaN and less than zero. AI!
   
       const result = math.sqrt(n);
       res.json({ result: result });
   });
   ```

3. **Multiple Comments**:
   ```python
   @app.route('/factorial/<int:n>')
   def factorial(n):
       if n < 0:
           return jsonify(error="Factorial is not defined for negative numbers"), 400
   
       # AI: Refactor this code...
   
       result = 1
       for i in range(1, n + 1):
           result *= i
   
       # ... into to a compute_factorial() function. AI!
   
       return jsonify(result=result)
   ```

4. **Long Form Instructions**:
   ```python
   # Make these changes: AI!
   # - Add a proper main() function
   # - Use Click to process cmd line args
   # - Accept --host and --port args
   # - Print a welcome message that includes the listening url
   
   if __name__ == "__main__":
       app.run(debug=True)
   ```

### Flexibility

- Works with any file type (not limited to the correct comment syntax for that language)
- Supports multiple comments across different files
- Can be combined with terminal chat for more advanced features
- Comments can be terse and don't need perfect grammar (LLMs can infer intent)

This feature allows you to work directly in your preferred IDE while leveraging Aider's AI capabilities through simple comment markers.

## Running and Testing Shell Commands

Aider provides powerful capabilities for running shell commands, executing tests, and automatically fixing errors that occur during development.

---

## 🧪 Linting & Testing

### ✅ Linting Capabilities

| Feature | Description |
|:--------|:------------|
| 🤖 **Automatic Linting** | Built-in linters for most popular languages, runs after changes |
| 🔧 **Custom Linters** | Specify your preferred linter with `--lint-cmd <cmd>` |
| 🌐 **Per-Language Config** | Different linters for different languages via `--lint "language: cmd"` |
| 🚫 **Disable Auto-Lint** | Turn off automatic linting with `--no-auto-lint` |

### 🧪 Testing Capabilities

| Feature | Description |
|:--------|:------------|
| ▶️ **Test Execution** | Manual via `/test <command>` or automatic with `--auto-test` |
| 🔍 **Error Detection** | Monitors stdout/stderr and non-zero exit codes |
| 🔧 **Auto Error Fixing** | Automatically attempts to fix test failures |

### 🖥️ Shell Command Execution

<table>
<tr>
<td width="50%">

#### `/run <command>`
- ▶️ Executes a shell command once
- 📋 Shows output directly in chat
- 🛠️ For builds, installs, system info
- ⚠️ No automatic error fixing

</td>
<td width="50%">

#### `/test <command>`
- 🧪 Executes and monitors for errors
- 🎯 Designed for test suites
- 🔧 Auto-fixes on non-zero exit codes
- ⚡ Integrates with auto-fix capabilities

</td>
</tr>
</table>

> **💡 Key Difference:** `/run` is for observation, `/test` is for testing with automatic error correction.

### 📝 Usage Examples

<details>
<summary><b>Running Tests Automatically</b></summary>

<br>

```bash
aider --test-cmd "python -m pytest tests/" --auto-test
```

</details>

<details>
<summary><b>Using Custom Linters</b></summary>

<br>

```bash
aider --lint-cmd "eslint src/"
```

</details>

<details>
<summary><b>Running Shell Commands</b></summary>

<br>

```plaintext
user: /run npm install
```

</details>

<details>
<summary><b>Running Tests Manually</b></summary>

<br>

```plaintext
user: /test python -m pytest tests/unit/
```

</details>

<details>
<summary><b>Combined Linting and Testing</b></summary>

<br>

```bash
aider --lint-cmd "flake8 src/" --test-cmd "python -m pytest" --auto-lint --auto-test
```

</details>

### 🔨 Compiled Language Support

For compiled languages, you can configure:

| Type | Command Option | Example |
|:-----|:--------------|:--------|
| 📄 **File-level** | `--lint-cmd` | Lint and compile individual files |
| 🏗️ **Project-level** | `--test-cmd` | Rebuild and test entire project |

**Example for .NET:**
```bash
aider --test-cmd "dotnet build && dotnet test"
```

> **✨ Benefit:** Creates a CI-like experience where code is automatically checked and fixed after every AI edit!

---

## 🔄 Git Integration

Aider is **tightly integrated with Git** and works best with code that's part of a Git repository. This integration provides powerful version control features that make it easy to manage, review, and undo AI-generated changes.

### 🎯 Core Git Features

| Feature | Description |
|:--------|:------------|
| 🆕 **Auto Repository Creation** | Asks to create a Git repo if launched without one |
| 💾 **Automatic Commits** | Commits every edit with descriptive messages |
| 🧹 **Dirty File Handling** | Commits preexisting changes separately from AI edits |

### ⚡ Git Commands

| Command | Description |
|:--------|:------------|
| `/diff` | 📊 Shows all file changes since the last message |
| `/undo` | ⏮️ Undoes and discards the last change |
| `/commit` | 💾 Commits all dirty changes with a smart message |
| `/git <command>` | 🔧 Runs raw Git commands for advanced operations |

### 📝 Usage Examples

<details>
<summary><b>Viewing Changes</b></summary>

<br>

```plaintext
user: /diff
```

</details>

<details>
<summary><b>Undoing the Last Change</b></summary>

<br>

```plaintext
user: /undo
```

</details>

<details>
<summary><b>Committing Changes</b></summary>

<br>

```plaintext
user: /commit
```

</details>

<details>
<summary><b>Running Git Commands</b></summary>

<br>

```plaintext
user: /git log --oneline -10
user: /git status
user: /git branch
```

</details>

### 🤖 Automatic Commit Message Generation

Aider automatically generates commit messages by:

1. 📤 Sending diffs and chat history to a "weak model"
2. 📝 Generating messages (follows **Conventional Commits** by default)
3. ⚙️ Customizable with `--commit-prompt` option

**Example generated messages:**
```
feat: add factorial function to math_utils.py
fix: resolve error handling in sqrt endpoint
refactor: restructure factorial calculation into compute_factorial function
```

### Commit Attribution

Aider marks commits it author or commits:
- Adds "(aider)" to author/committer metadata for authored changes
- Adds "(aider)" to committer metadata for commits of dirty files
- Options available to control attribution behavior (`--no-attribute-author`, `--no-attribute-committer`)
- Can prefix commit messages with "aider: " or add Co-authored-by trailers

### Disabling Git Integration

Git integration can be disabled with flags like:
- `--no-auto-commits`: Stop auto-committing changes
- `--no-dirty-commits`: Stop committing dirty files
- `--no-git`: Completely stop Git usage
- `--git-commit-verify`: Run pre-commit hooks (disabled by default)

This tight Git integration makes Aider an excellent tool for maintaining a clean, traceable history of AI-assisted development work.

---

<div align="center">

**Made with ❤️ by the Community**

*Happy AI Pair Programming! 🚀*

</div>