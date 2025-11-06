## 1.2.1

### ✨ New Features
- **Global Installation Support**: Install once with `dart pub global activate clean_architecture_with_state_management`, then use `cleanarch` command anywhere
- **Short Command Alias**: Use `cleanarch` instead of `dart run clean_architecture_with_state_management`

### 🐛 Bug Fixes & Enhancements
- **Feature Name Validation (Enhanced)**:
  - Added validation to command-line mode (was previously only in interactive mode)
  - Feature names must start with a letter (a-z, A-Z)
  - Feature names can only contain letters, numbers, and underscores
  - Invalid feature names are now rejected in both interactive and command-line modes
  - Provides clear error messages with examples when validation fails

### 📚 Documentation
- Updated all documentation files to use `cleanarch` command
- Added global installation instructions to README
- Added snapshot cache management documentation
- Enhanced QUICK_REFERENCE.md with global installation examples
