import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_typography.dart';

/// A lightweight "Skip" text button for use in onboarding flows.
///
/// Typically placed at the top-right of the screen.
/// Color: [AppColors.navyDeep].
/// Style: [AppTypography.bodyLarge] (optionally [AppTypography.bodySmall]).
class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
    required this.onPressed,
    this.label = 'Skip',
    this.useBodySmall = false,
  });

  final VoidCallback onPressed;

  /// Button label — defaults to 'Skip'.
  final String label;

  /// When true, uses [AppTypography.bodySmall]; otherwise [AppTypography.bodyLarge].
  final bool useBodySmall;

  @override
  Widget build(BuildContext context) {
    final style = (useBodySmall ? AppTypography.bodySmall : AppTypography.bodyLarge)
        .copyWith(color: AppColors.navyDeep);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.navyDeep,
        overlayColor: AppColors.navyDeep,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, style: style),
    );
  }
}
