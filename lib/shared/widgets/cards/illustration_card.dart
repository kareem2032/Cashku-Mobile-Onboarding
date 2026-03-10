import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_shadows.dart';

/// A rounded container that holds an onboarding illustration or any child.
///
/// - Corner radius: [AppMetrics.radiusCard] (12).
/// - Optional [AppShadows.card] shadow (enabled by default).
/// - [assetPath]: when provided, renders [Image.asset] filling the container.
/// - [child]: for custom content; ignored when [assetPath] is provided.
class IllustrationCard extends StatelessWidget {
  const IllustrationCard({
    super.key,
    this.assetPath,
    this.child,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.showShadow = true,
    this.backgroundColor = AppColors.neutral100,
    this.padding = EdgeInsets.zero,
  }) : assert(
          assetPath != null || child != null,
          'Provide either an assetPath or a child widget.',
        );

  /// Asset path string — use an [AppImages] constant, never a raw string.
  final String? assetPath;

  /// Custom child rendered when [assetPath] is null.
  final Widget? child;

  final double? height;
  final double? width;

  /// How the image should be inscribed into the space (ignored for [child]).
  final BoxFit fit;

  /// Whether to apply [AppShadows.card]. Defaults to true.
  final bool showShadow;

  /// Background colour behind the illustration.
  final Color backgroundColor;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
        boxShadow: showShadow ? AppShadows.card : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: assetPath != null
          ? Image.asset(
              assetPath!,
              fit: fit,
              errorBuilder: (_, __, ___) => const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: AppColors.neutral300,
                  size: 40,
                ),
              ),
            )
          : child,
    );
  }
}
