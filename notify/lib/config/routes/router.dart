import 'package:go_router/go_router.dart';
import 'package:notify/presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: "/msg-details/:msgId",
      builder: (context, state) => DetailsScreen(
            pushMsgId: state.pathParameters["msgId"] ?? "",
          )),
]);
