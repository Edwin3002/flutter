import 'package:go_router/go_router.dart';
import 'package:notify/presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
  // GoRoute(path: "/cubits", builder: (context, state) => const CubitCounterScreen()),
  // GoRoute(path: "/register", builder: (context, state) => const RegisterScreen()),
]);
