import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';

/// CashKu secondary (outlined) button.
///
/// - Height 56, radius 14, bg white.
/// - Border 1 px, color configurable via [borderColor] (default: navyDeep).
/// - Text color: [AppColors.navyDeep] unless [textColor] is overridden.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderColor = AppColors.navyDeep,
    this.textColor = AppColors.navyDeep,
    this.fullWidth = true,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;

  /// Border stroke color — use [AppColors.navyDeep], [AppColors.royalBlue],
  /// or [AppColors.neutral900] per spec.
  final Color borderColor;

  /// Label color — defaults to [AppColors.navyDeep].
  final Color textColor;

  final bool fullWidth;
  final Widget? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: AppMetrics.buttonH,
      child: OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: textColor,
          disabledForegroundColor: AppColors.neutral300,
          side: BorderSide(
            color: disabled ? AppColors.neutral300 : borderColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusBtn),
          ),
          minimumSize: const Size.fromHeight(AppMetrics.buttonH),
          textStyle: AppTypography.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppMetrics.space24,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: AppMetrics.space8),
                  ],
                  Text(
                    label,
                    style: AppTypography.button.copyWith(color: textColor),
                  ),
                ],
              ),
      ),
    );
  }
}
