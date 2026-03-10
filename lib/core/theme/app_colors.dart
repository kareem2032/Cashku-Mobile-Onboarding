import 'package:flutter/material.dart';

/// CashKu Design System — Colour Tokens
///
/// Rules:
///  - No raw hex values are allowed anywhere outside this file.
///  - Semantic names (e.g. [navyDeep], [royalBlue]) are distinct even when
///    two tokens share the same sRGB value, because they carry different
///    *intent* and may diverge in future revisions.
abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  /// Deep navy used for hero backgrounds and high-emphasis surfaces.
  static const Color navyDeep = Color(0xFF08197C);

  /// Royal blue — primary brand accent, CTAs, and active states.
  static const Color royalBlue = Color(0xFF0E35AF);

  /// Teal — secondary accent, highlights, and success states.
  static const Color teal = Color(0xFF00EBCF);

  // ── Neutrals ───────────────────────────────────────────────────────────────
  /// Primary text
  static const Color neutral900 = Color(0xFF121626);

  /// Secondary text and subheadings.
  static const Color neutral700 = Color(0xFF3D485C);

  /// Placeholder text and captions.
  static const Color neutral500 = Color(0xFF727C8F);

  /// Borders, dividers, and inactive indicators.
  static const Color neutral300 = Color(0xFFD3D7E0);

  /// Subtle backgrounds, chips, and tags.
  static const Color neutral100 = Color(0xFFF5F6F9);

  /// Pure white — surfaces, cards, and scaffold background.
  static const Color white = Color(0xFFFFFFFF);

  // ── System ─────────────────────────────────────────────────────────────────
  /// Destructive / validation error colour.
  static const Color errorRed = Color(0xFFFF0826);
}
