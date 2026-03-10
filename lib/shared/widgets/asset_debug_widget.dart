// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_metrics.dart';
import '../../core/theme/app_typography.dart';

/// TEMPORARY — Remove before Phase 4 screen implementation.
///
/// Loads one image ([AppImages.onboardingCity]) and one icon
/// ([AppIcons.experienceBeginner]) to confirm asset resolution at runtime.
/// If both widgets render without errors, asset bundling is correct.
class AssetDebugWidget extends StatelessWidget {
  const AssetDebugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Asset Validation', style: AppTypography.h3),
        backgroundColor: AppColors.neutral100,
      ),
      body: Padding(
        padding: AppMetrics.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Onboarding Illustration', style: AppTypography.bodySmall),
            const SizedBox(height: AppMetrics.space8),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
              child: Image.asset(
                AppImages.onboardingCity,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, error, __) {
                  return _ErrorTile(label: AppImages.onboardingCity);
                },
              ),
            ),
            const SizedBox(height: AppMetrics.space24),
            Text('Experience Icon', style: AppTypography.bodySmall),
            const SizedBox(height: AppMetrics.space8),
            Image.asset(
              AppIcons.experienceBeginner,
              height: 80,
              width: 80,
              errorBuilder: (_, error, __) {
                return _ErrorTile(label: AppIcons.experienceBeginner);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorTile extends StatelessWidget {
  const _ErrorTile({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppMetrics.space16),
      decoration: BoxDecoration(
        color: AppColors.errorRed,
        borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
      ),
      child: Text(
        '❌ Missing: $label',
        style: AppTypography.bodySmall.copyWith(color: AppColors.white),
      ),
    );
  }
}
