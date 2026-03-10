import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/features/onboarding/onboarding.dart';
import 'package:cashku/shared/widgets/buttons/primary_button.dart';
import 'package:cashku/shared/widgets/indicators/step_dots.dart';
import 'package:cashku/shared/widgets/nav/skip_button.dart';
import 'onboarding_page.dart';

/// Screen 01–04 — Onboarding PageView shell.
///
/// Owns the [PageController] and keeps it in sync with [OnboardingController].
/// All page content is delegated to [OnboardingPage].
class OnboardingShell extends ConsumerStatefulWidget {
  const OnboardingShell({super.key});

  @override
  ConsumerState<OnboardingShell> createState() => _OnboardingShellState();
}

class _OnboardingShellState extends ConsumerState<OnboardingShell> {
  late final PageController _pageCtrl;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _skipOrFinish() => context.goNamed('profile-intro');

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final ctrl = ref.read(onboardingControllerProvider.notifier);
    final idx = state.pageIndex;
    final total = kOnboardingPages.length;
    final isLast = ctrl.isLastPage;

    return PopScope(
      // Block Android back gesture/button on page 3 (Get Started).
      // Pages 0-2 allow the default swipe-to-go-back behaviour.
      canPop: !isLast,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ── Top bar ────────────────────────────────────────────────
              // No back arrow on any page. Skip visible on pages 0-2.
              SizedBox(height: AppMetrics.onboardingTopPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space24,
                ),
                child: Row(
                  children: [
                    // Blank space where back button used to be (keeps width)
                    const SizedBox(width: 40),
                    const Spacer(),
                    // Skip — visible on pages 0-2, hidden on page 3
                    if (!isLast) SkipButton(onPressed: _skipOrFinish),
                  ],
                ),
              ),

              const SizedBox(height: AppMetrics.space24),

              // ── PageView ──────────────────────────────────────────────
              Expanded(
                child: PageView.builder(
                  controller: _pageCtrl,
                  physics: const ClampingScrollPhysics(),
                  itemCount: total,
                  onPageChanged: (i) => ctrl.setIndex(i),
                  itemBuilder:
                      (_, i) => OnboardingPage(
                        key: ValueKey(i),
                        model: kOnboardingPages[i],
                      ),
                ),
              ),

              const SizedBox(height: AppMetrics.space32),

              // ── Bottom area ────────────────────────────────────────────
              // Pages 0-2: centered dots only (no arrows).
              // Page 3:    Get Started full-width button.
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space24,
                ),
                child: isLast ? _buildGetStarted() : _buildDotsOnly(idx, total),
              ),

              const SizedBox(height: AppMetrics.space32),
            ],
          ),
        ),
      ),
    );
  }

  // ── Last page: full-width Get Started button ──────────────────────────────
  Widget _buildGetStarted() {
    return PrimaryButton(label: 'Get Started', onPressed: _skipOrFinish);
  }

  // ── Pages 0-2: dots only (no arrows) ─────────────────────────────────────
  Widget _buildDotsOnly(int idx, int total) {
    return Center(child: StepDots(count: total, activeIndex: idx));
  }
}
