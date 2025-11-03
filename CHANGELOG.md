# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2025-11-03

### Added
- **Assets Directory Detection**: Automatically finds 'assets' parent directory in file path
- **Bat File Execution**: Constructs and executes bat file with full parameters
- **Command Construction**: Builds command with format: `"<bat_path>" <component> <module> <class> <function>`
- **Command Execution**: Uses `vim.fn.system()` to execute bat files
- **Execution Display**: Prints complete command before execution for transparency
- **Path Normalization**: Converts to Windows-style paths (backslashes)
- **Error Handling**:
  - Assets directory not found error
  - Command execution failure detection
  - Detailed error output display

### Changed
- Enhanced component selection to trigger actual bat file execution
- Refactored command flow to include asset detection and execution steps

### Technical Details
- Searches for 'assets' directory in current file path using `vim.fn.expand("%:p")`
- Constructs bat file path: `<assets_path>\hotReload\genhotfix.bat`
- Uses `vim.v.shell_error` to check execution status
- Displays both stdout and stderr from bat file execution

### Output Format
**Example successful execution:**
```
Executing cellapp for: example_python_file.UserManager.add_user

Executing command:
"E:\shsvn\h1_trunk\Dev\Server\kbeLinux\kbengine\assets\hotReload\genhotfix.bat" cellapp example_python_file UserManager add_user

Command executed successfully!
[Bat file output]
```

## [1.1.0] - 2025-11-03

### Added
- **Interactive Component Selection**: The `:PythonContext` command now prompts users to select a component after detecting Python context
  - Option 1: Execute cellapp
  - Option 2: Execute baseapp
  - Option 3: Cancel operation
- **User Input Handling**: Added `vim.fn.input()` to capture user selection
- **Visual Feedback**: Clear prompts and responses for each selection option
- **Error Handling**: Invalid choice detection with helpful error messages

### Changed
- Updated command description to reflect interactive selection capability
- Enhanced documentation to include interaction flow examples

### Technical Details
- Command now performs two-step process:
  1. Context detection (module, class, function)
  2. Interactive component selection
- All user choices are displayed in command line output
- Notifications provide additional feedback via Neovim's notification system

## [1.0.0] - 2025-11-03

### Added
- Initial release of nvim-python-hotloader
- `:PythonContext` command for Python context detection
- Simple regex-based parsing (no LSP dependency)
- Module name detection from filename
- Class name detection from cursor position
- Function name detection from cursor position
- Comprehensive test suite
- Example Python files for testing
- Complete documentation (README, setup guide, command docs)

[Unreleased]: https://github.com/your-username/nvim-python-hotloader/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/your-username/nvim-python-hotloader/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/your-username/nvim-python-hotloader/releases/tag/v1.0.0
