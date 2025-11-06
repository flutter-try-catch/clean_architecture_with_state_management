# 🔄 Override Existing Features

## Feature: Smart Override Detection

When you try to create a feature that already exists, the CLI will now detect it and ask you what to do!

> **Note**: Examples below use global installation (`cleanarch`). For local installation, use `dart run cleanarch`.

---

## 🎯 How It Works

### Example: Creating an Existing Feature

```bash
$ cleanarch user -b

⚠ Feature "user" already exists!

Do you want to override the existing feature? › No

ℹ Operation cancelled. Existing feature was not modified.
```

**Validation also works** - invalid names are rejected before checking if feature exists:

```bash
$ cleanarch 123user -b
✗ Invalid feature name: "123user"
ℹ Feature names must:
ℹ   • Start with a letter (a-z, A-Z)
```

---

## ✅ What Happens When You Override

If you choose **Yes** to override:

```bash
$ cleanarch user -b

⚠ Feature "user" already exists!

Do you want to override the existing feature? › Yes

▶ Removing Existing Feature
  → Deleting lib/features/user...
✓ Existing feature removed

▶ Initializing
⟳ Setting up injection container
✓ Setting up injection container - Done

▶ Creating Clean Architecture Structure
  → Creating directory structure...
  ✓ Created: lib/features/user/data/...
  ...

✓ Feature "user" generated successfully!
```

---

## 🛡️ Safety Features

### 1. **Default is NO**
The default answer is "No" to prevent accidental overrides.

### 2. **Clear Warning**
You get a clear warning message before any action.

### 3. **Complete Removal**
When overriding, the entire old feature is removed first, ensuring a clean slate.

### 4. **Dry-Run Safe**
In dry-run mode, no override prompt appears (nothing is created anyway).

---

## 📋 Use Cases

### Use Case 1: Accidentally Created Wrong Feature
```bash
# Oops, created with wrong state management
$ cleanarch user -p

# Let's fix it with Bloc instead
$ cleanarch user -b
⚠ Feature "user" already exists!
Do you want to override? › Yes
✓ Feature regenerated with Bloc!
```

### Use Case 2: Starting Fresh
```bash
# Made a mess with custom changes
$ cleanarch product -r
⚠ Feature "product" already exists!
Do you want to override? › Yes
✓ Clean slate with fresh architecture!
```

### Use Case 3: Protecting Existing Work
```bash
# Already have a working feature
$ cleanarch authentication -b
⚠ Feature "authentication" already exists!
Do you want to override? › No
ℹ Operation cancelled. Your work is safe!
```

---

## 💡 Pro Tips

### Tip 1: Preview First
Use dry-run to see what would be created:
```bash
cleanarch user --dry-run
# No override prompt in dry-run mode
```

### Tip 2: Backup Before Override
```bash
# Create a backup first
cp -r lib/features/user lib/features/user_backup

# Then override
cleanarch user -b
```

### Tip 3: Git Integration
Since files are auto-added to git, you can easily revert:
```bash
cleanarch user -b
# Chose override by mistake?
git restore lib/features/user/
```

---

## 🎯 Behavior Summary

| Scenario | Action |
|----------|--------|
| Feature doesn't exist | Create normally |
| Feature exists + Choose No | Cancel operation, keep existing |
| Feature exists + Choose Yes | Delete old, create fresh |
| Dry-run mode | No override prompt (nothing created) |

---

## 🚀 Interactive Example

```bash
$ cleanarch

  ╔═══════════════════════════════════════════════════════╗
  ║   🏗️  Clean Architecture Generator                    ║
  ╚═══════════════════════════════════════════════════════╝

✔ What is the name of your feature? · user

⚠ Feature "user" already exists!

✔ Do you want to override the existing feature? · no

ℹ Operation cancelled. Existing feature was not modified.
```

---

## ⚠️ Important Notes

1. **Complete Override**: Choosing "Yes" deletes the **entire feature directory**
2. **No Partial Updates**: You can't merge with existing files - it's all or nothing
3. **Git Safety**: Files are tracked, so you can always revert with git
4. **Default Safety**: The default is always "No" to protect your work

---

## 🎉 Benefits

✅ **Prevents Accidents** - Clear warning before any override
✅ **Clean Regeneration** - Start fresh when needed
✅ **Protects Work** - Easy to decline and keep existing code
✅ **Fast Iteration** - Quickly regenerate with different state management
✅ **Safe by Default** - Must explicitly choose to override

---

**Your work is protected by smart override detection!** 🛡️

