/// CashKu — Centralized UI copy strings.
///
/// Rules:
///  - Never inline screen strings directly in widget code.
///  - All displayed text (titles, captions, button labels, links) must come
///    from this file via [AppCopy.*] constants.
///  - Wording/punctuation changes are made HERE only — screens are auto-updated.
library;

abstract final class AppCopy {
  // ── Onboarding slide 01 — Welcome ──────────────────────────────────────────
  static const String onboarding1Title = 'Welcome to Cashku';
  static const String onboarding1Caption =
      'AI-native wealth management that makes investing simple for everyday Malaysians.';

  // ── Onboarding slide 02 — Value ────────────────────────────────────────────
  static const String onboarding2Title = 'Grow wealth confidently';
  static const String onboarding2Caption =
      'Transparent fees, goal-based planning, and a smooth mobile-first experience.';

  // ── Onboarding slide 03 — AI ───────────────────────────────────────────────
  static const String onboarding3Title = 'Your plan, powered by AI';
  static const String onboarding3Caption =
      'AI-driven guidance designed to simplify choices and strengthen your financial future';

  // ── Onboarding slide 04 — Get Started ─────────────────────────────────────
  static const String onboarding4Title = 'Ready to get started?';
  static const String onboarding4Caption =
      'Start building a stronger financial future with guidance you can trust';

  // ── Profile Intro (screen 05) ──────────────────────────────────────────────
  static const String profileIntroTitle1 = 'Welcome back !!!';
  static const String profileIntroTitle2 = 'Tell us about yourself';
  static const String profileIntroCaption =
      'This helps us create a plan that matches your goals and risk level.';
}
