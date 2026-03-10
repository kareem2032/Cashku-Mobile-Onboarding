import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';
import 'package:cashku/shared/widgets/buttons/primary_button.dart';
import 'package:cashku/shared/widgets/cashku_wordmark.dart';
import 'package:cashku/shared/widgets/inputs/cashku_text_field.dart';
import 'package:cashku/shared/widgets/nav/back_circle_button.dart';

/// Screen 09 — Sign Up
///
/// - BackCircleButton → /auth/login
/// - CashkuWordmark
/// - "Create Your Account" H2 navyDeep
/// - 4 CashkuTextField: Full Name, Email, Password (eye), Confirm Password (eye)
/// - PrimaryButton "Sign UP"
/// - "Already have an account? Sign In" → /auth/login
/// - Keyboard-safe SingleChildScrollView + viewInsets bottom padding.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: integrate sign-up logic; navigate on success.
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AppMetrics.space24,
            right: AppMetrics.space24,
            bottom: bottomInset + AppMetrics.space24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Top bar ──────────────────────────────────────────────────
                const SizedBox(height: AppMetrics.space24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackCircleButton(
                    onPressed: () => context.goNamed('auth-login'),
                  ),
                ),

                const SizedBox(height: AppMetrics.space24),

                // ── Word-mark ────────────────────────────────────────────────
                const Center(child: CashkuWordmark()),

                const SizedBox(height: AppMetrics.space24),

                // ── Title + subtitle ─────────────────────────────────────────
                Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: AppTypography.h2.copyWith(color: AppColors.navyDeep),
                ),
                const SizedBox(height: AppMetrics.space8),
                Text(
                  'Start your journey to building a stronger financial future.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge,
                ),

                const SizedBox(height: AppMetrics.space32),

                // ── Full Name ────────────────────────────────────────────────
                CashkuTextField(
                  label: 'Full Name',
                  hint: 'Enter full name',
                  controller: _nameCtrl,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Full name is required';
                    }
                    if (v.trim().length < 2) {
                      return 'Enter your full name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppMetrics.space16),

                // ── Email ────────────────────────────────────────────────────
                CashkuTextField(
                  label: 'Email Address',
                  hint: 'Enter email address',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!v.contains('@') || !v.contains('.')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppMetrics.space16),

                // ── Password ─────────────────────────────────────────────────
                CashkuTextField(
                  label: 'Password',
                  hint: 'Create a password',
                  controller: _passCtrl,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppMetrics.space16),

                // ── Confirm Password ─────────────────────────────────────────
                CashkuTextField(
                  label: 'Confirm Password',
                  hint: 'Repeat password',
                  controller: _confirmCtrl,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  onFieldSubmitted: (_) => _submit(),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (v != _passCtrl.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppMetrics.space32),

                // ── Sign Up button ───────────────────────────────────────────
                PrimaryButton(
                  label: 'Sign UP',
                  onPressed: _submit,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: AppMetrics.space24),

                // ── Sign In link ─────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTypography.bodyLarge,
                    ),
                    GestureDetector(
                      onTap: () => context.goNamed('auth-login'),
                      child: Text(
                        'Sign In',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.navyDeep,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppMetrics.space16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
