import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterCubit(), child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {
    final counterMethods = context.watch<CounterCubit>();
    final counterState = context.read<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
          title:
              Text("Cubits transaction ${counterState.transactionCount}"),
          actions: [
            IconButton(
                onPressed: () => counterMethods.reset(),
                icon: const Icon(
                  Icons.refresh,
                ))
          ]),
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          return Center(child: Text("Counter: ${state.counter}"));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "3",
            onPressed: () {
              counterMethods.increaseBy(3);
            },
            child: const Text("+3"),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              counterMethods.increaseBy(2);
            },
            child: const Text("+2"),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "1",
            onPressed: () {
              counterMethods.increaseBy(1);
            },
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
