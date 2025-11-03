# nvim-python-hotloader

A Neovim plugin for Python development with LSP-powered context detection and hot-reload functionality.

## Features

### 1. Python Context Detection (PythonContext Command)

- **Lightweight**: Simple regex-based parsing, no LSP required
- **Fast**: Instant results without waiting for server responses
- **Smart**: Identifies module, class, and function at cursor position
- **Reliable**: Works in any environment without dependencies

```vim
:PythonContext
```

**Output:**
```
Python Context (simple):
  Module: my_module
  Class: UserManager
  Function: add_user
```

### 2. Hot-Reload Functionality (Planned)

- Automatic Python file change detection
- Hot-reload functionality for Python modules
- Seamless integration with Neovim workflows

## Installation

### Using lazy.nvim

```lua
{
  'your-username/nvim-python-hotloader',
  config = function()
    require('nvim-python-hotloader').setup({
      auto_reload = true,  -- Enable when hot-reload is implemented
    })
  end,
}
```

### Using Packer

```lua
use {
  'your-username/nvim-python-hotloader',
  config = function()
    require('nvim-python-hotloader').setup()
  end
}
```

## Quick Start

### 1. Install Pyright LSP

**Using Mason:**
```vim
:MasonInstall pyright
```

**Or install globally:**
```bash
npm install -g pyright
```

### 2. Configure LSP

```lua
-- Minimal setup
require('lspconfig').pyright.setup({})

-- Load the plugin
require('nvim-python-hotloader').setup()
```

### 3. Use the Command

```vim
:edit demo.py
:PythonContext  -- Place cursor in a function first!
```

## Requirements

- **Neovim** 0.8+ (for built-in LSP support)
- **Lua** 5.1 or later
- **Python** 3.x
- **Pyright** LSP server (recommended for best results)

## Documentation

- **[Quick Setup Guide](QUICK_SETUP.md)** - Get started in 5 minutes
- **[PythonContext Command](PYTHON_CONTEXT_COMMAND.md)** - Detailed documentation
- **[Configuration Example](lua/nvim-python-hotloader/example_config.lua)** - Complete setup with keybindings

## Example Files

- `demo.py` - Comprehensive Python examples for testing
- `example_python_file.py` - Simple examples to get started

## License

MIT License

---

## Development

### Run tests


Running tests requires either

- [luarocks][luarocks]
- or [busted][busted] and [nlua][nlua]

to be installed[^1].

[^1]: The test suite assumes that `nlua` has been installed
      using luarocks into `~/.luarocks/bin/`.

You can then run:

```bash
luarocks test --local
# or
busted
```

Or if you want to run a single test file:

```bash
luarocks test spec/path_to_file.lua --local
# or
busted spec/path_to_file.lua
```

If you see an error like `module 'busted.runner' not found`:

```bash
eval $(luarocks path --no-bin)
```

For this to work you need to have Lua 5.1 set as your default version for
luarocks. If that's not the case you can pass `--lua-version 5.1` to all the
luarocks commands above.

[rockspec-format]: https://github.com/luarocks/luarocks/wiki/Rockspec-format
[luarocks]: https://luarocks.org
[luarocks-api-key]: https://luarocks.org/settings/api-keys
[gh-actions-secrets]: https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository
[busted]: https://lunarmodules.github.io/busted/
[nlua]: https://github.com/mfussenegger/nlua
