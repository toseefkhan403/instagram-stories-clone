import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerState {
  final double progress;

  TimerState(this.progress);
}

class TimerController extends StateNotifier<TimerState> {
  Timer? _timer;
  final void Function() onTimerComplete;
  int durationInSeconds = 5;

  TimerController({required this.onTimerComplete}) : super(TimerState(0.0));

  void startTimer() {
    state = TimerState(0.0);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final newProgress = state.progress + 50 / (durationInSeconds * 1000);
      if (newProgress >= 1.0) {
        _timer?.cancel();
        state = TimerState(1.0);
        onTimerComplete();
      } else {
        state = TimerState(newProgress);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider =
    StateNotifierProvider.family.autoDispose<TimerController, TimerState, void Function()>(
  (ref, onTimerComplete) => TimerController(onTimerComplete: onTimerComplete),
);
