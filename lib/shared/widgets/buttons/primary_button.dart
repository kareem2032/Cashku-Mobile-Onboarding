import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';

/// CashKu primary CTA button.
///
/// - Height 56, radius 14, full-width by default.
/// - Default bg: [AppColors.navyDeep]
/// - Pressed bg: navyDeep at 90% opacity
/// - Disabled bg: navyDeep at 60% opacity
/// - Text: [AppTypography.button] in white.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool fullWidth;

  /// Optional leading icon shown before the label.
  final Widget? icon;

  bool get _isDisabled => onPressed == null || isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: AppMetrics.buttonH,
      child: _PrimaryInk(
        onPressed: _isDisabled ? null : onPressed,
        isLoading: isLoading,
        isDisabled: _isDisabled,
        icon: icon,
        label: label,
      ),
    );
  }
}

class _PrimaryInk extends StatefulWidget {
  const _PrimaryInk({
    required this.onPressed,
    required this.isLoading,
    required this.isDisabled,
    required this.label,
    this.icon,
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final String label;
  final Widget? icon;

  @override
  State<_PrimaryInk> createState() => _PrimaryInkState();
}

class _PrimaryInkState extends State<_PrimaryInk> {
  bool _pressed = false;

  Color get _bgColor {
    if (widget.isDisabled) {
      return AppColors.navyDeep.withAlpha(153); // 60%
    }
    if (_pressed) {
      return AppColors.navyDeep.withAlpha(230); // 90%
    }
    return AppColors.navyDeep; // 100%
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(AppMetrics.radiusBtn),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppMetrics.radiusBtn),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(AppMetrics.radiusBtn),
          onHighlightChanged: (v) => setState(() => _pressed = v),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        widget.icon!,
                        const SizedBox(width: AppMetrics.space8),
                      ],
                      Text(
                        widget.label,
                        style: AppTypography.button
                            .copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
