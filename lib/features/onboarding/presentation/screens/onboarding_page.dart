import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';
import 'package:cashku/features/onboarding/domain/onboarding_page_model.dart';
import 'package:cashku/shared/widgets/cards/illustration_card.dart';
import 'package:cashku/shared/widgets/cashku_wordmark.dart';

/// Reusable layout for a single onboarding page.
///
/// Renders:
///   [IllustrationCard]  ← hero image (rounded 12)
///   [_CashkuWordmark]   ← branded "cashku" word-mark
///   title               ← H2, royalBlue, centred
///   subtitle            ← bodyLarge, neutral500, centred
///
/// The parent [OnboardingShell] supplies sizing constraints and scrolling.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.model});

  final OnboardingPageModel model;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppMetrics.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Hero illustration ────────────────────────────────────────────
          Flexible(
            fit: FlexFit.loose,
            child: IllustrationCard(
              assetPath: model.imageAsset,
              height: screenH * 0.42,
              width: double.infinity,
              fit: BoxFit.contain,
              showShadow: false,
              backgroundColor: AppColors.white,
            ),
          ),

          const SizedBox(height: AppMetrics.space24),

          // ── Cashku word-mark ─────────────────────────────────────────────
          const CashkuWordmark(),

          const SizedBox(height: AppMetrics.space16),

          // ── Title ────────────────────────────────────────────────────────
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: AppTypography.h2.copyWith(color: AppColors.navyDeep),
          ),

          const SizedBox(height: AppMetrics.space8),

          // ── Subtitle ─────────────────────────────────────────────────────
          Text(
            model.subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge,
          ),
        ],
      ),
    );
  }
}
