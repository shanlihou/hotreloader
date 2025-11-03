# PythonContext Command

This plugin includes a command that retrieves Python context information (module name, class name, and function name) from the current cursor position in a Python file.

## Usage

### Command

```vim
:PythonContext
```

## How It Works

The command uses **simple regex parsing** to identify Python context at your cursor position. It then prompts you to select a component to execute.

### Process Flow

1. **Detect Context**: Analyzes your cursor position to find:
   - **Module Name**: The filename (without extension) of the current Python file
   - **Class Name**: The name of the class containing your cursor (if applicable)
   - **Function Name**: The name of the function/method containing your cursor

2. **Interactive Selection**: Prompts you to choose a component:
   ```
   Select a component to execute:
     1. cellapp
     2. baseapp
     3. Cancel
   ```

3. **Execute Action**: Based on your selection:
   - Searches for 'assets' parent directory in the current file path
   - Constructs full path to bat file: `<assets_path>\hotReload\genhotfix.bat`
   - Builds complete command: `"<bat_path>" <component> <module> <class> <function>`
   - Prints the complete command
   - Executes the command
   - Displays execution results

### Simple Parsing Approach

The current implementation uses pattern matching to find:
- Class definitions: `class ClassName:`
- Function definitions: `def function_name():`

It searches backwards from your cursor position to find the closest enclosing class and function.

## Command Execution Details

### Assets Directory Detection

The command automatically searches for a parent directory named `assets` in the current file's path:

1. **Path Traversal**: Scans through directory components from the current file
2. **Asset Detection**: Identifies the 'assets' directory
3. **Path Construction**: Reconstructs the full path up to and including 'assets'
4. **Path Normalization**: Converts to Windows-style paths (backslashes)

**Example Path Detection:**
```
Current file: E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\scripts\cell\test.py
                                 ↑──────────────────────────────────────────↑
                                 Assets path identified here
```

### Bat File Path Construction

The command constructs the bat file path as:
```
<assets_path>\hotReload\genhotfix.bat
```

**Example:**
```
E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat
```

### Command Construction

The final command format is:
```bash
"<bat_file_path>" <component> <module> <class> <function>
```

**Example:**
```bash
"E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat" cellapp test UserManager add_user
```

### Execution Flow

1. **Print Command**: Displays the complete command before execution
2. **Execute**: Uses `vim.fn.system()` to run the command
3. **Result Check**: Checks `vim.v.shell_error` for execution status
4. **Output Display**: Shows command output and results

### Error Handling

- **Assets not found**: Shows error and returns early
- **Execution failure**: Displays error output from bat file
- **Invalid choice**: Shows error message and re-prompts

## Example

Given this Python code:

```python
class UserManager:
    def add_user(self, username):
        # Your cursor is here
        self.users.append(username)
```

When you place your cursor on line 3 and run `:PythonContext`, you'll see:

```
Python Context (simple):
  Module: example_python_file
  Class: UserManager
  Function: add_user

Select a component to execute:
  1. cellapp
  2. baseapp
  3. Cancel

Enter your choice (1-3):
```

### Example Interaction

**If you choose `1` (cellapp):**
```
Executing cellapp for: example_python_file.UserManager.add_user

Executing command:
"E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat" cellapp example_python_file UserManager add_user

Command executed successfully!
[bat file output]
```

**If you choose `2` (baseapp):**
```
Executing baseapp for: example_python_file.UserManager.add_user

Executing command:
"E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat" baseapp example_python_file UserManager add_user

Command executed successfully!
[bat file output]
```

**If you choose `3` (Cancel):**
```
Operation cancelled
```

**If assets directory is not found:**
```
Error: Could not find 'assets' parent directory in file path
```

**If command execution fails:**
```
Error executing command:
[Error details]
```

**If you enter an invalid choice:**
```
Invalid choice. Please enter 1, 2, or 3.
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
