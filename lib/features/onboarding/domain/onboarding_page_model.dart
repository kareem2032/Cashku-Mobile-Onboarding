/// Immutable data model for a single onboarding page.
///
/// Consumed by [OnboardingController] and rendered by the onboarding screen.
/// [imageAsset] must be an [AppImages] constant — never a raw string.
class OnboardingPageModel {
  const OnboardingPageModel({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });

  /// Position in the onboarding sequence (0-based).
  final int index;

  /// Short headline shown on this page.
  final String title;

  /// Supporting description text.
  final String subtitle;

  /// Asset path — use an [AppImages] constant.
  final String imageAsset;

  @override
  String toString() =>
      'OnboardingPageModel(index: $index, title: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingPageModel &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}
