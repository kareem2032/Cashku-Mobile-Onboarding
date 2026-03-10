import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_shadows.dart';
import 'package:cashku/core/theme/app_typography.dart';
import 'package:cashku/features/profiling/profiling.dart';
import 'package:cashku/shared/widgets/buttons/primary_button.dart';
import 'package:cashku/shared/widgets/cards/selectable_card.dart';
import 'package:cashku/shared/widgets/cashku_wordmark.dart';

/// Screen 06 — Investment Experience Selection
///
/// Layout (matches reference):
///   BackCircleButton  top-left
///   CashkuWordmark    centred
///   "Tell us about yourself"  royalBlue H2/H3
///   "What is your Investment Experience level?"  navyDeep H3
///   3× SelectableCard.listTile  (from AppIcons, via profilingController)
///   StepDots(count: 4, activeIndex: 2)
///   PrimaryButton "Continue"  disabled until selection
class ProfileExperienceScreen extends ConsumerWidget {
  const ProfileExperienceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profilingControllerProvider);
    final ctrl = ref.read(profilingControllerProvider.notifier);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ── Top bar ──────────────────────────────────────────────────────
              SizedBox(height: AppMetrics.onboardingTopPadding),

              const SizedBox(height: AppMetrics.space24),

              // ── Word-mark ────────────────────────────────────────────────────
              const CashkuWordmark(),

              const SizedBox(height: AppMetrics.space8),

              // ── Section title ────────────────────────────────────────────────
              Text(
                'Tell us about yourself',
                style: AppTypography.h2.copyWith(color: AppColors.navyDeep),
              ),

              const SizedBox(height: AppMetrics.space24),

              // ── Question ─────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space32,
                ),
                child: Text(
                  'What is your Investment Experience level?',
                  textAlign: TextAlign.center,
                  style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: AppMetrics.space24),

              // ── Selection cards ───────────────────────────────────────────────
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppMetrics.space24,
                  ),
                  children: [
                    _experienceCard(
                      value: InvestmentExperience.beginner,
                      assetPath: AppIcons.experienceBeginner,
                      title: 'BEGINNER',
                      subtitle: 'New to investing',
                      selected:
                          state.experience == InvestmentExperience.beginner,
                      onTap:
                          () =>
                              ctrl.setExperience(InvestmentExperience.beginner),
                    ),
                    const SizedBox(height: AppMetrics.space16),
                    _experienceCard(
                      value: InvestmentExperience.some,
                      assetPath: AppIcons.experienceSome,
                      title: 'SOME EXPERIENCE',
                      subtitle: 'I have basic knowledge of investing',
                      selected: state.experience == InvestmentExperience.some,
                      onTap:
                          () => ctrl.setExperience(InvestmentExperience.some),
                    ),
                    const SizedBox(height: AppMetrics.space16),
                    _experienceCard(
                      value: InvestmentExperience.experienced,
                      assetPath: AppIcons.experienceExperienced,
                      title: 'EXPERIENCED INVESTOR',
                      subtitle: 'I am familiar with diverse asset classes',
                      selected:
                          state.experience == InvestmentExperience.experienced,
                      onTap:
                          () => ctrl.setExperience(
                            InvestmentExperience.experienced,
                          ),
                    ),
                    const SizedBox(height: AppMetrics.space8),
                  ],
                ),
              ),

              // ── Continue button ───────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space24,
                ),
                child: PrimaryButton(
                  label: 'Continue',
                  onPressed:
                      ctrl.canContinueExperience
                          ? () => context.goNamed('profile-goals')
                          : null,
                ),
              ),

              const SizedBox(height: AppMetrics.space32),
            ],
          ),
        ),
      ),
    );
  }

  /// Wraps [SelectableCard.listTile] in a shadow-decorated [Container].
  Widget _experienceCard({
    required InvestmentExperience value,
    required String assetPath,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
        boxShadow: selected ? AppShadows.card : null,
      ),
      child: SelectableCard.listTile(
        assetPath: assetPath,
        title: title,
        subtitle: subtitle,
        isSelected: selected,
        onTap: onTap,
      ),
    );
  }
}
