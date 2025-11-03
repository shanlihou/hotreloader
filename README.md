# nvim-python-hotloader

A Neovim plugin for hot-reloading Python code. This plugin automatically detects changes to Python files and reloads them without requiring a full restart, improving development workflow.

## Features

- Automatic Python file change detection
- Hot-reload functionality for Python modules
- Seamless integration with Neovim workflows

## Installation

### Using lazy.nvim

```lua
{
  'your-username/nvim-python-hotloader',
  -- Optional configuration
  config = function()
    require('nvim-python-hotloader').setup({
      -- Configure options here
      auto_reload = true,
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

## Requirements

- Neovim (latest stable or nightly)
- Lua 5.1 or later
- Python 3.x

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
