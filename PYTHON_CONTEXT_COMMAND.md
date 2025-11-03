# PythonContext Command

This plugin includes a command that retrieves Python context information (module name, class name, and function name) from the current cursor position in a Python file.

## Usage

### Command

```vim
:PythonContext
```

## How It Works

The command uses **simple regex parsing** to identify Python context at your cursor position. It analyzes:

1. **Module Name**: The filename (without extension) of the current Python file
2. **Class Name**: The name of the class containing your cursor (if applicable)
3. **Function Name**: The name of the function/method containing your cursor

### Simple Parsing Approach

The current implementation uses pattern matching to find:
- Class definitions: `class ClassName:`
- Function definitions: `def function_name():`

It searches backwards from your cursor position to find the closest enclosing class and function.

## Example

Given this Python code:

```python
class UserManager:
    def add_user(self, username):
        # Your cursor is here
        self.users.append(username)
```

When you place your cursor on line 3 and run `:PythonContext`, you'll get:

```
Python Context (simple):
  Module: example_python_file
  Class: UserManager
  Function: add_user
```

## Requirements

- Only works with Python files (filetype = `python`)
- Works with standard Python syntax:
  - Class definitions: `class ClassName:`
  - Function definitions: `def function_name():`
  - Methods within classes

## Advantages

- **Lightweight**: No LSP dependency
- **Fast**: Instant results without waiting for LSP
- **Reliable**: Works in any environment
- **Simple**: Easy to understand and modify

## Limitations

- May not accurately handle deeply nested structures
- Cannot distinguish between methods at the same indentation level
- Doesn't use the full syntax tree (no LSP)

## Testing the Command

1. Open a Python file in Neovim:
   ```vim
   :edit demo.py
   ```

2. Place your cursor within a function or class

3. Run `:PythonContext`

4. The information will be printed in the command line and shown as a notification

## Example Files

- `demo.py` - Comprehensive Python examples for testing
- `example_python_file.py` - Simple examples to get started

## Future Enhancements

The plugin may be enhanced in the future to use LSP (Language Server Protocol) for more accurate context detection. This would require:
- Pyright or another Python LSP server to be installed
- LSP client configured in Neovim
- More complex symbol tree traversal logic

## Troubleshooting

### Command not recognized

Make sure the plugin is loaded:

```lua
require('nvim-python-hotloader').setup()
```

### Doesn't work on non-Python files

The command only works on files with `filetype=python`. Set it manually if needed:
```vim
:set filetype=python
```

### Incorrect class/function detection

The simple regex approach may not handle all edge cases:
- Nested classes at same indentation
- Complex decorator syntax
- Multi-line function signatures

For these cases, LSP-based detection would be more accurate.
