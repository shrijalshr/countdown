part of 'countdown_bloc.dart';

abstract class CountdownEvent extends Equatable {
  const CountdownEvent();

  @override
  List<Object> get props => [];
}

class StartCountdown extends CountdownEvent {
  const StartCountdown({required this.duration});

  final int duration;
}

class PauseCountdown extends CountdownEvent {
  const PauseCountdown();
}

class ResumeCountdown extends CountdownEvent {
  const ResumeCountdown();
}

class StopCountdown extends CountdownEvent {
  const StopCountdown();
}
