# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
