import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/menu/menu_items.dart';
import 'package:widgets_app/providers/counter_provider.dart';
import 'package:widgets_app/providers/theme_provider.dart';
import 'package:widgets_app/widgets/drawer_main.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// In Dart, the `static` keyword is used to define a member (variable or method) that belongs to the
  /// class itself, rather than to an instance of the class.
  static const String name = "home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool darkMode = ref.watch(isDarkModeProvider);
    final homeKey = GlobalKey<ScaffoldState>();

    void changeTheme() {
      ref.read(themeNotifierProvider.notifier).toggleDarkMode();
      ref.read(isDarkModeProvider.notifier).update((state) => !state);
    }

    return Scaffold(
      key: homeKey,
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Home"),
            IconButton(
                onPressed: changeTheme,
                icon: Icon(darkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Colors.yellow))
          ],
        ),
      ),
      drawer: Drawer(
        child: DrawerMain(homeKey: homeKey),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];

        return _CustomListTile(menuItem: menuItem, index: index);
      },
    );
  }
}

class _CustomListTile extends ConsumerWidget {
  const _CustomListTile({required this.menuItem, required this.index});

  final MenuItem menuItem;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counterInt = ref.watch(counterProvider);
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text("${menuItem.title} ${index == 8 ? "= $counterInt" : ""}"),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const ButtonsScreen(),
        //   ),
        // );
        // Navigator.pushNamed(context, menuItem.link );

        // context.pushNamed( CardsScreen.name );
        context.push(menuItem.link);
      },
    );
  }
}
