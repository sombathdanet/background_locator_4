# Publication Checklist for location_tracking

Use this checklist to ensure everything is ready before publishing to pub.dev.

## Pre-Publication Checklist

### 1. Repository Setup
- [ ] Create a public Git repository (GitHub, GitLab, etc.)
- [ ] Push all code to the repository
- [ ] Verify repository is accessible

### 2. Update Package Information

#### In `pubspec.yaml`:
- [x] Update `homepage` with your repository URL (✅ Done: https://github.com/sombathdanet/location-tracking)
- [x] Update `repository` with your repository URL (✅ Done)
- [x] Update `issue_tracker` with your issues URL (✅ Done)
- [x] Verify version is `2.0.7` (✅ Done)
- [x] Verify package name is available on pub.dev (✅ `location_tracking` is available)

#### In `ios/location_tracking.podspec`:
- [x] Update `s.homepage` with your repository URL (✅ Done)
- [x] Update `s.author` with your name and email (✅ Done: Sombathdanet / sombatdanet@gmail.com)

#### In `README.md`:
- [ ] Update repository links (if any)
- [ ] Verify all examples are correct
- [ ] Check that all links work

### 3. Code Quality
- [x] All analyzer warnings fixed
- [x] Code follows Dart style guidelines
- [ ] No TODO comments in production code
- [ ] All imports are used
- [ ] No debug print statements in production code

### 4. Documentation
- [x] README.md is comprehensive
- [x] CHANGELOG.md is up to date
- [x] LICENSE file exists
- [x] Example app has documentation
- [ ] API documentation comments added (optional but recommended)

### 5. Testing

#### Manual Testing:
- [ ] Test on Android device (not just emulator)
- [ ] Test on iOS device (not just simulator)
- [ ] Test location updates in foreground
- [ ] Test location updates in background
- [ ] Test location updates when app is killed
- [ ] Test notification on Android
- [ ] Test permission requests
- [ ] Test start/stop functionality
- [ ] Test with different accuracy settings
- [ ] Test with different update intervals

#### Example App:
- [ ] Example app runs without errors
- [ ] Example app demonstrates all features
- [ ] Example app has proper permissions configured

### 6. Package Validation
- [ ] Run `flutter pub publish --dry-run`
- [ ] Review all files that will be published
- [ ] Check package size is reasonable
- [ ] Verify no sensitive files are included
- [ ] All warnings addressed or documented

### 7. Git Repository
- [ ] All changes committed
- [ ] Repository is clean (`git status`)
- [ ] README is visible on repository homepage
- [ ] LICENSE is visible on repository
- [ ] .gitignore is properly configured

## Publication Steps

### Step 1: Final Verification
```bash
# Check for uncommitted changes
git status

# Run analyzer
flutter analyze

# Run dry-run
flutter pub publish --dry-run
```

### Step 2: Commit Everything
```bash
git add .
git commit -m "Prepare for publication v2.0.7"
git push origin main
```

### Step 3: Authenticate
```bash
flutter pub login
```
- [ ] Successfully authenticated with pub.dev

### Step 4: Publish
```bash
flutter pub publish
```
- [ ] Review the confirmation prompt
- [ ] Type 'y' to confirm
- [ ] Wait for publication to complete

### Step 5: Tag Release
```bash
git tag -a v2.0.7 -m "Release version 2.0.7"
git push origin v2.0.7
```

### Step 6: Verify Publication
- [ ] Visit https://pub.dev/packages/location_tracking
- [ ] Check package appears correctly
- [ ] Verify README renders properly
- [ ] Check example code is visible
- [ ] Review pub points score

## Post-Publication Tasks

### Immediate
- [ ] Update README badge with actual pub.dev link
- [ ] Create GitHub release with changelog
- [ ] Share on social media (optional)
- [ ] Announce on Flutter community forums (optional)

### Ongoing
- [ ] Monitor GitHub issues
- [ ] Respond to questions
- [ ] Plan future updates
- [ ] Keep dependencies updated
- [ ] Test with new Flutter versions

## Common Issues and Solutions

### Issue: Package name already taken
**Solution**: Choose a different name:
- `background_locator_plus`
- `bg_location_tracker`
- `flutter_background_location`
- `your_company_background_locator`

Then update in:
- [ ] `pubspec.yaml` (name field)
- [ ] All import statements
- [ ] `README.md`
- [ ] `ios/background_locator_2.podspec`
- [ ] Android package names
- [ ] Example app dependencies

### Issue: Pub points score is low
**Solution**: Improve:
- [ ] Add more documentation
- [ ] Add API doc comments
- [ ] Fix analyzer warnings
- [ ] Add tests
- [ ] Improve README
- [ ] Add example code

### Issue: Publication fails
**Solution**: Check:
- [ ] Internet connection
- [ ] Authentication is valid
- [ ] Package name is valid
- [ ] Version number is higher than existing
- [ ] No restricted files included

## Quick Reference Commands

```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Dry run publication
flutter pub publish --dry-run

# Login to pub.dev
flutter pub login

# Publish package
flutter pub publish

# Create git tag
git tag -a v2.0.7 -m "Release version 2.0.7"

# Push tag
git push origin v2.0.7

# Check package on pub.dev
open https://pub.dev/packages/location_tracking
```

## URLs to Update

Before publishing, replace these placeholders:

1. **In `pubspec.yaml`**:
   ```yaml
   homepage: https://github.com/yourusername/background_locator_2
   repository: https://github.com/yourusername/background_locator_2
   issue_tracker: https://github.com/yourusername/background_locator_2/issues
   ```

2. **In `ios/background_locator_2.podspec`**:
   ```ruby
   s.homepage = 'https://github.com/yourusername/background_locator_2'
   s.author = { 'Your Name' => 'your.email@example.com' }
   ```

## Support Channels

After publication, set up:
- [ ] GitHub Issues for bug reports
- [ ] GitHub Discussions for questions (optional)
- [ ] Email for direct contact
- [ ] Discord/Slack channel (optional)

## Maintenance Schedule

Plan for:
- [ ] Monthly dependency updates
- [ ] Quarterly Flutter compatibility checks
- [ ] Prompt response to critical issues
- [ ] Regular feature updates based on feedback

## Success Criteria

Your package is successful when:
- [ ] Published without errors
- [ ] Pub points score > 100
- [ ] Example app works on both platforms
- [ ] Users can follow documentation successfully
- [ ] Issues are responded to promptly
- [ ] Package is actively maintained

---

## Notes

- Keep this checklist for future updates
- Update version numbers for each release
- Maintain changelog for all versions
- Test thoroughly before each publication
- Respond to user feedback promptly

**Good luck with your publication! 🚀**
