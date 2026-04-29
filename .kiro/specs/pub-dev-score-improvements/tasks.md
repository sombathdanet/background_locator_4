# Implementation Plan

- [x] 1. Write bug condition exploration test
  - **Property 1: Bug Condition** - Pub.dev Scoring Issues
  - **CRITICAL**: This test MUST FAIL on unfixed code - failure confirms the bugs exist
  - **DO NOT attempt to fix the test or the code when it fails**
  - **NOTE**: This test encodes the expected behavior - it will validate the fix when it passes after implementation
  - **GOAL**: Surface counterexamples that demonstrate the three scoring issues exist
  - **Scoped PBT Approach**: Test the three concrete failing cases: web platform declaration, outdated SDK constraint, missing library docs
  - Test that pubspec.yaml declares web platform (from Bug Condition in design)
  - Test that SDK constraint lower bound is < 3.3.0 (from Bug Condition in design)
  - Test that public API files lack library-level documentation (from Bug Condition in design)
  - The test assertions should match the Expected Behavior Properties from design
  - Run test on UNFIXED code
  - **EXPECTED OUTCOME**: Test FAILS (this is correct - it proves the bugs exist)
  - Document counterexamples found to understand root cause
  - Mark task complete when test is written, run, and failure is documented
  - _Requirements: 1.1, 1.2, 1.3_

- [x] 2. Write preservation property tests (BEFORE implementing fix)
  - **Property 2: Preservation** - Package Functionality and API
  - **IMPORTANT**: Follow observation-first methodology
  - Observe behavior on UNFIXED code for package functionality
  - Write property-based tests capturing observed behavior patterns from Preservation Requirements
  - Test that all exports remain unchanged (BackgroundLocator, LocationDto, AutoStopHandler, AndroidSettings, IOSSettings, LocatorSettings, Keys)
  - Test that package metadata (name, version, description) is preserved
  - Test that plugin configuration remains unchanged
  - Test that dependencies remain unchanged
  - Property-based testing generates many test cases for stronger guarantees
  - Run tests on UNFIXED code
  - **EXPECTED OUTCOME**: Tests PASS (this confirms baseline behavior to preserve)
  - Mark task complete when tests are written, run, and passing on unfixed code
  - _Requirements: 3.1, 3.2, 3.3, 3.4_

- [ ] 3. Fix pub.dev scoring issues

  - [x] 3.1 Remove web platform declaration from pubspec.yaml
    - Open pubspec.yaml
    - Remove the `web:` line from the platforms section (line 10)
    - Keep only android and ios platform declarations
    - _Bug_Condition: hasWebPlatformDeclared(pubspec) = true AND NOT hasWebImplementation(package)_
    - _Expected_Behavior: NOT hasWebPlatformDeclared(pubspec) AND hasPlatformDeclared(pubspec, "android") AND hasPlatformDeclared(pubspec, "ios")_
    - _Preservation: Preservation 3 - Platform support unchanged (android and ios only)_
    - _Requirements: 1.1, 2.1, 3.1_

  - [x] 3.2 Update SDK constraint to modern version
    - Open pubspec.yaml
    - Change SDK constraint from `sdk: '>=2.12.0 <4.0.0'` to `sdk: '>=3.3.2 <4.0.0'`
    - Update the lower bound to 3.3.2 to meet pub.dev requirements
    - _Bug_Condition: hasOutdatedSDKConstraint(pubspec) = true (2.12.0 < 3.3.0)_
    - _Expected_Behavior: sdkLowerBound(pubspec) >= 3.3.2 AND sdkUpperBound(pubspec) < 4.0.0_
    - _Preservation: Preservation 1 - Functionality unchanged_
    - _Requirements: 1.2, 2.2, 3.1_

  - [x] 3.3 Add library-level documentation to lib/background_locator.dart
    - Open lib/background_locator.dart
    - Add library-level documentation at the top of the file
    - Include brief description of BackgroundLocator's purpose
    - Add `library;` declaration after documentation
    - _Bug_Condition: hasMissingLibraryDocs(file) = true_
    - _Expected_Behavior: hasLibraryLevelDoc(file) = true_
    - _Preservation: Preservation 2 - Public API unchanged_
    - _Requirements: 1.3, 2.3, 3.2_

  - [x] 3.4 Add library-level documentation to lib/location_dto.dart
    - Open lib/location_dto.dart
    - Add library-level documentation at the top of the file
    - Include brief description of LocationDto's purpose
    - Add `library;` declaration after documentation
    - _Bug_Condition: hasMissingLibraryDocs(file) = true_
    - _Expected_Behavior: hasLibraryLevelDoc(file) = true_
    - _Preservation: Preservation 2 - Public API unchanged_
    - _Requirements: 1.3, 2.3, 3.2_

  - [x] 3.5 Add library-level documentation to lib/auto_stop_handler.dart
    - Open lib/auto_stop_handler.dart
    - Add library-level documentation at the top of the file
    - Include brief description of AutoStopHandler's purpose
    - Add `library;` declaration after documentation
    - _Bug_Condition: hasMissingLibraryDocs(file) = true_
    - _Expected_Behavior: hasLibraryLevelDoc(file) = true_
    - _Preservation: Preservation 2 - Public API unchanged_
    - _Requirements: 1.3, 2.3, 3.2_

  - [x] 3.6 Add library-level documentation to lib/settings/android_settings.dart
    - Open lib/settings/android_settings.dart
    - Add library-level documentation at the top of the file
    - Include brief description of AndroidSettings' purpose
    - Add `library;` declaration after documentation
    - _Bug_Condition: hasMissingLibraryDocs(file) = true_
    - _Expected_Behavior: hasLibraryLevelDoc(file) = true_
    - _Preservation: Preservation 2 - Public API unchanged_
    - _Requirements: 1.3, 2.3, 3.2_

  - [x] 3.7 Add library-level documentation to lib/settings/ios_settings.dart
    - Open lib/settings/ios_settings.dart
    - Add library-level documentation at the top of the file
    - Include brief description of IOSSettings' purpose
    - Add `library;` declaration after documentation
    - _Bug_Condition: hasMissingLibraryDocs(file) = true_
    - _Expected_Behavior: hasLibraryLevelDoc(file) = true_
    - _Preservation: Preservation 2 - Public API unchanged_
    - _Requirements: 1.3, 2.3, 3.2_

  - [x] 3.8 Add library-level documentation to lib/settings/locator_settings.dart
    - Open lib/settings/locator_settings.dart
    - Add library-level documentation at the top of the file
    - Include brief description of LocatorSettings' purpose
    - Add `library;` declaration after documentation
    - _Bug_Condition: hasMissingLibraryDocs(file) = true_
    - _Expected_Behavior: hasLibraryLevelDoc(file) = true_
    - _Preservation: Preservation 2 - Public API unchanged_
    - _Requirements: 1.3, 2.3, 3.2_

  - [x] 3.9 Add library-level documentation to lib/keys.dart
    - Open lib/keys.dart
    - Add library-level documentation at the top of the file
    - Include brief description of Keys' purpose
    - Add `library;` declaration after documentation
    - _Bug_Condition: hasMissingLibraryDocs(file) = true_
    - _Expected_Behavior: hasLibraryLevelDoc(file) = true_
    - _Preservation: Preservation 2 - Public API unchanged_
    - _Requirements: 1.3, 2.3, 3.2_

  - [x] 3.10 Verify bug condition exploration test now passes
    - **Property 1: Expected Behavior** - Pub.dev Scoring Issues Fixed
    - **IMPORTANT**: Re-run the SAME test from task 1 - do NOT write a new test
    - The test from task 1 encodes the expected behavior
    - When this test passes, it confirms the expected behavior is satisfied
    - Run bug condition exploration test from step 1
    - Verify web platform is removed from pubspec.yaml
    - Verify SDK constraint is updated to >=3.3.2 <4.0.0
    - Verify all public API files have library-level documentation
    - **EXPECTED OUTCOME**: Test PASSES (confirms bugs are fixed)
    - _Requirements: Expected Behavior Properties from design (2.1, 2.2, 2.3)_

  - [x] 3.11 Verify preservation tests still pass
    - **Property 2: Preservation** - Package Functionality and API Preserved
    - **IMPORTANT**: Re-run the SAME tests from task 2 - do NOT write new tests
    - Run preservation property tests from step 2
    - Verify all exports remain unchanged
    - Verify package metadata is preserved
    - Verify plugin configuration is unchanged
    - Verify dependencies are unchanged
    - **EXPECTED OUTCOME**: Tests PASS (confirms no regressions)
    - Confirm all tests still pass after fix (no regressions)

- [x] 4. Checkpoint - Ensure all tests pass
  - Run all tests to verify the fixes are complete
  - Verify pub.dev scoring issues are resolved
  - Ask the user if questions arise
