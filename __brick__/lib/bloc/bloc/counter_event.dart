part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class CounterAdd extends CounterEvent {
  CounterAdd();
}

class CounterMinus extends CounterEvent {
  CounterMinus();
}
