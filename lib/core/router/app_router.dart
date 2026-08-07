import 'package:go_router/go_router.dart';
import 'package:moly_mobile/features/auth/presentation/pages/sign_in_page.dart';
import 'package:moly_mobile/features/auth/presentation/pages/sign_up_page.dart';
import 'package:moly_mobile/features/onboarding/presentation/pages/onboarding_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const OnboardingPage()),
    GoRoute(path: '/signIn', builder: (_, _) => const SignInPage()),
    GoRoute(path: '/signUp', builder: (_, _) => const SignUpPage()),
  ],
);
