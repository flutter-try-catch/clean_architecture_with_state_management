![Stand With Palestine](https://raw.githubusercontent.com/TheBSD/StandWithPalestine/main/banner-no-action.svg)

# Clean Architecture with State Management 🏗️

A powerful, interactive CLI tool for generating clean architecture files with various state management options for Flutter projects.

## ✨ Features

- 🎯 **Interactive Mode** - Beautiful, user-friendly prompts to guide you through setup
- 🎨 **Colored Output** - Enhanced terminal experience with colored messages and icons
- 📊 **Progress Tracking** - Real-time feedback on file creation
- 🔍 **Dry Run Mode** - Preview changes before creating files
- ✅ **Input Validation** - Smart validation to prevent errors
- 🚀 **Multiple State Management** - Support for Provider, Bloc, Cubit, and Riverpod
- 📁 **Clean Architecture** - Generates proper separation of concerns (Data, Domain, Presentation)
- 🔧 **Dependency Injection** - Automatic setup with GetIt
- 🎭 **Flexible Usage** - Works in both interactive and command-line modes

## 📦 Installation

### Option 1: Global Installation (Recommended)

Install globally to use the short `cleanarch` command anywhere:

```bash
dart pub global activate clean_architecture_with_state_management
```

Then use directly:
```bash
cleanarch myFeature -b
```

### Option 2: Local Installation

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  clean_architecture_with_state_management:
```

Then run:

```bash
dart pub get
```

And use with:
```bash
dart run cleanarch myFeature -b
```

## 🚀 Usage

### 🎯 Quick Commands

```bash
# Global installation (shorter!)
cleanarch myFeature -b

# Local installation
dart run cleanarch myFeature -b
```

> **Note**: All examples below use the global `cleanarch` command. If using local installation, prefix with `dart run`.

### Interactive Mode (Recommended)

Simply run without arguments for an interactive experience:

```bash
cleanarch
```

You'll be guided through:
1. Entering your feature name (with validation!)
2. Choosing whether to add state management
3. Selecting your preferred state management solution
4. Confirming the summary before generation

### Command-Line Mode

For quick generation or CI/CD pipelines:

```bash
# Basic structure without state management
cleanarch myFeature

# With Bloc
cleanarch myFeature -b

# With Cubit
cleanarch myFeature -c

# With Provider
cleanarch myFeature -p

# With Riverpod
cleanarch myFeature -r
```

### Advanced Options

```bash
# Preview without creating files (dry-run)
cleanarch myFeature --dry-run

# Skip git add step
cleanarch myFeature --no-git

# Force interactive mode
cleanarch -i

# Show help
cleanarch --help
```

## 📁 Generated Folder Structure

### Base Structure (No State Management)

```
├─ features
│  └─ feature_name/
│     ├─ data/
│     │  ├─ data_sources/
│     │  │  ├─ local/
│     │  │  │  └─ feature_name_local_data_source.dart
│     │  │  └─ remote/
│     │  │     └─ feature_name_remote_data_source.dart
│     │  ├─ models/
│     │  │  └─ feature_model.dart
│     │  └─ repositories/
│     │     └─ feature_name_repository_impl.dart
│     ├─ domain/
│     │  ├─ entities/
│     │  │  └─ feature.dart
│     │  ├─ repositories/
│     │  │  └─ feature_repository.dart
│     │  └─ use_cases/
│     │     └─ feature_use_case.dart
│     ├─ presentation/
│     │  ├─ screens/
│     │  │  └─ feature_screen.dart
│     │  └─ widgets/
│     └─ inject_feature_name.dart
```

### With Bloc

```
│     ├─ presentation/
│     │  ├─ bloc/
│     │  │  ├─ feature_bloc.dart
│     │  │  ├─ feature_event.dart
│     │  │  └─ feature_state.dart
│     │  ├─ screens/
│     │  │  └─ feature_screen.dart
│     │  └─ widgets/
```

### With Cubit

```
│     ├─ presentation/
│     │  ├─ cubit/
│     │  │  ├─ feature_cubit.dart
│     │  │  └─ feature_state.dart
│     │  ├─ screens/
│     │  │  └─ feature_screen.dart
│     │  └─ widgets/
```

### With Provider

```
│     ├─ presentation/
│     │  ├─ provider/
│     │  │  └─ feature_provider.dart
│     │  ├─ screens/
│     │  │  └─ feature_screen.dart
│     │  └─ widgets/
```

### With Riverpod

```
│     ├─ presentation/
│     │  ├─ riverpod/
│     │  │  ├─ feature_notifier.dart
│     │  │  └─ feature_provider.dart
│     │  ├─ screens/
│     │  │  └─ feature_screen.dart
│     │  └─ widgets/
```

## 🎯 Clean Architecture Principles

The generated code follows clean architecture principles:

### Data Layer
- **Data Sources**: Local and remote data sources for accessing data
- **Models**: Data transfer objects that extend domain entities
- **Repositories**: Implementation of domain repositories

### Domain Layer
- **Entities**: Business objects of the application
- **Repositories**: Abstract contracts for data operations
- **Use Cases**: Business logic and application-specific rules

### Presentation Layer
- **Screens**: UI components using your chosen state management
- **Widgets**: Reusable UI components
- **State Management**: Bloc/Cubit/Provider/Riverpod files

## 💡 Interactive Features

### 🎨 Colored Output
- ✓ Green for success messages
- ✗ Red for errors
- ⚠ Yellow for warnings
- ℹ Cyan for information
- Beautiful headers and sections

### 📊 Progress Tracking
- Real-time file creation feedback
- File skip notifications for existing files
- Summary of total files created

### 🔍 Dry Run Mode
Preview exactly what will be created without making any changes:
```bash
cleanarch myFeature --dry-run
```

### 🔄 Override Protection (NEW!)
If a feature already exists, you'll be asked if you want to override it:
```bash
$ cleanarch user -b

⚠ Feature "user" already exists!
Do you want to override the existing feature? › No

ℹ Operation cancelled. Existing feature was not modified.
```
- Default is **No** to protect your work
- Choose Yes to completely regenerate the feature
- Easy to cancel and keep existing code

### ✅ Input Validation (NEW!)
- **Smart validation** works in both interactive and command-line modes
- Feature names must start with a letter (a-z, A-Z)
- Only allows letters, numbers, and underscores
- Empty input prevention
- Helpful error messages with examples
- Automatic retry in interactive mode

**Example:**
```bash
$ cleanarch 123invalid
✗ Invalid feature name: "123invalid"
ℹ Feature names must:
ℹ   • Start with a letter (a-z, A-Z)
ℹ   • Contain only letters, numbers, and underscores
ℹ   • Example: user, user_profile, myFeature
```

### 🎯 Smart Confirmations
- Summary review before generation
- Confirmation prompt to proceed
- Override confirmation for existing features
- Easy cancellation at any step

## 📝 Example Workflow

```bash
$ cleanarch

  ╔═══════════════════════════════════════════════════════╗
  ║                                                       ║
  ║   🏗️  Clean Architecture Generator                    ║
  ║   with State Management                              ║
  ║                                                       ║
  ║   Generate clean, scalable Flutter features          ║
  ║   with your favorite state management                ║
  ║                                                       ║
  ╚═══════════════════════════════════════════════════════╝

💡 Tips:
  • Use snake_case or camelCase for feature names
  • The generator handles naming conventions automatically
  • Files are automatically added to git
  • Use --dry-run to preview before creating

▶ Feature Setup
What is the name of your feature? › user

Do you want to add state management? › Yes

Choose your state management solution:
  Provider
❯ Bloc
  Cubit
  Riverpod

▶ Summary
  Feature Name: user
  State Management: Bloc
  Mode: CREATE FILES

Ready to generate files? › Yes

▶ Initializing
⟳ Setting up injection container...

▶ Creating Clean Architecture Structure
  → Creating directory structure...
  → Creating data layer...
  ✓ Created: lib/features/user/data/data_sources/local/user_local_data_source.dart
  ✓ Created: lib/features/user/data/data_sources/remote/user_remote_data_source.dart
  ...

════════════════════════════════════════════
  ✓ Feature "user" generated successfully!
  Files created: 12
════════════════════════════════════════════

▶ Next Steps
  → 1. Update your dependency injection in injection_container.dart
  → 2. Implement your business logic in the use case
  → 3. Add your UI in the presentation layer
  → 4. Start coding! 🚀
```

## 🛠️ Command-Line Options

| Option | Short | Description |
|--------|-------|-------------|
| `--help` | `-h` | Show help information |
| `--interactive` | `-i` | Force interactive mode |
| `--dry-run` | `-d` | Preview changes without creating files |
| `--provider` | `-p` | Use Provider state management |
| `--bloc` | `-b` | Use Bloc state management |
| `--cubit` | `-c` | Use Cubit state management |
| `--riverpod` | `-r` | Use Riverpod state management |
| `--no-git` | | Skip git add step |

## 🎓 Best Practices

1. **Feature Naming**: Use descriptive names for your features (e.g., `authentication`, `user_profile`, `product_catalog`)

2. **Dependency Injection**: After generation, update your `lib/injection_container.dart`:
   ```dart
   Future.wait([
     ServiceLocator().setup(),
   ]).then((value) {
     runApp(const MyApp());
   });
   ```

3. **State Management**: Choose the state management solution that best fits your team's expertise and project requirements

4. **Preview First**: Use `--dry-run` to preview the structure before committing to file creation

5. **Feature Name Rules**: Always start feature names with a letter (not numbers or underscores)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

Built with ❤️ for the Flutter community

## 📞 Support

- [GitHub Issues](https://github.com/flutter-try-catch/clean_architecture_with_state_management/issues)
- [Homepage](https://github.com/flutter-try-catch/clean_architecture_with_state_management)

---

**Happy Coding! 🚀**
