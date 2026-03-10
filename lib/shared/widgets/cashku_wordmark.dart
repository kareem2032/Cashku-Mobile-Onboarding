import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_typography.dart';

/// CashKu branded word-mark displayed on Onboarding pages and Auth screens.
///
/// Attempts to load [AppBranding.wordmark] PNG first.
/// Falls back to the inline CustomPaint word-mark if the asset is missing
/// (e.g. when running from a fresh checkout before assets are embedded).
///
/// Swap the [_useAsset] flag once the PNG ships in all builds.
class CashkuWordmark extends StatelessWidget {
  const CashkuWordmark({super.key, this.fontSize = 26.0});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Constrain width so it never overflows on narrow screens.
        final maxW = constraints.maxWidth.isInfinite
            ? 260.0
            : constraints.maxWidth.clamp(120.0, 260.0);

        return SizedBox(
          width: maxW,
          child: Image.asset(
            AppBranding.wordmark,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            errorBuilder: (_, __, ___) => _InlineWordmark(fontSize: fontSize),
          ),
        );
      },
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Inline fallback — CustomPaint word-mark used when PNG is unavailable.
// ────────────────────────────────────────────────────────────────────────────

class _InlineWordmark extends StatelessWidget {
  const _InlineWordmark({required this.fontSize});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTypography.h2.copyWith(
      fontSize: fontSize,
      color: AppColors.navyDeep,
      fontWeight: FontWeight.w700,
      height: 1.0,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('c', style: textStyle),
        const SizedBox(width: 1),
        SizedBox(
          width: fontSize * 0.92,
          height: fontSize * 0.92,
          child: CustomPaint(painter: _WordmarkLogoPainter()),
        ),
        const SizedBox(width: 1),
        Text('shku', style: textStyle),
      ],
    );
  }
}

class _WordmarkLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final teal = Paint()
      ..color = AppColors.teal
      ..style = PaintingStyle.fill;

    final circleCenter = Offset(cx, cy - size.height * 0.04);
    final circleR = r * 0.88;
    canvas.drawCircle(circleCenter, circleR, teal);

    canvas.drawPath(
      Path()
        ..moveTo(cx + circleR * 0.25, circleCenter.dy + circleR * 0.72)
        ..lineTo(cx + circleR * 0.78, circleCenter.dy + circleR * 1.10)
        ..lineTo(cx - circleR * 0.05, circleCenter.dy + circleR * 0.90)
        ..close(),
      teal,
    );

    final navy = Paint()
      ..color = AppColors.navyDeep
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(cx - r * 0.06, circleCenter.dy - r * 0.04);
    canvas.rotate(-math.pi / 6);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: r * 0.44, height: r * 0.68),
      navy,
    );
    canvas.restore();

    canvas.save();
    canvas.translate(cx + r * 0.06, circleCenter.dy - r * 0.04);
    canvas.rotate(math.pi / 6);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: r * 0.44, height: r * 0.68),
      navy,
    );
    canvas.restore();

    canvas.drawLine(
      Offset(cx, circleCenter.dy - r * 0.38),
      Offset(cx, circleCenter.dy + r * 0.34),
      Paint()
        ..color = AppColors.teal
        ..strokeWidth = r * 0.06
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
