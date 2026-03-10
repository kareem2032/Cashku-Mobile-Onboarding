import 'package:go_router/go_router.dart';
import '../features/onboarding/presentation/screens/splash_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/profiling/presentation/screens/profile_intro_screen.dart';
import '../features/profiling/presentation/screens/profile_experience_screen.dart';
import '../features/profiling/presentation/screens/profile_goals_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/showcase/presentation/showcase_screen.dart';

/// Set to true at runtime via:
///   flutter run  --dart-define=SHOWCASE=true
///   flutter build web --dart-define=SHOWCASE=true
const bool kShowcase =
    bool.fromEnvironment('SHOWCASE', defaultValue: false);

final appRouter = GoRouter(
  // Jump straight to the gallery in dev; normal flow otherwise.
  initialLocation: kShowcase ? '/showcase' : '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/profile/intro',
      name: 'profile-intro',
      builder: (context, state) => const ProfileIntroScreen(),
    ),
    GoRoute(
      path: '/profile/experience',
      name: 'profile-experience',
      builder: (context, state) => const ProfileExperienceScreen(),
    ),
    GoRoute(
      path: '/profile/goals',
      name: 'profile-goals',
      builder: (context, state) => const ProfileGoalsScreen(),
    ),
    GoRoute(
      path: '/auth/login',
      name: 'auth-login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/signup',
      name: 'auth-signup',
      builder: (context, state) => const SignupScreen(),
    ),

    // ── DEV-ONLY ──────────────────────────────────────────────────────────
    GoRoute(
      path: '/showcase',
      name: 'showcase',
      builder: (context, state) => const ShowcaseScreen(),
    ),
  ],
);
