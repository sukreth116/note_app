import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Testing Bloc')),
        body: BlocConsumer<CounterBloc, CounterState>(
          listener: (context, state) {
            // _textController.clear();   // coment this if don't to clear text
          },
          builder: (context, state) {
            final invalidValue = (state is CounterStateInvalidValue)
                ? state.invalidvalue
                : '';
            return Column(
              children: [
                Text('Current value => ${state.value}'),
                Visibility(
                  visible: state is CounterStateInvalidValue,
                  child: Text('Invalid input $invalidValue'),
                ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Enter a number '),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      child: Text('Increment +'),
                      onPressed: () {
                        context.read<CounterBloc>().add(
                          IncrementEvent(_textController.text),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('Decrement -'),
                      onPressed: () {
                        context.read<CounterBloc>().add(
                          DecrementEvent(_textController.text),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(super.value);
  // doubt why super. this can also written in CounterStateValid(int value) : super(value) in old method
}

class CounterStateInvalidValue extends CounterState {
  final String invalidvalue;
  const CounterStateInvalidValue({
    required this.invalidvalue,
    required int previousValue,
  }) : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent(super.value);
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent(super.value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(0)) {
    on<IncrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          CounterStateInvalidValue(
            invalidvalue: event.value,
            previousValue: state.value,
          ),
        );
      } else {
        emit(CounterStateValid(state.value + integer));
      }
    });
    on<DecrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          CounterStateInvalidValue(
            invalidvalue: event.value,
            previousValue: state.value,
          ),
        );
      } else {
        emit(CounterStateValid(state.value - integer));
      }
    });
  }
}
