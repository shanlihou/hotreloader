# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **nvim-lua-plugin-template** - a starter template for creating Neovim plugins written in Lua. The template includes GitHub workflows for CI/CD, testing setup with busted, linting with luacheck, and LuaRocks packaging configuration.

## Development Setup

### Prerequisites

Install the required tools:
- **LuaRocks** (for package management and running tests)
- **busted** (testing framework)
- **nlua** (Lua binding for Neovim, required for testing)

The test suite assumes `nlua` has been installed via luarocks into `~/.luarocks/bin/`.

### Installing Dependencies

```bash
# Install test dependencies
luarocks install nlua
```

## Running Tests

The project uses **busted** for testing with **nlua** to provide Neovim API bindings.

### Run All Tests

```bash
# Using luarocks
luarocks test --local

# Using busted directly
busted
```

### Run Single Test File

```bash
# Using luarocks
luarocks test spec/path_to_file.lua --local

# Using busted directly
busted spec/path_to_file.lua
```

### Troubleshooting Tests

If you encounter `module 'busted.runner' not found`:

```bash
eval $(luarocks path --no-bin)
```

For Lua version issues, set the Lua version explicitly:

```bash
luarocks test --local --lua-version 5.1
```

### Test Configuration

Tests are configured in `.busted`:
- Uses `nlua` as the Lua interpreter
- Includes `lua/` in the Lua path
- Runs tests verbosely by default

## Code Quality & Linting

### Luacheck

The project uses **luacheck** for static analysis. Configuration is in `.luacheckrc`:

- Global vim namespace is allowed (`vim` in read_globals)
- Test functions are allowed (`describe`, `it`, `assert`)
- Max line length checking is disabled (line 631)

### GitHub Super Linter

CI runs GitHub Super Linter on all PRs to `master`. Configuration in `.github/workflows/linter.yml`:
- JavaScript CPD validation disabled
- Python Black validation disabled

## Continuous Integration

### GitHub Actions Workflows

#### 1. Tests (`.github/workflows/tests.yml`)
- Runs on PRs and pushes to `main`
- Tests against **Neovim nightly**
- Uses `nvim-busted-action` to execute tests

#### 2. Linter (`.github/workflows/linter.yml`)
- Runs on PRs and pushes to `master`
- Uses GitHub Super Linter
- Validates code quality

#### 3. Release (`.github/workflows/release.yml`)
- Triggers on version tags (`v*.*.*`)
- Automatically releases to **LuaRocks**
- Requires `LUAROCKS_API_KEY` in GitHub Secrets

## Project Structure

After configuring for a specific plugin, the expected structure is:

```
├── lua/                    # Lua module code (add your plugin modules here)
│   └── nvim-lua-plugin/    # Your plugin's main module
│       └── init.lua
├── spec/                   # Test files
│   └── *_spec.lua
├── .github/workflows/      # CI/CD workflows
├── .busted                 # Test configuration
├── .luacheckrc             # Linting configuration
├── .editorconfig           # Code style configuration
├── nvim-lua-plugin-scm-1.rockspec  # LuaRocks package specification
└── README.md
```

**Note**: The template includes TODO comments in files that need customization when creating a new plugin repository.

## Configuring the Template

When using this template to create a new Neovim plugin:

1. **Rename rockspec file**: Change `nvim-lua-plugin-scm-1.rockspec` to match your plugin name
2. **Update rockspec**: Modify the `package` field in the rockspec to your plugin name
3. **Add source URL**: Update the `source.url` field in the rockspec
4. **Add runtimepath directories**: Update `copy_directories` in rockspec if using `plugin/`, `ftplugin/`, or `doc/` directories
5. **Add dependencies**: Update the `dependencies` table in the rockspec (e.g., `"plenary.nvim"`)
6. **Add your plugin code**: Create your Lua modules under `lua/`

## Code Style

Code style is enforced via `.editorconfig`:
- **UTF-8** encoding
- **2-space** indentation
- **Spaces** for indent style (no tabs)
- **Trim trailing whitespace**
- **Insert final newline**

These settings apply to all `*.lua` files.

## Testing Guidelines

- Place test files in the `spec/` directory
- Name test files with `_spec.lua` suffix
- Tests can access the `vim` namespace via nlua
- Use busted's `describe` and `it` functions for test structure
- Example test structure is provided in `spec/example_spec.lua`

## References

- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [Neovim Plugin Documentation](https://neovim.io/doc/user/write-plugin.html)
- [LuaRocks](https://luarocks.org)
- [busted Testing Framework](https://lunarmodules.github.io/busted/)
- [nlua (Neovim Lua bindings for testing)](https://github.com/mfussenegger/nlua)
