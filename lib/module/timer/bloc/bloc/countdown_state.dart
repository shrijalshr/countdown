part of 'countdown_bloc.dart';

abstract class CountdownState extends Equatable {
  const CountdownState(this.duration);

  final int duration;

  @override
  List<Object> get props => [];
}

class CountdownInitial extends CountdownState {
  CountdownInitial(super.duration);
}

class CountdownStarted extends CountdownState {
  CountdownStarted(super.duration);
}

class CountdownPaused extends CountdownState {
  CountdownPaused(super.duration);
}

class CountdownFailed extends CountdownState {
  CountdownFailed(super.duration);
}

class CountdownCompleted extends CountdownState {
  CountdownCompleted(super.duration);
}
