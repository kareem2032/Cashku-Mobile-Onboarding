import 'package:flutter/material.dart';
import 'onboarding_shell.dart';

/// Route entry point for /onboarding.
/// Delegates entirely to [OnboardingShell].
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => const OnboardingShell();
}
