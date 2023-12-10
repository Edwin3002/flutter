import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ListTile(
          title: const Text("Cubits"),
          subtitle: const Text("Gestor de estado simple"),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => context.push("/cubits"),
        ),
        ListTile(
          title: const Text("Register"),
          subtitle: const Text("Formularios"),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => context.push("/register"),
        ),
      ]),
    );
  }
}
