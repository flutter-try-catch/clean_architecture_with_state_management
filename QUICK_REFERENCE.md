# ⚡ Quick Reference - cleanarch Command

## 🎯 Installation

### Global Installation (Recommended!)

```bash
dart pub global activate clean_architecture_with_state_management
```

Then use directly:
```bash
cleanarch myFeature -b
```

### Local Installation

```bash
dart pub get
dart run cleanarch myFeature -b
```

> **All examples below use global installation.** For local, prefix with `dart run`.

---

## 📋 Command Cheat Sheet

### Interactive Mode
```bash
# Interactive prompts (recommended for first-time users)
cleanarch
```

### Quick Generation with State Management
```bash
# Generate with Bloc
cleanarch myFeature -b

# Generate with Cubit
cleanarch myFeature -c

# Generate with Provider
cleanarch myFeature -p

# Generate with Riverpod
cleanarch myFeature -r
```

### Preview (Dry Run)
```bash
# See what will be created without actually creating files
cleanarch myFeature --dry-run
cleanarch myFeature -b --dry-run
```

### Help
```bash
# Show all options
cleanarch --help
cleanarch -h
```

### Other Options
```bash
# Skip git add
cleanarch myFeature --no-git

# Force interactive mode
cleanarch -i
```

---

## 🎯 Most Common Usage Patterns

### 1. First Time / Learning
```bash
cleanarch
# Follow the interactive prompts with validation!
```

### 2. Quick Feature with Bloc (Most Common)
```bash
cleanarch user -b
```

### 3. Preview Before Creating
```bash
cleanarch product --dry-run
```

### 4. Just Base Architecture
```bash
cleanarch cart
```

### 5. Check if Name is Valid
```bash
cleanarch myFeature --dry-run
# Validates the name without creating files
```

---

## 💡 Pro Tip: Make It Even Shorter

If using **global installation**, add a shell alias (`~/.zshrc` or `~/.bashrc`):

```bash
alias ca='cleanarch'
```

Then just use:
```bash
ca user -b          # Generate with Bloc
ca --help           # Show help
ca                  # Interactive mode
ca product --dry-run # Preview
```

**Super fast!** 🚀

## ✅ Validation Feature

Feature names are **automatically validated** in both modes:

```bash
# Invalid names are rejected
$ cleanarch 123invalid
✗ Invalid feature name: "123invalid"
ℹ Feature names must:
ℹ   • Start with a letter (a-z, A-Z)
ℹ   • Contain only letters, numbers, and underscores
ℹ   • Example: user, user_profile, myFeature

# Valid names work perfectly
$ cleanarch myFeature -b
✓ Feature "myFeature" generated successfully!
```

---

## 📊 Command Comparison

| Task | Old Command | Global (Recommended) | Local Installation |
|------|-------------|---------------------|-------------------|
| Interactive | `dart run clean_architecture_with_state_management` | `cleanarch` | `dart run cleanarch` |
| With Bloc | `dart run clean_architecture_with_state_management user -b` | `cleanarch user -b` | `dart run cleanarch user -b` |
| Help | `dart run clean_architecture_with_state_management --help` | `cleanarch --help` | `dart run cleanarch --help` |
| Dry Run | `dart run clean_architecture_with_state_management user --dry-run` | `cleanarch user --dry-run` | `dart run cleanarch user --dry-run` |

**Global installation is fastest!** 🚀

---

## 🎓 Examples

### Example 1: Generate User Feature with Bloc
```bash
$ cleanarch user -b

═══════════════════════════════════════════
  Clean Architecture Generator
═══════════════════════════════════════════

▶ Summary
  Feature Name: user
  State Management: bloc
  Mode: CREATE FILES

⟳ Setting up injection container
✓ Setting up injection container - Done

✓ Feature "user" generated successfully!
```

### Example 2: Interactive Mode
```bash
$ cleanarch

  ╔═══════════════════════════════════════════════════════╗
  ║   🏗️  Clean Architecture Generator                    ║
  ╚═══════════════════════════════════════════════════════╝

✔ What is the name of your feature? · product
✔ Do you want to add state management? · yes
✔ Choose your state management solution: · Bloc
✔ Ready to generate files? · yes

✓ Feature "product" generated successfully!
```

### Example 3: Preview with Dry Run
```bash
$ cleanarch cart --dry-run

⚠ DRY RUN MODE - No files will be created

▶ Creating Clean Architecture Structure
  ✓ Created: lib/features/cart/... (dry-run)
  
✓ Feature "cart" generated successfully!
Files created: 11
```

---

## 🚀 Quick Start

**Install globally:**
```bash
dart pub global activate clean_architecture_with_state_management
```

**Then use:**
```bash
cleanarch myFeature -b
# Super fast! ⚡
```

---

## 🎯 Your Command Reference

```bash
# The essentials:
cleanarch              # Interactive mode (with validation!)
cleanarch <name> -b    # Quick Bloc generation
cleanarch --help       # Show all options
cleanarch <name> --dry-run  # Preview only

# All state management options:
cleanarch <name> -b    # Bloc
cleanarch <name> -c    # Cubit
cleanarch <name> -p    # Provider
cleanarch <name> -r    # Riverpod
```

## 🔄 Updating the Package

When you update your code and want to refresh the global command:

```bash
# Delete cached snapshot
rm -f .dart_tool/pub/bin/clean_architecture_with_state_management/*.snapshot

# Or fully refresh
dart pub global deactivate clean_architecture_with_state_management
dart pub global activate --source path .
```

---

**Use `cleanarch` to generate clean architecture faster!** 🚀
