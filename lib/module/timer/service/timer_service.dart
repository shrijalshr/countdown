class TimerService {
  TimerService._internal();

  static final TimerService _instance = TimerService._internal();

  factory TimerService() {
    return _instance;
  }

  Stream<int> timer(Duration duration) {
    return Stream.periodic(duration, (t) => duration.inSeconds - t - 1)
        .take(duration.inSeconds);
  }
}
