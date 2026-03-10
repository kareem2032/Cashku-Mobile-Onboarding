/// CashKu Design System — Asset Path Constants
///
/// Rules:
///  - Never use raw asset strings in screens or widgets.
///  - Always reference the appropriate class constants.
///  - Paths must exactly match the file names registered in pubspec.yaml.
library;

// ────────────────────────────────────────────────────────────────────────────
/// Brand assets located in `assets/branding/`.
abstract final class AppBranding {
  /// Logo mark (icon only — circular teal chat-bubble with navy glyph).
  static const String logoMark = 'assets/branding/cashku_logo_mark.png';

  /// Full wordmark (text logo: "cashku").
  static const String wordmark = 'assets/branding/cashku_wordmark.png';
}

// ────────────────────────────────────────────────────────────────────────────
/// Social provider icons located in `assets/icons/`.
abstract final class AppSocialIcons {
  /// Google sign-in icon.
  static const String google = 'assets/icons/icon_google.png';

  /// Apple sign-in icon.
  static const String apple = 'assets/icons/icon_apple.png';
}

// ────────────────────────────────────────────────────────────────────────────
/// Screen illustrations located in `assets/images/`.
abstract final class AppIllustrations {
  /// Profile intro — "Tell us about yourself" illustration.
  static const String profileIntro =
      'assets/images/illustration_profile_intro.png';
}

// ────────────────────────────────────────────────────────────────────────────
/// Onboarding illustration PNGs located in `assets/images/`.
abstract final class AppImages {
  /// Cityscape illustration — Onboarding slide 1.
  static const String onboardingCity =
      'assets/images/cashku_onboarding_city.png';

  /// Growth chart illustration — Onboarding slide 2.
  static const String onboardingGrowth =
      'assets/images/cashku_onboarding_growth.png';

  /// AI / robot illustration — Onboarding slide 3.
  static const String onboardingAi = 'assets/images/cashku_onboarding_ai.png';

  /// Rocket launch illustration — Onboarding slide 4.
  static const String onboardingRocket =
      'assets/images/cashku_onboarding_rocket.png';
}

// ────────────────────────────────────────────────────────────────────────────
/// Icon PNGs located in `assets/icons/`.
abstract final class AppIcons {
  // ── Navigation icons ──────────────────────────────────────────────────────
  /// Custom back arrow icon.
  static const String backArrow = 'assets/icons/back_arrow.svg';

  // ── Experience level icons ──────────────────────────────────────────────
  /// Beginner experience level selection icon.
  static const String experienceBeginner =
      'assets/icons/icon_experience_beginner.png';

  /// Some experience level selection icon.
  static const String experienceSome = 'assets/icons/icon_experience_some.png';

  /// Experienced level selection icon.
  static const String experienceExperienced =
      'assets/icons/icon_experience_experienced.png';

  // ── Financial goal icons ────────────────────────────────────────────────
  /// Long-term wealth goal icon.
  static const String goalLongTermWealth =
      'assets/icons/icon_goal_long_term_wealth.png';

  /// Major savings goal icon.
  static const String goalMajorSaving =
      'assets/icons/icon_goal_major_saving.png';

  /// Passive income goal icon.
  static const String goalPassiveIncome =
      'assets/icons/icon_goal_passive_income.png';

  /// Preserve capital goal icon.
  static const String goalPreserveCapital =
      'assets/icons/icon_goal_preserve_capital.png';
}
