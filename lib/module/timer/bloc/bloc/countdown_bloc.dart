import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../service/timer_service.dart';

part 'countdown_event.dart';
part 'countdown_state.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
  static const Duration _defaultDuration = Duration(minutes: 20);
  final CounterService _counter;

  StreamSubscription<int>? _counterSubs;

  CountdownBloc({required CounterService counter})
      : _counter = counter,
        super(CountdownInitial(_defaultDuration.inSeconds)) {
    on<StartCountdown>((event, emit) {
      emit(CountdownRunning(event.duration));
      _counterSubs = _counter.timer(event.duration).listen((durationInSec) {
        durationInSec > 0
            ? CountdownRunning(durationInSec)
            : const CountdownCompleted();
      });
    });

    on<StopCountdown>((event, emit) {
      _counterSubs?.cancel();
      emit(const CountdownInitial(0));
    });

    on<PauseCountdown>((event, emit) {
      if (state is! CountdownRunning) {
        return;
      }

      _counterSubs?.pause();
      emit(CountdownPaused(state.duration));
    });

    on<ResumeCountdown>((event, emit) {
      if (state is! CountdownPaused) {
        return;
      }
      _counterSubs?.resume();
      emit(CountdownRunning(state.duration));
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _counterSubs?.cancel();
    return super.close();
  }
}
