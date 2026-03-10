import 'package:flutter/material.dart';

/// CashKu Design System — Shadow Tokens
///
/// Input shadow spec: offset(0, 6), blurRadius 20, subtle black opacity.
/// Use these lists via [BoxDecoration.boxShadow] — never inline raw values.
abstract final class AppShadows {
  // ── Input / Field Shadow ────────────────────────────────────────────────────
  /// Applied to text fields and search bars.
  /// Offset Y=6, Blur=20, spread=0, opacity=8%.
  static const List<BoxShadow> input = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      offset: Offset(0, 6),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  // ── Card Shadow ──────────────────────────────────────────────────────────────
  /// Subtle lift for cards and modals.
  /// Offset Y=4, Blur=16, spread=0, opacity=6%.
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  // ── Button Shadow ────────────────────────────────────────────────────────────
  /// Branded teal glow for primary elevated buttons.
  /// Offset Y=6, Blur=20, spread=0, opacity=30%.
  static const List<BoxShadow> button = [
    BoxShadow(
      color: Color.fromRGBO(0, 235, 207, 0.30),
      offset: Offset(0, 6),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];
}
