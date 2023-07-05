class CounterService {
  CounterService._internal();

  static final CounterService _instance = CounterService._internal();

  factory CounterService() {
    return _instance;
  }

  Stream<int> timer(int durationInSec) {
    return Stream.periodic(
            Duration(seconds: durationInSec), (t) => durationInSec - t - 1)
        .take(durationInSec);
  }
}
