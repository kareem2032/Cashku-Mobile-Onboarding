import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_metrics.dart';
import 'app_typography.dart';

/// CashKu Design System — Root ThemeData
///
/// Entry point: call [buildAppTheme()] and pass the result to
/// [MaterialApp.router]'s `theme` parameter.
///
/// Rules enforced here so widgets stay hex-free:
///  - Scaffold background = [AppColors.white]
///  - All text colours route through [ColorScheme] / [textTheme]
///  - Button heights = 56, radii = 14 (elevated) and 14 (outlined)
///  - Input height = 56, radius = 12 — configured via [InputDecorationTheme]
ThemeData buildAppTheme() {
  // ── Colour scheme ────────────────────────────────────────────────────────────
  const colorScheme = ColorScheme(
    brightness: Brightness.light,
    // Primary
    primary: AppColors.royalBlue,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.neutral100,
    onPrimaryContainer: AppColors.navyDeep,
    // Secondary (teal accent)
    secondary: AppColors.teal,
    onSecondary: AppColors.navyDeep,
    secondaryContainer: AppColors.neutral100,
    onSecondaryContainer: AppColors.navyDeep,
    // Tertiary (unused by default, kept for flexibility)
    tertiary: AppColors.navyDeep,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.neutral100,
    onTertiaryContainer: AppColors.neutral900,
    // Error
    error: AppColors.errorRed,
    onError: AppColors.white,
    errorContainer: Color(
      0xFFFFE5E8,
    ), // light tint of errorRed — no raw hex below
    onErrorContainer: AppColors.errorRed,
    // Surface / background
    surface: AppColors.white,
    onSurface: AppColors.neutral900,
    surfaceContainerHighest: AppColors.neutral100,
    onSurfaceVariant: AppColors.neutral700,
    // Outline / divider
    outline: AppColors.neutral300,
    outlineVariant: AppColors.neutral100,
    // Shadow & scrim
    shadow: Color.fromRGBO(0, 0, 0, 0.08),
    scrim: Color.fromRGBO(0, 0, 0, 0.40),
    // Inverse (for snackbars etc.)
    inverseSurface: AppColors.neutral900,
    onInverseSurface: AppColors.white,
    inversePrimary: AppColors.teal,
  );

  // ── Shared button shape ──────────────────────────────────────────────────────
  final btnShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppMetrics.radiusBtn),
  );

  // ── Shared button size ───────────────────────────────────────────────────────
  const btnMinSize = Size.fromHeight(AppMetrics.buttonH);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,

    // ── Global font application ──────────────────────────────────────────────
    // Applies Quicksand globally across all DefaultTextStyle descendants.
    fontFamily: 'Quicksand',
    textTheme: ThemeData.light().textTheme
        .apply(
          fontFamily: 'Quicksand',
          bodyColor: AppColors.neutral900,
          displayColor: AppColors.neutral900,
        )
        .merge(AppTypography.textTheme),

    // ── Scaffold ─────────────────────────────────────────────────────────────
    scaffoldBackgroundColor: AppColors.white,

    // ── AppBar ───────────────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.neutral900,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.h2,
      iconTheme: const IconThemeData(color: AppColors.neutral700),
    ),

    // ── Elevated Button ──────────────────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.royalBlue,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.neutral300,
        disabledForegroundColor: AppColors.neutral500,
        minimumSize: btnMinSize,
        shape: btnShape,
        textStyle: AppTypography.button,
        elevation: 0,
      ),
    ),

    // ── Outlined Button ──────────────────────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.royalBlue,
        disabledForegroundColor: AppColors.neutral300,
        minimumSize: btnMinSize,
        shape: btnShape,
        side: const BorderSide(color: AppColors.royalBlue, width: 1.5),
        textStyle: AppTypography.button,
      ),
    ),

    // ── Text Button ──────────────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.royalBlue,
        textStyle: AppTypography.button,
        minimumSize: btnMinSize,
        shape: btnShape,
      ),
    ),

    // ── Input Decoration ─────────────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      hintStyle: AppTypography.bodyLarge.copyWith(color: AppColors.neutral500),
      labelStyle: AppTypography.bodySmall.copyWith(color: AppColors.neutral700),
      floatingLabelStyle: AppTypography.bodySmall.copyWith(
        color: AppColors.royalBlue,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppMetrics.space16,
        vertical: AppMetrics.space16,
      ),
      // Default border — no visible ring; shadow provides depth instead.
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusInput),
        borderSide: const BorderSide(color: AppColors.neutral300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusInput),
        borderSide: const BorderSide(color: AppColors.neutral300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusInput),
        borderSide: const BorderSide(color: AppColors.royalBlue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusInput),
        borderSide: const BorderSide(color: AppColors.errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusInput),
        borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
      ),
      errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.errorRed),
    ),

    // ── Card ─────────────────────────────────────────────────────────────────
    cardTheme: CardTheme(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
      ),
      margin: EdgeInsets.zero,
    ),

    // ── Divider ──────────────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.neutral300,
      thickness: 1,
      space: 1,
    ),

    // ── Icon ─────────────────────────────────────────────────────────────────
    iconTheme: const IconThemeData(color: AppColors.neutral700),
    primaryIconTheme: const IconThemeData(color: AppColors.royalBlue),
  );
}
