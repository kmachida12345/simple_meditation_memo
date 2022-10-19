import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meditation_memo/data/timer.dart' as timer_model;
import 'package:simple_meditation_memo/ui_state/timer_state.dart';

class RemainingTimeStateNotifier extends StateNotifier<timer_model.Timer> {
  RemainingTimeStateNotifier()
      : super(
          const timer_model.Timer(
            timeRemaining: 0,
            timerState: TimerState.idle,
          ),
        );

  Stream<int> _generateTimer({required int timeInSec}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) => timeInSec - computationCount - 1,
    ).take(timeInSec);
  }

  late StreamSubscription<int> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  void start(Duration duration) {
    var timeInSecond = duration.inSeconds;
    _sub = _generateTimer(timeInSec: timeInSecond).listen((duration) {
      state = timer_model.Timer(
          timeRemaining: duration, timerState: TimerState.started);
    });

    _sub.onDone(() {
      state = timer_model.Timer(
          timeRemaining: state.timeRemaining, timerState: TimerState.finished);
    });

    state = timer_model.Timer(
        timeRemaining: timeInSecond, timerState: TimerState.started);
  }

  void pause() {
    _sub.pause();
    state = timer_model.Timer(
        timeRemaining: state.timeRemaining, timerState: TimerState.paused);
  }

  void resume() {
    _sub.resume();
    state = timer_model.Timer(
        timeRemaining: state.timeRemaining, timerState: TimerState.started);
  }

  void cancel() {
    _sub.cancel();
    state = const timer_model.Timer(
        timeRemaining: 0, timerState: TimerState.idle);
  }
}

final timerProvider =
    StateNotifierProvider<RemainingTimeStateNotifier, timer_model.Timer>((ref) {
  return RemainingTimeStateNotifier();
});
