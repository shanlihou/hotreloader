# PythonContext Command Demo

This document demonstrates the complete workflow of the `:PythonContext` command with interactive component selection.

## Step-by-Step Usage

### 1. Open a Python File

```vim
:edit example_python_file.py
```

Or any Python file with classes and functions:

```python
class UserManager:
    def add_user(self, username):
        # Place cursor here
        self.users.append(username)
```

### 2. Execute the Command

Place your cursor inside a function or class, then run:

```vim
:PythonContext
```

### 3. View Context Information

The command displays:

```
Python Context (simple):
  Module: example_python_file
  Class: UserManager
  Function: add_user
```

### 4. Interactive Selection

After showing context, you'll see:

```
Select a component to execute:
  1. cellapp
  2. baseapp
  3. Cancel

Enter your choice (1-3):
```

### 5. Make Your Selection

**Option 1 - Execute Cellapp:**

Type `1` and press Enter.

**Output:**
```
Executing cellapp for: example_python_file.UserManager.add_user

Executing command:
"E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat" cellapp example_python_file UserManager add_user

Command executed successfully!
[Bat file output]
```

**Option 2 - Execute Baseapp:**

Type `2` and press Enter.

**Output:**
```
Executing baseapp for: example_python_file.UserManager.add_user

Executing command:
"E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat" baseapp example_python_file UserManager add_user

Command executed successfully!
[Bat file output]
```

**Option 3 - Cancel:**

Type `3` and press Enter.

**Output:**
```
Operation cancelled
```

**Invalid Choice:**

Type any other number or text.

**Output:**
```
Invalid choice. Please enter 1, 2, or 3.
```

## Complete Example Flow

### Scenario: Working in a Python file

```python
# example.py
class DatabaseManager:
    """Manages database operations."""

    def connect(self, host, port):
        """Connect to database."""
        # Your cursor is here
        connection = create_connection(host, port)
        return connection
```

### Execution

**Command:**
```
:PythonContext
```

**Full Output:**

```
Python Context (simple):
  Module: example
  Class: DatabaseManager
  Function: connect

Select a component to execute:
  1. cellapp
  2. baseapp
  3. Cancel

Enter your choice (1-3): 1
Executing cellapp for: example.DatabaseManager.connect
```

## Technical Flow

### Step 1: Assets Directory Detection

The command searches for the 'assets' directory in your file path:

**Example File Path:**
```
E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\scripts\cell\UserManager.py
                                       ↑
                                 This is found and used
```

**Detection Process:**
1. Extracts current file path: `vim.fn.expand("%:p")`
2. Splits path into components
3. Searches for directory named "assets"
4. Reconstructs path up to and including "assets"

**Result:**
```
assets_path = E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets
```

### Step 2: Bat File Path Construction

Constructs full path to the bat file:

```lua
bat_file_path = assets_path .. "/hotReload/genhotfix.bat"
-- Converts to: E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat
```

### Step 3: Command Construction

Builds the complete command with all parameters:

```lua
full_command = string.format('"%s" %s %s %s %s',
  bat_file_path,      -- Quoted path to bat file
  component_name,     -- "cellapp" or "baseapp"
  modName,            -- Module name from filename
  className,          -- Class name from cursor
  funcName            -- Function name from cursor
)
```

**Example Result:**
```
"E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat" cellapp UserManager add_user UserManager.py
```

### Step 4: Execution

1. **Print Command**: Displays the full command for transparency
2. **Execute**: Runs via `vim.fn.system(full_command)`
3. **Check Result**: Uses `vim.v.shell_error` to check success/failure
4. **Display Output**: Shows command output and execution status

### Error Scenarios

**Assets Directory Not Found:**
```
Error: Could not find 'assets' parent directory in file path
```

**Command Execution Failed:**
```
Error executing command:
[Error output from bat file]
```

## Key Features

### ✅ Automatic Context Detection
- No need to manually specify class or function names
- Detects the context from your cursor position
- Works with nested classes and functions

### ✅ Interactive Selection
- Choose from predefined components
- Clear visual feedback
- Option to cancel anytime

### ✅ Multiple Components
- Cellapp execution
- Baseapp execution
- Easy to extend with more components

### ✅ Error Handling
- Invalid input detection
- Clear error messages
- Non-crashing design

## Tips

1. **Place cursor precisely**: For best results, place your cursor inside the function body you want to analyze.

2. **Works anywhere**: The command works even if cursor is on the function definition line.

3. **Fast execution**: The command responds instantly without waiting for LSP or external services.

4. **Extensible**: You can easily add more component options by modifying the selection menu.

## Customization

To add more components, edit `lua/nvim-python-hotloader/init.lua` and add more options:

```lua
-- Add to the selection menu
print("Select a component to execute:")
print("  1. cellapp")
print("  2. baseapp")
print("  3. customapp")  -- New option
print("  4. Cancel")     -- Adjust numbering
```

Then handle the new choice:

```lua
elseif choice == "3" then
  print("Executing customapp...")
```

## Next Steps

Try it with:
- `demo.py` - Contains comprehensive Python examples
- `example_python_file.py` - Simple examples for quick testing
- Your own Python files

Happy coding! 🚀
