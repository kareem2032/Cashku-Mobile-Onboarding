import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cashku/core/constants/app_assets.dart';
import 'package:cashku/core/constants/app_copy.dart';
import '../../domain/onboarding_page_model.dart';

// ────────────────────────────────────────────────────────────────────────────
// State
// ────────────────────────────────────────────────────────────────────────────

/// Immutable state for the onboarding flow.
class OnboardingState {
  const OnboardingState({this.pageIndex = 0});

  /// Zero-based index of the currently visible page (0..3).
  final int pageIndex;

  OnboardingState copyWith({int? pageIndex}) =>
      OnboardingState(pageIndex: pageIndex ?? this.pageIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingState && pageIndex == other.pageIndex;

  @override
  int get hashCode => pageIndex.hashCode;
}

// ────────────────────────────────────────────────────────────────────────────
// Page catalogue
// ────────────────────────────────────────────────────────────────────────────

/// The four fixed onboarding pages, in display order.
///
/// Exposed as a top-level constant so screens can reference it without
/// depending on the controller implementation.
const List<OnboardingPageModel> kOnboardingPages = [
  OnboardingPageModel(
    index: 0,
    title: AppCopy.onboarding1Title,
    subtitle: AppCopy.onboarding1Caption,
    imageAsset: AppImages.onboardingCity,
  ),
  OnboardingPageModel(
    index: 1,
    title: AppCopy.onboarding2Title,
    subtitle: AppCopy.onboarding2Caption,
    imageAsset: AppImages.onboardingGrowth,
  ),
  OnboardingPageModel(
    index: 2,
    title: AppCopy.onboarding3Title,
    subtitle: AppCopy.onboarding3Caption,
    imageAsset: AppImages.onboardingAi,
  ),
  OnboardingPageModel(
    index: 3,
    title: AppCopy.onboarding4Title,
    subtitle: AppCopy.onboarding4Caption,
    imageAsset: AppImages.onboardingRocket,
  ),
];

// ────────────────────────────────────────────────────────────────────────────
// Notifier
// ────────────────────────────────────────────────────────────────────────────

class OnboardingController extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => const OnboardingState();

  // ── Mutations ─────────────────────────────────────────────────────────────

  /// Jump directly to page [index].
  void setIndex(int index) {
    assert(index >= 0 && index < kOnboardingPages.length,
        'index must be 0..${kOnboardingPages.length - 1}');
    state = state.copyWith(pageIndex: index);
  }

  /// Advance to the next page if not already on the last one.
  ///
  /// [total] is the number of pages (defaults to [kOnboardingPages.length]).
  void next({int? total}) {
    final limit = (total ?? kOnboardingPages.length) - 1;
    if (state.pageIndex < limit) {
      state = state.copyWith(pageIndex: state.pageIndex + 1);
    }
  }

  /// Go back to the previous page if not already on the first one.
  void previous() {
    if (state.pageIndex > 0) {
      state = state.copyWith(pageIndex: state.pageIndex - 1);
    }
  }

  // ── Computed ──────────────────────────────────────────────────────────────

  /// True when the user is on the very last onboarding page.
  bool get isLastPage => state.pageIndex == kOnboardingPages.length - 1;

  /// Convenience accessor for the currently visible page model.
  OnboardingPageModel get currentPage => kOnboardingPages[state.pageIndex];
}

// ────────────────────────────────────────────────────────────────────────────
// Provider
// ────────────────────────────────────────────────────────────────────────────

/// Provides [OnboardingController] and exposes [OnboardingState].
///
/// Usage in screens:
/// ```dart
/// final state = ref.watch(onboardingControllerProvider);
/// final ctrl  = ref.read(onboardingControllerProvider.notifier);
/// ctrl.next();
/// ```
final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingState>(
  OnboardingController.new,
);
