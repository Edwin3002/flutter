import "package:form_app/screens/screens.dart";
import "package:go_router/go_router.dart";
// export '../screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
  GoRoute(path: "/cubits", builder: (context, state) => const CubitCounterScreen()),
  GoRoute(path: "/register", builder: (context, state) => const RegisterScreen()),
]);
