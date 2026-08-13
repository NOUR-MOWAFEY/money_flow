import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/core/constants/app_icons.dart';

void main() {
  group('AppIcons.searchIcons tests', () {
    test('Empty query returns all icons', () {
      final results = AppIcons.searchIcons('');
      expect(results.length, AppIcons.icons.length);
    });

    test('Query matches only relevant icons', () {
      final results = AppIcons.searchIcons('fast food');
      expect(results.any((icon) => icon.name == 'Fast Food'), isTrue);
      expect(results.any((icon) => icon.name == 'WiFi'), isFalse);
    });

    test('Sorting prioritizes startsWith matches over contains matches', () {
      // Searching for "f"
      // "Fast Food", "Food & Beverage", "Flight", "Family", etc. starts with "f"
      // "Coffee", "WiFi", "Trophy", etc. contains "f" but doesn't start with "f"
      final results = AppIcons.searchIcons('f');

      // Verify that all results contain 'f'
      for (final result in results) {
        expect(result.name.toLowerCase().contains('f'), isTrue);
      }

      // Find the index of the first item that does NOT start with 'f'
      int? firstNonPrefixIndex;
      for (int i = 0; i < results.length; i++) {
        if (!results[i].name.toLowerCase().startsWith('f')) {
          firstNonPrefixIndex = i;
          break;
        }
      }

      // If we found a non-prefix match, assert that no subsequent matches start with 'f'
      if (firstNonPrefixIndex != null) {
        for (int i = firstNonPrefixIndex; i < results.length; i++) {
          expect(
            results[i].name.toLowerCase().startsWith('f'),
            isFalse,
            reason: 'Icon "${results[i].name}" starts with "f" but was sorted after non-prefix match "${results[firstNonPrefixIndex].name}" at index $firstNonPrefixIndex',
          );
        }
      }
    });
  });
}
