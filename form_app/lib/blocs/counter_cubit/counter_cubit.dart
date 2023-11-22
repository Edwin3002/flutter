import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubitCubit extends Cubit<CounterCubitState> {
  CounterCubitCubit() : super(CounterCubitInitial());
}
