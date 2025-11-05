# 🎯 Short Command: cleanarch

## ✅ Installation

Your CLI now has a short alias: **`cleanarch`**

---

## 🚀 Two Ways to Use

### Option 1: Global Installation (Recommended!)

```bash
# Install once
dart pub global activate clean_architecture_with_state_management

# Use anywhere
cleanarch myFeature -b
```

### Option 2: Local Installation

```bash
# In your project
dart pub get

# Use with dart run
dart run cleanarch myFeature -b
```

---

## 📝 Quick Examples (Global)

```bash
# Interactive mode with validation!
cleanarch

# Generate with Bloc
cleanarch user -b

# Preview (dry-run)
cleanarch product --dry-run

# Show help
cleanarch --help
```

---

## 💡 Make It Even Shorter

With global installation, add a shell alias:

```bash
# Add to ~/.zshrc or ~/.bashrc
alias ca='cleanarch'
```

Then use:
```bash
ca user -b
ca --help
ca
```

---

## ✅ Feature Name Validation

Both modes now validate feature names automatically!

```bash
$ cleanarch 123invalid
✗ Invalid feature name: "123invalid"
ℹ Feature names must:
ℹ   • Start with a letter (a-z, A-Z)
ℹ   • Contain only letters, numbers, and underscores
ℹ   • Example: user, user_profile, myFeature
```

---

## 🔄 Updating After Changes

If you update the package code:

```bash
# Delete cached snapshot
rm -f .dart_tool/pub/bin/clean_architecture_with_state_management/*.snapshot

# Or fully refresh
dart pub global deactivate clean_architecture_with_state_management
dart pub global activate --source path .
```

---

## ✅ You're All Set!

The `cleanarch` command is ready to use! 🎉

Try it now:
```bash
cleanarch --help
```

