import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_colors.dart';
import 'package:cashku/core/theme/app_metrics.dart';
import 'package:cashku/core/theme/app_shadows.dart';
import 'package:cashku/core/theme/app_typography.dart';

/// CashKu branded text field.
///
/// Wraps [TextFormField] so it is fully compatible with [Form] validation.
///
/// Spec:
///  - Height 56, radius 12.
///  - Shadow: Y=6 Blur=20 ([AppShadows.input]).
///  - Default border  → [AppColors.neutral300]
///  - Focused border  → [AppColors.royalBlue]
///  - Error border    → [AppColors.errorRed]
///  - Label displayed above the field (not floating inside).
///  - Prefix icon slot, suffix icon slot, obscure-text toggle.
///
/// ### Stable-height error pattern
/// The input container is ALWAYS exactly [AppMetrics.inputH] tall.
/// Flutter's built-in error text is suppressed (zero-size style + empty text)
/// and redrawn as a separate widget below the box — so the input box never
/// shrinks or shifts when a validation message appears.
class CashkuTextField extends StatefulWidget {
  const CashkuTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.initialValue,
    this.enabled = true,
    this.maxLines = 1,
    this.autofocus = false,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? prefixIcon;

  /// Custom suffix widget; overrides the eye-toggle when [obscureText] is true.
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? initialValue;
  final bool enabled;
  final int? maxLines;
  final bool autofocus;

  @override
  State<CashkuTextField> createState() => _CashkuTextFieldState();
}

class _CashkuTextFieldState extends State<CashkuTextField> {
  late bool _obscure;

  // Tracks the validation error so we can render it outside the fixed box.
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Label above field ──────────────────────────────────────────────────
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.neutral900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppMetrics.space8),
        ],

        // ── Fixed-height field box (NEVER changes height) ──────────────────────
        DecoratedBox(
          decoration: const BoxDecoration(boxShadow: AppShadows.input),
          child: SizedBox(
            height: widget.maxLines == 1 ? AppMetrics.inputH : null,
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              obscureText: _obscure,
              initialValue: widget.initialValue,
              enabled: widget.enabled,
              maxLines: _obscure ? 1 : widget.maxLines,
              autofocus: widget.autofocus,
              style: AppTypography.bodyLarge,
              // Intercept the validator: run it, store the message locally for
              // the custom error text below, then return null so that Flutter's
              // built-in error rendering never fires.
              validator:
                  widget.validator == null
                      ? null
                      : (value) {
                        final msg = widget.validator!(value);
                        // Use addPostFrameCallback so setState isn't called
                        // during the build phase triggered by Form.validate().
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted && _errorText != msg) {
                            setState(() => _errorText = msg);
                          }
                        });
                        // Return the real error so the Form knows validation failed,
                        // but suppress its visual rendering with zero-height style.
                        return msg;
                      },
              onChanged: (v) {
                // Clear error on edit; full re-validation happens on submit.
                if (_errorText != null) {
                  setState(() => _errorText = null);
                }
                widget.onChanged?.call(v);
              },
              onFieldSubmitted: widget.onFieldSubmitted,
              decoration: InputDecoration(
                hintText: widget.hint,
                filled: true,
                fillColor: AppColors.white,
                isDense: false,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppMetrics.space16,
                  vertical: AppMetrics.space16,
                ),
                // ── Borders ──────────────────────────────────────────────────
                border: _border(AppColors.neutral300),
                enabledBorder: _border(
                  _errorText != null
                      ? AppColors.errorRed
                      : AppColors.neutral300,
                ),
                focusedBorder: _border(
                  _errorText != null ? AppColors.errorRed : AppColors.royalBlue,
                  width: 1.5,
                ),
                errorBorder: _border(AppColors.errorRed),
                focusedErrorBorder: _border(AppColors.errorRed, width: 1.5),
                disabledBorder: _border(AppColors.neutral300),
                // ── Icons ────────────────────────────────────────────────────
                prefixIcon: widget.prefixIcon,
                prefixIconColor: AppColors.neutral500,
                suffixIcon: _buildSuffix(),
                suffixIconColor: AppColors.neutral500,
                // ── Suppress built-in error space ─────────────────────────────
                // errorText must NOT be set here; we render it ourselves below.
                errorText: null,
                errorStyle: const TextStyle(fontSize: 0, height: 0),
              ),
            ),
          ),
        ),

        // ── Custom error text (outside the fixed box — no layout shift) ────────
        AnimatedSize(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.topLeft,
          child:
              _errorText != null
                  ? Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                      left: AppMetrics.space4,
                    ),
                    child: Text(
                      _errorText!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.errorRed,
                      ),
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget? _buildSuffix() {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.neutral500,
          size: AppMetrics.space24,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
        splashRadius: AppMetrics.space24,
      );
    }
    return null;
  }

  OutlineInputBorder _border(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppMetrics.radiusInput),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
