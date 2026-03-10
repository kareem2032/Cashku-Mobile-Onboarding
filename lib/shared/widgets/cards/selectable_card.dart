import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';

/// Layout variant for [SelectableCard].
enum SelectableCardVariant {
  /// Horizontal list-tile: leading icon (40×40), title + subtitle, trailing check.
  listTile,

  /// Vertical grid: centred icon (max 56×56), title below.
  grid,
}

/// A tappable selection card that renders an asset image and reflects
/// selected/unselected state via border colour and weight.
///
/// Two constructors cover both spec layouts:
///  - [SelectableCard.listTile] — horizontal layout with leading icon.
///  - [SelectableCard.grid]     — vertical layout with centred icon.
///
/// Both accept an [assetPath] and use [Image.asset] internally.
class SelectableCard extends StatelessWidget {
  // ── List-tile constructor ──────────────────────────────────────────────────
  const SelectableCard.listTile({
    super.key,
    required this.assetPath,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
  })  : variant = SelectableCardVariant.listTile,
        _gridMaxIconSize = null;

  // ── Grid constructor ───────────────────────────────────────────────────────
  const SelectableCard.grid({
    super.key,
    required this.assetPath,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    double maxIconSize = 56,
  })  : variant = SelectableCardVariant.grid,
        _gridMaxIconSize = maxIconSize;

  final String assetPath;
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final SelectableCardVariant variant;
  final double? _gridMaxIconSize;

  Color get _borderColor =>
      isSelected ? AppColors.royalBlue : AppColors.neutral300;
  double get _borderWidth => isSelected ? 2.0 : 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
        border: Border.all(color: _borderColor, width: _borderWidth),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
          child: variant == SelectableCardVariant.listTile
              ? _ListTileLayout(
                  assetPath: assetPath,
                  title: title,
                  subtitle: subtitle,
                  isSelected: isSelected,
                )
              : _GridLayout(
                  assetPath: assetPath,
                  title: title,
                  maxIconSize: _gridMaxIconSize ?? 56,
                ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Internal layout widgets — not exported.
// ────────────────────────────────────────────────────────────────────────────

class _ListTileLayout extends StatelessWidget {
  const _ListTileLayout({
    required this.assetPath,
    required this.title,
    this.subtitle,
    required this.isSelected,
  });

  final String assetPath;
  final String title;
  final String? subtitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMetrics.space16,
        vertical: AppMetrics.space16,
      ),
      child: Row(
        children: [
          // ── Leading icon ──────────────────────────────────────────────────
          SizedBox(
            width: 48,
            height: 48,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(width: AppMetrics.space16),

          // ── Title + subtitle ──────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.neutral900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.neutral900),
                  ),
                ],
              ],
            ),
          ),

          // ── Trailing check ────────────────────────────────────────────────
          const SizedBox(width: AppMetrics.space8),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: isSelected ? 1.0 : 0.0,
            child: Container(
              width: AppMetrics.space24,
              height: AppMetrics.space24,
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
        ],
      ),
    );
  }
}

class _GridLayout extends StatelessWidget {
  const _GridLayout({
    required this.assetPath,
    required this.title,
    required this.maxIconSize,
  });

  final String assetPath;
  final String title;
  final double maxIconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppMetrics.space16,
        vertical: AppMetrics.space16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Centred icon ──────────────────────────────────────────────────
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxIconSize,
              maxHeight: maxIconSize,
            ),
            child: Image.asset(assetPath, fit: BoxFit.contain),
          ),
          const SizedBox(height: AppMetrics.space8),

          // ── Title below icon ──────────────────────────────────────────────
          Text(
            title,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.neutral900,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
