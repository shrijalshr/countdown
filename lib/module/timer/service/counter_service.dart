import 'dart:async';

class CounterService {
  CounterService();



  Stream<int> counter(int durationInSec) {
    return Stream.periodic(
            const Duration(seconds: 1), (t) => durationInSec - t - 1)
        .take(durationInSec);
  }
}
