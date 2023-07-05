import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:countdown/common/helper/app_logger.dart';
import 'package:equatable/equatable.dart';

import '../../service/counter_service.dart';

part 'countdown_event.dart';
part 'countdown_state.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState> {
  final CounterService _counter;

  final StreamController<int> _counterController = StreamController<int>();
  Stream<int> get counterStream => _counterController.stream;
  bool isPaused = false;

  StreamSubscription<int>? _counterSubs;

  CountdownBloc({required CounterService counter})
      : _counter = counter,
        super(const CountdownInitial(0)) {
    on<StartCountdown>(startCountdown);

    on<StopCountdown>((event, emit) {
      AppLogger.logInfo("StoppingCountdown .");
      // _counterController.close();
      _counterSubs?.cancel();

      emit(const CountdownInitial(0));
    });

    on<PauseCountdown>((event, emit) {
      if (state is! CountdownRunning) {
        return;
      }
      AppLogger.logInfo("Pausing Countdown at ${state.duration}.");
      // _counterController.addError("Stream paused");
      _counterSubs?.pause();
      // isPaused = true;
      // _counterController.addError("Stream paused");
      emit(CountdownPaused(state.duration));
    });

    on<ResumeCountdown>((event, emit) {
      if (state is! CountdownPaused) {
        return;
      }
      AppLogger.logInfo("Resuming Countdown at ${state.duration}.");
      // _counterController.();
      _counterSubs?.resume();
      // isPaused = false;
      emit(CountdownRunning(state.duration));
    });

    on<TickingCountdown>(_onCountdownTicked);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }

  startCountdown(StartCountdown event, Emitter<CountdownState> emit) {
    AppLogger.logInfo("Starting Countdown for ${event.duration}.");
    emit(CountdownRunning(event.duration));
    _counterSubs?.cancel();
    _counterSubs = _counter
        .counter(event.duration)
        .listen((t) => add(TickingCountdown(t)));

    // await for (final int durationInSec
    //     in _counter.counter(event.duration)) {
    //   if (!_counterController.isClosed) {
    //     if (isPaused) {
    //       if (durationInSec > 0) {
    //         emit(CountdownRunning(durationInSec));
    //         AppLogger.logInfo("Countdown  $durationInSec.");
    //       } else {
    //         emit(const CountdownCompleted());
    //         break; // Exit the loop when the countdown is completed
    //       }
    //     }
    //   }
    // }
  }

  void _onCountdownTicked(
      TickingCountdown event, Emitter<CountdownState> emit) {
    AppLogger.logInfo("Countdown : ${event.duration}");
    emit(
      event.duration > 0
          ? CountdownRunning(event.duration)
          : const CountdownCompleted(),
    );
  }
}
