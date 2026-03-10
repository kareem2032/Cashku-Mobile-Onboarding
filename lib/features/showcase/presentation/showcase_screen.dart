import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  DEV-ONLY — remove before shipping to production.                       │
// │  Access via:  flutter run --dart-define=SHOWCASE=true                   │
// └─────────────────────────────────────────────────────────────────────────┘

/// Full-screen gallery that lets devs jump to any Cashku screen instantly.
class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.navyDeep,
        title: Text(
          'Cashku Showcase',
          style: AppTypography.h3.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppMetrics.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── A) Onboarding ──────────────────────────────────────────────
            _SectionHeader('A · Onboarding'),
            const SizedBox(height: AppMetrics.space8),

            // Thumbnail strip
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [
                          AppImages.onboardingCity,
                          AppImages.onboardingGrowth,
                          AppImages.onboardingAi,
                          AppImages.onboardingRocket,
                        ]
                        .map(
                          (path) => Padding(
                            padding: const EdgeInsets.only(
                              right: AppMetrics.space8,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppMetrics.radiusCard,
                              ),
                              child: Image.asset(
                                path,
                                height: AppMetrics.buttonH, // 56
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: AppMetrics.space16),

            _NavTile(
              label: 'Splash Screen',
              subtitle: '/splash',
              icon: Icons.lightbulb_outline,
              onTap: () => context.go('/splash'),
            ),
            const SizedBox(height: AppMetrics.space8),
            _NavTile(
              label: 'Onboarding (PageView)',
              subtitle: '/onboarding',
              icon: Icons.swipe_outlined,
              onTap: () => context.go('/onboarding'),
            ),

            const SizedBox(height: AppMetrics.space32),

            // ── B) Profiling ───────────────────────────────────────────────
            _SectionHeader('B · Profiling'),
            const SizedBox(height: AppMetrics.space8),

            // Experience icon strip
            Row(
              children:
                  [
                        AppIcons.experienceBeginner,
                        AppIcons.experienceSome,
                        AppIcons.experienceExperienced,
                      ]
                      .map(
                        (path) => Padding(
                          padding: const EdgeInsets.only(
                            right: AppMetrics.space8,
                          ),
                          child: Image.asset(path, width: 36, height: 36),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: AppMetrics.space8),
            // Goal icon strip
            Row(
              children:
                  [
                        AppIcons.goalLongTermWealth,
                        AppIcons.goalMajorSaving,
                        AppIcons.goalPassiveIncome,
                        AppIcons.goalPreserveCapital,
                      ]
                      .map(
                        (path) => Padding(
                          padding: const EdgeInsets.only(
                            right: AppMetrics.space8,
                          ),
                          child: Image.asset(path, width: 36, height: 36),
                        ),
                      )
                      .toList(),
            ),

            const SizedBox(height: AppMetrics.space16),

            _NavTile(
              label: 'Profile Intro',
              subtitle: '/profile/intro',
              icon: Icons.person_outline_rounded,
              onTap: () => context.go('/profile/intro'),
            ),
            const SizedBox(height: AppMetrics.space8),
            _NavTile(
              label: 'Experience Selection',
              subtitle: '/profile/experience',
              icon: Icons.trending_up_rounded,
              onTap: () => context.go('/profile/experience'),
            ),
            const SizedBox(height: AppMetrics.space8),
            _NavTile(
              label: 'Goals Selection',
              subtitle: '/profile/goals',
              icon: Icons.flag_outlined,
              onTap: () => context.go('/profile/goals'),
            ),

            const SizedBox(height: AppMetrics.space32),

            // ── C) Auth ────────────────────────────────────────────────────
            _SectionHeader('C · Auth'),
            const SizedBox(height: AppMetrics.space16),

            _NavTile(
              label: 'Log In',
              subtitle: '/auth/login',
              icon: Icons.login_rounded,
              onTap: () => context.go('/auth/login'),
            ),
            const SizedBox(height: AppMetrics.space8),
            _NavTile(
              label: 'Sign Up',
              subtitle: '/auth/signup',
              icon: Icons.person_add_outlined,
              onTap: () => context.go('/auth/signup'),
            ),

            const SizedBox(height: AppMetrics.space48),

            // Dev badge
            Center(
              child: Text(
                '⚙️  DEV BUILD — remove before release',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Private helpers
// ────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.neutral100, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppMetrics.space16),
          child: Text(
            title,
            style: AppTypography.h3.copyWith(color: AppColors.navyDeep),
          ),
        ),
        Expanded(child: Divider(color: AppColors.neutral100, thickness: 1)),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMetrics.space16,
            vertical: AppMetrics.space16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
            border: Border.all(color: AppColors.neutral300),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.navyDeep.withAlpha(15),
                  borderRadius: BorderRadius.circular(AppMetrics.space8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.navyDeep,
                  size: AppMetrics.space24,
                ),
              ),
              const SizedBox(width: AppMetrics.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTypography.bodyLarge),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.neutral300,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
