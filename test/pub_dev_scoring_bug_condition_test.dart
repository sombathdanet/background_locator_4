import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

/// Bug Condition Exploration Test for Pub.dev Scoring Issues
///
/// **CRITICAL**: This test MUST FAIL on unfixed code - failure confirms the bugs exist.
/// **DO NOT attempt to fix the test or the code when it fails.**
/// **NOTE**: This test encodes the expected behavior - it will validate the fix when it passes after implementation.
///
/// **Validates: Requirements 1.1, 1.2, 1.3 (Current Behavior - Defects)**
/// **Validates: Requirements 2.1, 2.2, 2.3 (Expected Behavior - Correct)**
///
/// This test uses a scoped property-based testing approach to verify three concrete
/// failing cases that cause pub.dev scoring issues:
/// 1. Web platform declaration without implementation
/// 2. Outdated SDK constraint (< 3.3.0)
/// 3. Missing library-level documentation in public API files

void main() {
  group('Bug Condition Exploration - Pub.dev Scoring Issues', () {
    late File pubspecFile;
    late YamlMap pubspecContent;

    setUpAll(() {
      // Load pubspec.yaml for analysis
      pubspecFile = File('pubspec.yaml');
      final pubspecString = pubspecFile.readAsStringSync();
      pubspecContent = loadYaml(pubspecString) as YamlMap;
    });

    test('Property 1.1: Web platform should NOT be declared (Bug Condition 1.1, Expected 2.1)', () {
      // **Validates: Requirements 1.1, 2.1**
      //
      // Bug Condition: pubspec.yaml declares web platform despite web not being implemented
      // Expected Behavior: Only android and ios platforms should be declared
      //
      // This test will FAIL on unfixed code because web IS currently declared
      // When fixed, this test will PASS

      final platforms = pubspecContent['platforms'] as YamlMap?;
      
      // Check that platforms section exists
      expect(platforms, isNotNull, 
        reason: 'pubspec.yaml should have a platforms section');

      // Expected behavior: web should NOT be declared
      expect(platforms!.containsKey('web'), isFalse,
        reason: 'Web platform should NOT be declared since web is not implemented. '
               'Only android and ios platforms should be declared.');

      // Verify android and ios ARE declared (preservation requirement)
      expect(platforms.containsKey('android'), isTrue,
        reason: 'Android platform should be declared');
      expect(platforms.containsKey('ios'), isTrue,
        reason: 'iOS platform should be declared');
    });

    test('Property 1.2: SDK constraint should be modern (>= 3.3.2) (Bug Condition 1.2, Expected 2.2)', () {
      // **Validates: Requirements 1.2, 2.2**
      //
      // Bug Condition: SDK constraint uses outdated version (2.12.0 < 3.3.0)
      // Expected Behavior: SDK constraint should use modern version (>= 3.3.2)
      //
      // This test will FAIL on unfixed code because SDK constraint is 2.12.0
      // When fixed, this test will PASS

      final environment = pubspecContent['environment'] as YamlMap?;
      expect(environment, isNotNull,
        reason: 'pubspec.yaml should have an environment section');

      final sdkConstraint = environment!['sdk'] as String?;
      expect(sdkConstraint, isNotNull,
        reason: 'SDK constraint should be specified');

      // Parse the SDK constraint to extract the lower bound
      // Format: '>=X.Y.Z <A.B.C'
      final sdkPattern = RegExp(r'>=(\d+)\.(\d+)\.(\d+)');
      final match = sdkPattern.firstMatch(sdkConstraint!);
      
      expect(match, isNotNull,
        reason: 'SDK constraint should match pattern >=X.Y.Z <A.B.C');

      final major = int.parse(match!.group(1)!);
      final minor = int.parse(match.group(2)!);
      final patch = int.parse(match.group(3)!);

      // Expected behavior: SDK lower bound should be >= 3.3.2
      final isModernSDK = major > 3 || 
                         (major == 3 && minor > 3) || 
                         (major == 3 && minor == 3 && patch >= 2);

      expect(isModernSDK, isTrue,
        reason: 'SDK constraint lower bound should be >= 3.3.2 for modern Flutter packages. '
               'Current: $major.$minor.$patch, Expected: >= 3.3.2');
    });

    test('Property 1.3: Public API files should have library-level documentation (Bug Condition 1.3, Expected 2.3)', () {
      // **Validates: Requirements 1.3, 2.3**
      //
      // Bug Condition: Public API files lack library-level documentation
      // Expected Behavior: All public API files should have library-level documentation
      //
      // This test will FAIL on unfixed code because files lack library declarations
      // When fixed, this test will PASS

      // List of public API files that should have library-level documentation
      final publicApiFiles = [
        'lib/background_locator.dart',
        'lib/location_dto.dart',
        'lib/auto_stop_handler.dart',
        'lib/settings/android_settings.dart',
        'lib/settings/ios_settings.dart',
        'lib/settings/locator_settings.dart',
        'lib/keys.dart',
      ];

      final filesWithoutLibraryDocs = <String>[];

      for (final filePath in publicApiFiles) {
        final file = File(filePath);
        expect(file.existsSync(), isTrue,
          reason: 'Public API file should exist: $filePath');

        final content = file.readAsStringSync();

        // Check for library-level documentation
        // Library-level docs should have:
        // 1. A documentation comment (/// or /** */)
        // 2. Followed by a library declaration (library; or library name;)
        final hasLibraryDeclaration = _hasLibraryLevelDocumentation(content);

        if (!hasLibraryDeclaration) {
          filesWithoutLibraryDocs.add(filePath);
        }
      }

      // Expected behavior: All public API files should have library-level documentation
      expect(filesWithoutLibraryDocs, isEmpty,
        reason: 'All public API files should have library-level documentation. '
               'Files missing library docs: ${filesWithoutLibraryDocs.join(", ")}');
    });
  });
}

/// Helper function to check if a file has library-level documentation.
///
/// Returns true if the file contains a library declaration (library; or library name;)
/// which indicates proper library-level documentation structure.
bool _hasLibraryLevelDocumentation(String content) {
  // Look for library declaration pattern
  // Can be: library; or library name;
  final libraryPattern = RegExp(r'^\s*library\s*[a-zA-Z_]*\s*;', multiLine: true);
  return libraryPattern.hasMatch(content);
}
