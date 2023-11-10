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
    // GoRoute(
    //   path: '/*',
    //   builder: (context, GoRouterState state) => const ErrorScreen(),
    // ),
  ],
);
