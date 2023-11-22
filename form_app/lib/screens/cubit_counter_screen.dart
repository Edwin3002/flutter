import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(" Cubits"), actions: const [Icon(Icons.refresh)]),
      body: const Center(child: Text("Cubits")),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {},
            child: const Text("+3"),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {},
            child: const Text("+2"),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {},
            child: const Text("+1"),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
