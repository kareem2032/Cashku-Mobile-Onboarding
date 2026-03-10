import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';

/// Screen 00 — Splash
///
/// - Background: [AppColors.navyDeep]
/// - Centered [AppBranding.logoMark] PNG (80 × 80, FilterQuality.high)
/// - Fade-in animation: 600 ms
/// - Auto-navigates to /onboarding after 1 200 ms
/// - DEV: long-press anywhere → /showcase
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
    Timer(const Duration(milliseconds: 1200), _navigate);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _navigate() {
    if (mounted) context.goNamed('onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyDeep,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          // DEV: long-press to open screen gallery.
          onLongPress: () {
            if (mounted) context.goNamed('showcase');
          },
          child: Center(
            child: FadeTransition(
              opacity: _fade,
              child: SizedBox(
                width: AppMetrics.space80,
                height: AppMetrics.space80,
                child: Image.asset(
                  AppBranding.logoMark,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
