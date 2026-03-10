import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';

/// A row of progress step dots.
///
/// - Dot size: [AppMetrics.navDotSize] (8 px).
/// - Active dot  → [AppColors.navyDeep]
/// - Inactive dot → [AppColors.neutral300]
///
/// Usage:
/// ```dart
/// StepDots(count: 4, activeIndex: 1)
/// ```
class StepDots extends StatelessWidget {
  const StepDots({
    super.key,
    required this.count,
    required this.activeIndex,
    this.spacing = AppMetrics.space8,
  });

  /// Total number of steps / dots.
  final int count;

  /// Zero-based index of the currently active dot.
  final int activeIndex;

  /// Gap between adjacent dots; defaults to [AppMetrics.space8].
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(right: i < count - 1 ? spacing : 0),
          width: isActive ? AppMetrics.navDotSize * 2.5 : AppMetrics.navDotSize,
          height: AppMetrics.navDotSize,
          decoration: BoxDecoration(
            color: isActive ? AppColors.navyDeep : AppColors.neutral300,
            borderRadius: BorderRadius.circular(AppMetrics.navDotSize / 2),
          ),
        );
      }),
    );
  }
}
