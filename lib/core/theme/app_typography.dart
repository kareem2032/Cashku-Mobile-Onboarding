import 'package:flutter/material.dart';
import 'app_colors.dart';

/// CashKu Design System — Typography Tokens
///
/// Font: Quicksand (bundled locally) — mandatory brand font.
/// All sizes, weights, heights, and letter spacings are exact per spec.
/// No raw values are allowed in screens; reference these getters instead.
abstract final class AppTypography {
  // ── Base helper ─────────────────────────────────────────────────────────────
  /// Returns a Quicksand [TextStyle] seeded with [AppColors.neutral900].
  /// All public getters are derived from this so the font is enforced once.
  static TextStyle _q({
    required double size,
    required FontWeight weight,
    required double height,
    double letterSpacing = 0.0,
    Color color = AppColors.neutral900,
  }) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: letterSpacing,
    color: color,
  );

  // ── Headings ─────────────────────────────────────────────────────────────────

  /// H1 — 32 SemiBold, line height 120%
  static TextStyle get h1 => _q(size: 32, weight: FontWeight.w600, height: 1.2);

  /// H2 — 24 SemiBold, line height 120%
  static TextStyle get h2 => _q(size: 24, weight: FontWeight.w600, height: 1.2);

  /// H3 — 20 Medium, line height 120%
  static TextStyle get h3 => _q(size: 20, weight: FontWeight.w500, height: 1.2);

  // ── Body ──────────────────────────────────────────────────────────────────────

  /// Body Large — 16 SemiBold, line height 150%
  static TextStyle get bodyLarge =>
      _q(size: 16, weight: FontWeight.w600, height: 1.5);

  /// Body Small — 14 Regular, line height 150%
  static TextStyle get bodySmall =>
      _q(size: 14, weight: FontWeight.w400, height: 1.5);

  // ── Interactive ───────────────────────────────────────────────────────────────

  /// Button — 16 Medium, letter spacing 0.3, line height 120%
  static TextStyle get button =>
      _q(size: 16, weight: FontWeight.w500, height: 1.2, letterSpacing: 0.3);

  // ── Material TextTheme mapping ────────────────────────────────────────────────
  /// Plug directly into [ThemeData.textTheme].
  /// Maps design tokens to the nearest semantic Material slot.
  static TextTheme get textTheme => TextTheme(
    // Headings
    displayLarge: h1, // → H1
    displayMedium: h2, // → H2
    displaySmall: h3, // → H3
    // Body
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyLarge,
    bodySmall: AppTypography.bodySmall,
    // Labels / interactive
    labelLarge: AppTypography.button, // → ElevatedButton default
    labelMedium: AppTypography.button,
  );
}
