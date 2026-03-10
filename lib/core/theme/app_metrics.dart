import 'package:flutter/material.dart';

/// CashKu Design System — Spacing & Metrics Tokens
///
/// All spacing follows the 8pt grid. Never use raw numbers in screens —
/// import this file instead.
abstract final class AppMetrics {
  // ── 8pt Spacing Grid ────────────────────────────────────────────────────────
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space16 = 16.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;
  static const double space72 = 72.0;
  static const double space80 = 80.0;

  // ── Component Heights ───────────────────────────────────────────────────────
  static const double buttonH = 56.0;
  static const double inputH = 56.0;

  // ── Border Radii ────────────────────────────────────────────────────────────
  static const double radiusBtn = 14.0;
  static const double radiusInput = 12.0;
  static const double radiusCard = 12.0;

  // ── Navigation ──────────────────────────────────────────────────────────────
  static const double navDotSize = 8.0;

  // ── Screen-level Layout ─────────────────────────────────────────────────────
  static const double onboardingTopPadding = 44.0;

  // ── Convenient EdgeInsets helpers ───────────────────────────────────────────
  /// Standard horizontal screen margin (16 each side).
  static const EdgeInsets screenPaddingH =
      EdgeInsets.symmetric(horizontal: space16);

  /// Standard full-screen padding (24 horizontal, 24 vertical).
  static const EdgeInsets screenPadding =
      EdgeInsets.symmetric(horizontal: space24, vertical: space24);
}
