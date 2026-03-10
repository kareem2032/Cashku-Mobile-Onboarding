import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';
import 'package:cashku/features/profiling/profiling.dart';
import 'package:cashku/shared/widgets/buttons/primary_button.dart';
import 'package:cashku/shared/widgets/cards/selectable_card.dart';
import 'package:cashku/shared/widgets/cashku_wordmark.dart';

/// Screen 07 — Financial Goal Selection (2×2 grid)
///
/// Layout:
///   BackCircleButton  top-left
///   CashkuWordmark    centred
///   "Tell us about yourself"  royalBlue H2
///   "What is your primary financial goal?"  navyDeep H3
///   2×2 GridView of [_GoalGridCell] (SelectableCard.grid + check badge)
///   StepDots(count: 4, activeIndex: 3)
///   PrimaryButton "Continue" → /auth/login (disabled until selection)
class ProfileGoalsScreen extends ConsumerWidget {
  const ProfileGoalsScreen({super.key});

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
                  'What is your primary financial goal?',
                  textAlign: TextAlign.center,
                  style: AppTypography.h3.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: AppMetrics.space24),

              // ── 2×2 Goal grid ────────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppMetrics.space24,
                  ),
                  child: GridView.count(
                    physics:
                        const ClampingScrollPhysics(), // Allows scrolling on short screens!
                    crossAxisCount: 2,
                    crossAxisSpacing: AppMetrics.space16,
                    mainAxisSpacing: AppMetrics.space16,
                    padding: const EdgeInsets.only(
                      bottom: AppMetrics.space24,
                    ), // Extra bottom padding
                    // childAspectRatio tuned so label is visible without clipping
                    childAspectRatio: 0.95,
                    children: [
                      _GoalGridCell(
                        assetPath: AppIcons.goalLongTermWealth,
                        label: 'Grow long-\nterm wealth',
                        goal: FinancialGoal.longTermWealth,
                        selected: state.goal == FinancialGoal.longTermWealth,
                        onTap: () => ctrl.setGoal(FinancialGoal.longTermWealth),
                      ),
                      _GoalGridCell(
                        assetPath: AppIcons.goalMajorSaving,
                        label: 'Save for a\nmajor goal',
                        goal: FinancialGoal.majorSaving,
                        selected: state.goal == FinancialGoal.majorSaving,
                        onTap: () => ctrl.setGoal(FinancialGoal.majorSaving),
                      ),
                      _GoalGridCell(
                        assetPath: AppIcons.goalPassiveIncome,
                        label: 'Generate\npassive income',
                        goal: FinancialGoal.passiveIncome,
                        selected: state.goal == FinancialGoal.passiveIncome,
                        onTap: () => ctrl.setGoal(FinancialGoal.passiveIncome),
                      ),
                      _GoalGridCell(
                        assetPath: AppIcons.goalPreserveCapital,
                        label: 'Preserve\ncapital',
                        goal: FinancialGoal.preserveCapital,
                        selected: state.goal == FinancialGoal.preserveCapital,
                        onTap:
                            () => ctrl.setGoal(FinancialGoal.preserveCapital),
                      ),
                    ],
                  ),
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
                      ctrl.canContinueGoal
                          ? () => context.goNamed('auth-login')
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
}

// ────────────────────────────────────────────────────────────────────────────
// Individual goal grid cell
// Wraps SelectableCard.grid in a Stack so the check badge can be overlaid
// at the bottom-centre of the card when selected.
// ────────────────────────────────────────────────────────────────────────────

class _GoalGridCell extends StatelessWidget {
  const _GoalGridCell({
    required this.assetPath,
    required this.label,
    required this.goal,
    required this.selected,
    required this.onTap,
  });

  final String assetPath;
  final String label;
  final FinancialGoal goal;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── Card ─────────────────────────────────────────────────────────────
        SizedBox.expand(
          child: SelectableCard.grid(
            assetPath: assetPath,
            title: label,
            isSelected: selected,
            onTap: onTap,
            maxIconSize: 56,
          ),
        ),

        // ── Check badge (visible only when selected) ──────────────────────────
        AnimatedPositioned(
          duration: const Duration(milliseconds: 180),
          bottom: selected ? AppMetrics.space8 : 4.0,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: selected ? 1.0 : 0.0,
            child: Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.royalBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
