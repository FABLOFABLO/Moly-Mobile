import 'package:go_router/go_router.dart';
import 'package:moly_mobile/features/auth/presentation/pages/sign_in_page.dart';
import 'package:moly_mobile/features/auth/presentation/pages/sign_up_page.dart';
import 'package:moly_mobile/features/expedition/presentation/pages/expedition_page.dart';
import 'package:moly_mobile/features/main/presentation/pages/main_shell_page.dart';
import 'package:moly_mobile/features/map/presentation/pages/map_page.dart';
import 'package:moly_mobile/features/mypage/presentation/pages/my_page.dart';
import 'package:moly_mobile/features/onboarding/presentation/pages/onboarding_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const OnboardingPage()),
    GoRoute(path: '/signIn', builder: (_, _) => const SignInPage()),
    GoRoute(path: '/signUp', builder: (_, _) => const SignUpPage()),
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) =>
          MainShellPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/expedition',
              builder: (_, _) => const ExpeditionPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: '/map', builder: (_, _) => const MapPage())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: '/my', builder: (_, _) => const MyPage())],
        ),
      ],
    ),
  ],
);
