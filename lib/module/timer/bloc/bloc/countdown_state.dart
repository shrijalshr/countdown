part of 'countdown_bloc.dart';

abstract class CountdownState extends Equatable {
  const CountdownState(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];
}

class CountdownInitial extends CountdownState {
  const CountdownInitial(super.duration);
}

class CountdownRunning extends CountdownState {
  const CountdownRunning(super.duration);
}

class CountdownPaused extends CountdownState {
  const CountdownPaused(super.duration);
}

class CountdownFailed extends CountdownState {
  const CountdownFailed(super.duration);
}

class CountdownCompleted extends CountdownState {
  const CountdownCompleted() : super(0);
}
