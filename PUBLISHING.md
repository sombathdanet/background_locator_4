# Publishing to pub.dev

This guide will help you publish the `location_tracking` package to pub.dev.

## Prerequisites

1. **Pub.dev Account**: Create an account at [pub.dev](https://pub.dev)
2. **Flutter SDK**: Ensure Flutter is installed and up to date
3. **Git Repository**: Have your code in a public Git repository (GitHub, GitLab, etc.)

## Pre-Publication Checklist

### 1. Update Package Information

Before publishing, update the following in `pubspec.yaml`:

```yaml
name: background_locator_2  # Or your preferred package name
homepage: https://github.com/YOUR_USERNAME/background_locator_2
repository: https://github.com/YOUR_USERNAME/background_locator_2
```

Also update in `ios/background_locator_2.podspec`:
```ruby
s.homepage = 'https://github.com/YOUR_USERNAME/background_locator_2'
s.author = { 'Your Name' => 'your.email@example.com' }
```

### 2. Verify Package Structure

Ensure you have:
- ✅ `LICENSE` file (MIT License included)
- ✅ `README.md` with usage examples
- ✅ `CHANGELOG.md` with version history
- ✅ `pubspec.yaml` with correct metadata
- ✅ `example/` directory with working example
- ✅ Proper package structure under `lib/`

### 3. Run Package Analysis

```bash
# Analyze the package for issues
flutter pub publish --dry-run

# This will check:
# - Package structure
# - pubspec.yaml validity
# - Documentation completeness
# - Code quality
```

Fix any warnings or errors reported.

### 4. Test the Package

```bash
# Run tests if you have any
flutter test

# Test the example app
cd example
flutter pub get
flutter run
```

### 5. Verify Documentation

Ensure your README.md includes:
- Clear description of what the package does
- Installation instructions
- Platform-specific setup (Android & iOS)
- Usage examples
- API documentation links
- License information

## Publishing Steps

### Step 1: Authenticate with pub.dev

```bash
# This will open a browser for authentication
flutter pub login
```

### Step 2: Dry Run

```bash
# Test the publication process without actually publishing
flutter pub publish --dry-run
```

Review the output carefully. It will show:
- Files that will be published
- Package size
- Any warnings or suggestions

### Step 3: Publish

```bash
# Publish to pub.dev
flutter pub publish
```

You'll be asked to confirm. Type 'y' to proceed.

## Post-Publication

### 1. Verify on pub.dev

Visit `https://pub.dev/packages/background_locator_2` to verify:
- Package appears correctly
- README renders properly
- Example code is visible
- Scores are acceptable (pub points, popularity, likes)

### 2. Add Package Badge to README

Update your README.md with the actual pub.dev badge:

```markdown
[![pub package](https://img.shields.io/pub/v/background_locator_2.svg)](https://pub.dev/packages/background_locator_2)
```

### 3. Tag the Release

```bash
git tag -a v2.0.7 -m "Release version 2.0.7"
git push origin v2.0.7
```

## Updating the Package

When you need to publish updates:

1. Update version in `pubspec.yaml`
2. Add entry to `CHANGELOG.md`
3. Commit changes
4. Run `flutter pub publish --dry-run`
5. Run `flutter pub publish`
6. Tag the release in Git

## Common Issues

### Issue: Package name already taken

**Solution**: Choose a different name. Consider:
- `background_locator_plus`
- `bg_location_tracker`
- `your_company_background_locator`

Update the name in:
- `pubspec.yaml`
- `README.md`
- All import statements
- iOS podspec
- Android package names

### Issue: Score too low

**Solution**: Improve:
- Add more documentation
- Add example code
- Fix analyzer warnings
- Add tests
- Improve README

### Issue: Platform support not detected

**Solution**: Ensure `pubspec.yaml` has:
```yaml
platforms:
  android:
  ios:
```

## Package Naming Guidelines

If you need to rename the package:

1. Choose a unique, descriptive name
2. Check availability on pub.dev
3. Update all references:
   - `pubspec.yaml` (name field)
   - All import statements in Dart files
   - README.md
   - iOS podspec
   - Android package declarations
   - Example app dependencies

## Support and Maintenance

After publishing:
- Monitor issues on your repository
- Respond to user questions
- Keep dependencies updated
- Test with new Flutter versions
- Publish updates regularly

## Resources

- [Pub.dev Publishing Guide](https://dart.dev/tools/pub/publishing)
- [Package Layout Conventions](https://dart.dev/tools/pub/package-layout)
- [Verified Publishers](https://dart.dev/tools/pub/verified-publishers)
- [Package Scoring](https://pub.dev/help/scoring)
