import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';

/// A circular back-navigation button.
///
/// Container background: [AppColors.neutral100].
/// Icon: [Icons.arrow_back], color: [AppColors.navyDeep].
/// Size: 40×40 circle.
class BackCircleButton extends StatelessWidget {
  const BackCircleButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.arrow_back,
    this.size = 40.0,
  });

  final VoidCallback onPressed;

  /// Override the icon (e.g. [Icons.close]) when needed.
  final IconData icon;

  /// Diameter of the circle. Defaults to 40.
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: AppColors.neutral100,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Center(
            child:
                icon == Icons.arrow_back
                    ? SvgPicture.asset(
                      AppIcons.backArrow,
                      width: AppMetrics.space24,
                      height: AppMetrics.space24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.navyDeep,
                        BlendMode.srcIn,
                      ),
                    )
                    : Icon(
                      icon,
                      color: AppColors.navyDeep,
                      size: AppMetrics.space24,
                    ),
          ),
        ),
      ),
    );
  }
}
