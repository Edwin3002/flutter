import 'package:go_router/go_router.dart';
import 'package:widgets_app/screens/screens.dart';

final GoRouter appRoutes = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/cards',
      name: CardScreen.name,
      builder: (context, GoRouterState state) => const CardScreen(),
    ),
    GoRoute(
      path: '/btns',
      name: ButtonsScreen.name,
      builder: (context, GoRouterState state) => const ButtonsScreen(),
    ),
    GoRoute(
      path: '/progress',
      name: ProgressScreen.name,
      builder: (context, state) => const ProgressScreen(),
    ),
    GoRoute(
      path: '/snackbars',
      name: SnackbarScreen.name,
      builder: (context, state) => const SnackbarScreen(),
    ),
    GoRoute(
      path: '/animated',
      name: AnimatedScreen.name,
      builder: (context, state) => const AnimatedScreen(),
    ),
    GoRoute(
      path: '/ui-controls',
      name: UiControlsScreen.name,
      builder: (context, state) => const UiControlsScreen(),
    ),
    GoRoute(
      path: '/tutorial',
      name: AppTutorialScreen.name,
      builder: (context, state) => const AppTutorialScreen(),
    ),
    GoRoute(
      path: '/infinite',
      name: InfiniteScrollScreen.name,
      builder: (context, state) => const InfiniteScrollScreen(),
    ),
  ],
);
