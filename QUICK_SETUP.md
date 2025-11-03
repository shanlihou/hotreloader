# Quick Setup Guide for PythonContext Command

This guide helps you quickly set up the `PythonContext` command. **No LSP required!**

## Setup

### 1. Load the Plugin

Add this minimal configuration to your `init.lua`:

```lua
-- Load the hotloader plugin
require('nvim-python-hotloader').setup({
    auto_reload = true,  -- Enable when hot-reload is implemented
})
```

That's it! No LSP installation required.

## Testing the Command

1. Open a Python file:
   ```vim
   :edit example_python_file.py
   ```

2. Place cursor in a function or class

3. Run the command:
   ```vim
   :PythonContext
   ```

4. You should see output like:
   ```
   Python Context (simple):
     Module: example_python_file
     Class: UserManager
     Function: add_user
   ```

## How It Works

The command uses **simple regex parsing** to find:
- Class names: `class ClassName:`
- Function names: `def function_name():`
- Module name: filename without extension

It searches backward from your cursor to find the closest enclosing class and function.

## Troubleshooting

### Issue: Command not recognized

**Solution**: Make sure the plugin is loaded:

```lua
-- Add this to your init.lua
require('nvim-python-hotloader').setup()
```

### Issue: Doesn't work

**Solution**: Ensure it's a Python file:

1. Check the filetype:
   ```vim
   :set filetype?
   ```

2. If not python, set it:
   ```vim
   :set filetype=python
   ```

### Issue: Incorrect detection

The simple regex approach may not handle all edge cases:
- Nested classes at the same level
- Complex decorator syntax
- Multi-line definitions

For these cases, more sophisticated parsing would be needed.

## Customization

You can map the command to a keybinding:

```lua
vim.keymap.set('n', '<leader>pc', ':PythonContext<CR>', { desc = 'Get Python context' })
```

Now `<leader>pc` will trigger the command.

## Tips

- Works without any LSP or external dependencies
- Instant results, no waiting for servers
- Lightweight and fast
- Easy to modify for your needs

## Example Files

After setup, try:
1. `example_python_file.py` - Simple examples
2. `demo.py` - Comprehensive Python examples

## Next Steps

After setup, you can:
1. Explore the example Python files
2. Read the full documentation (`PYTHON_CONTEXT_COMMAND.md`)
3. Customize the command for your needs
4. Add keybindings for quick access

## Future Enhancements

Potential improvements:
- LSP integration for more accurate detection
- Support for nested classes
- Better handling of decorators and complex syntax
- Auto-detection of Python virtual environments

