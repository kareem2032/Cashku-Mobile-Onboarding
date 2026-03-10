/// Onboarding feature — public exports.
///
/// Screens should import this barrel rather than deep-linking to
/// individual files.
library;

export 'domain/onboarding_page_model.dart';
export 'presentation/controller/onboarding_controller.dart'
    show
        OnboardingState,
        OnboardingController,
        onboardingControllerProvider,
        kOnboardingPages;
