import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/menu/menu_items.dart';

class DrawerMain extends StatefulWidget {

 final GlobalKey<ScaffoldState> homeKey;

  const DrawerMain({super.key, required this.homeKey});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  int navDrawerSelect = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
        selectedIndex: navDrawerSelect,
        onDestinationSelected: (value) {
          navDrawerSelect = value;
          context.push(appMenuItems[value].link);
          widget.homeKey.currentState?.closeDrawer();
          setState(() {});
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 10),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Widgets App", style: TextStyle(fontSize: 30)),
                ]),
          ),
          ...appMenuItems
              .sublist(0, 4)
              .map((itemDrawer) => NavigationDrawerDestination(
                    icon: Icon(itemDrawer.icon),
                    label: Text(itemDrawer.title),
                  )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Divider(),
              Text("- Más opciones",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ]),
          ),
          for (MenuItem item in appMenuItems.sublist(4, 9))
            NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            )
        ]);
  }
}
