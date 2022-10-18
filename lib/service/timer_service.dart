import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meditation_memo/ui_state/timer_state.dart';

final timerProvider = StreamProvider.autoDispose.family<int, Duration>(
  (ref, arg) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) {
        if (arg.inSeconds - computationCount == 0) {
          ref.watch(timerStateProvider.notifier).state = TimerState.finished;
        }
        return arg.inSeconds - computationCount;
      },
    ).take(arg.inSeconds + 1);
  },
);

final timerStateProvider = StateProvider<TimerState>((ref) {
  return TimerState.initialized;
});
