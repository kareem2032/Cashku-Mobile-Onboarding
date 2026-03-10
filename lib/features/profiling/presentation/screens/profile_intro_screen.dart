import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/constants/app_copy.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';
import 'package:cashku/shared/widgets/buttons/primary_button.dart';

/// Screen 05 — Profile Intro
///
/// Layout (matches reference):
///   BackCircleButton  top-left
///   IllustrationCard  → AppIllustrations.profileIntro
///   "Welcome back !!!" H2 navyDeep centre
///   "Tell us about yourself" H2 navyDeep centre
///   subtitle bodyLarge neutral500 centre
///   StepDots(count: 4, activeIndex: 1)
///   PrimaryButton "Next" → /profile/experience
class ProfileIntroScreen extends StatelessWidget {
  const ProfileIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ── Top bar ──────────────────────────────────────────────────────
              SizedBox(height: AppMetrics.onboardingTopPadding),

              // ── Profile intro illustration ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space24,
                ),
                child: SizedBox(
                  height: screenH * 0.40,
                  width: double.infinity,
                  child: Image.asset(
                    AppIllustrations.profileIntro,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),

              const SizedBox(height: AppMetrics.space32),

              // ── Copy ─────────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space32,
                ),
                child: Column(
                  children: [
                    Text(
                      AppCopy.profileIntroTitle1,
                      textAlign: TextAlign.center,
                      style: AppTypography.h2.copyWith(
                        color: AppColors.navyDeep,
                      ),
                    ),
                    const SizedBox(height: AppMetrics.space8),
                    Text(
                      AppCopy.profileIntroTitle2,
                      textAlign: TextAlign.center,
                      style: AppTypography.h2.copyWith(
                        color: AppColors.navyDeep,
                      ),
                    ),
                    const SizedBox(height: AppMetrics.space16),
                    Text(
                      AppCopy.profileIntroCaption,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLarge,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ── CTA ──────────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space24,
                ),
                child: PrimaryButton(
                  label: 'Next',
                  onPressed: () => context.goNamed('profile-experience'),
                ),
              ),

              const SizedBox(height: AppMetrics.space32),
            ],
          ),
        ),
      ),
    );
  }
}
