import 'package:flutter_test/flutter_test.dart';
import 'package:cashku/core/theme/app_theme.dart';

void main() {
  test('AppTheme globally enforces Quicksand on all TextStyles', () {
    final theme = buildAppTheme();

    // Check global fallback
    expect(
      theme.textTheme.bodyLarge?.fontFamily,
      'Quicksand',
      reason: 'bodyLarge should inherit Quicksand from ThemeData',
    );
    expect(
      theme.textTheme.displayLarge?.fontFamily,
      'Quicksand',
      reason: 'displayLarge should inherit Quicksand from ThemeData',
    );
    expect(
      theme.textTheme.labelLarge?.fontFamily,
      'Quicksand',
      reason: 'labelLarge should inherit Quicksand from ThemeData',
    );

    print(
      '✅ Verified: bodyLarge fontFamily is ${theme.textTheme.bodyLarge?.fontFamily}',
    );
    print(
      '✅ Verified: displayLarge fontFamily is ${theme.textTheme.displayLarge?.fontFamily}',
    );
    print(
      '✅ Verified: labelLarge fontFamily is ${theme.textTheme.labelLarge?.fontFamily}',
    );
  });
}
