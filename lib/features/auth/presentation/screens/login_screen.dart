import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_typography.dart';
import 'package:cashku/shared/widgets/buttons/primary_button.dart';
import 'package:cashku/shared/widgets/cashku_wordmark.dart';
import 'package:cashku/shared/widgets/inputs/cashku_text_field.dart';

/// Screen 08 — Login
///
/// - SingleChildScrollView + MediaQuery.viewInsets keyboard safety.
/// - Form with basic email + password validators.
/// - CashkuTextField for both fields (mail / lock icons).
/// - "Forgot Password?" right-aligned text, navyDeep.
/// - PrimaryButton "Log In".
/// - "or log in with" divider.
/// - Google + Apple side-by-side outlined buttons.
/// - "Don't have an account? Sign Up" → /auth/signup.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: integrate auth logic; navigate on success.
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
                const SizedBox(height: AppMetrics.space48),

                // ── Word-mark ──────────────────────────────────────────────
                const Center(child: CashkuWordmark()),

                const SizedBox(height: AppMetrics.space24),

                // ── Title + subtitle ───────────────────────────────────────
                Text(
                  'Log In to Your Account',
                  textAlign: TextAlign.center,
                  style: AppTypography.h2.copyWith(color: AppColors.navyDeep),
                ),
                const SizedBox(height: AppMetrics.space8),
                Text(
                  'Enter your details to access your wealth management plan.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge,
                ),

                const SizedBox(height: AppMetrics.space32),

                // ── Email field ────────────────────────────────────────────
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

                // ── Password field ─────────────────────────────────────────
                CashkuTextField(
                  label: 'Password',
                  hint: '••••••••••••••••••••',
                  controller: _passCtrl,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  onFieldSubmitted: (_) => _submit(),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppMetrics.space8),

                // ── Forgot Password ────────────────────────────────────────
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      /* TODO: forgot password flow */
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.navyDeep,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.navyDeep,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppMetrics.space24),

                // ── Log In button ──────────────────────────────────────────
                PrimaryButton(
                  label: 'Log In',
                  onPressed: _submit,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: AppMetrics.space24),

                // ── "or log in with" divider ───────────────────────────────
                _OrDivider(),

                const SizedBox(height: AppMetrics.space16),

                // ── Social buttons ─────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _SocialButton(
                        label: 'Google',
                        assetPath: AppSocialIcons.google,
                        onPressed: () {
                          /* TODO: Google Sign-In */
                        },
                      ),
                    ),
                    const SizedBox(width: AppMetrics.space16),
                    Expanded(
                      child: _SocialButton(
                        label: 'Apple',
                        assetPath: AppSocialIcons.apple,
                        onPressed: () {
                          /* TODO: Apple Sign-In */
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppMetrics.space32),

                // ── Sign Up link ───────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTypography.bodyLarge,
                    ),
                    GestureDetector(
                      onTap: () => context.goNamed('auth-signup'),
                      child: Text(
                        'Sign Up',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.navyDeep,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Private components
// ────────────────────────────────────────────────────────────────────────────

/// "────  or log in with  ────" divider row.
class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.neutral900, thickness: 0.5),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppMetrics.space16),
          child: Text(
            'or log in with',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.neutral900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.neutral900, thickness: 0.5),
        ),
      ],
    );
  }
}

/// Outlined social button — h 56, r 14, border neutral300.
/// Renders an [Image.asset] icon (24×24) from [assetPath] left of the label.
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.assetPath,
    required this.onPressed,
  });

  final String label;
  final String assetPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMetrics.buttonH,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.neutral300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusBtn),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppMetrics.space16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: AppMetrics.space24,
              height: AppMetrics.space24,
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(width: AppMetrics.space8),
            Text(
              label,
              style: AppTypography.button.copyWith(color: AppColors.neutral900),
            ),
          ],
        ),
      ),
    );
  }
}
