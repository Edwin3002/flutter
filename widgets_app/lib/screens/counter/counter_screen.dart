import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/providers/counter_provider.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  static const String name = "counter";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Screen"),
      ),
      body: CounterRiverpod(),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({
    super.key,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counterInt = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: minus,
                icon: const Icon(Icons.indeterminate_check_box)),
            IconButton(onPressed: reset, icon: const Icon(Icons.refresh)),
            IconButton(onPressed: plus, icon: const Icon(Icons.add_box)),
          ],
        ),
        Text(counterInt.toString())
      ],
    );
  }

  void plus() => setState(() {
        counterInt++;
      });

  void minus() => setState(() {
        counterInt--;
      });

  void reset() => setState(() {
        counterInt = 0;
      });
}

class CounterRiverpod extends ConsumerWidget {
  const CounterRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counterInt = ref.watch(counterProvider);
    void plus() => ref.read(counterProvider.notifier).state++;
    // void minus() => ref.read(counterProvider.notifier).state--;
    void minus() => ref.read(counterProvider.notifier).update((state) => state-1);
    void reset() => ref.read(counterProvider.notifier).state = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: minus,
                icon: const Icon(Icons.indeterminate_check_box)),
            IconButton(onPressed: reset, icon: const Icon(Icons.refresh)),
            IconButton(onPressed: plus, icon: const Icon(Icons.add_box)),
          ],
        ),
        Text(counterInt.toString())
      ],
    );
  }
}
