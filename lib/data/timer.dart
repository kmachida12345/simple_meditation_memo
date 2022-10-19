import 'package:simple_meditation_memo/ui_state/timer_state.dart';

class Timer {
  final int timeRemaining;
  final TimerState timerState;

//<editor-fold desc="Data Methods">

  const Timer({
    required this.timeRemaining,
    required this.timerState,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Timer &&
          runtimeType == other.runtimeType &&
          timeRemaining == other.timeRemaining &&
          timerState == other.timerState);

  @override
  int get hashCode => timeRemaining.hashCode ^ timerState.hashCode;

  @override
  String toString() {
    return 'Timer{' +
        ' timeRemaining: $timeRemaining,' +
        ' timerState: $timerState,' +
        '}';
  }

  Timer copyWith({
    int? timeRemaining,
    TimerState? timerState,
  }) {
    return Timer(
      timeRemaining: timeRemaining ?? this.timeRemaining,
      timerState: timerState ?? this.timerState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeRemaining': this.timeRemaining,
      'timerState': this.timerState,
    };
  }

  factory Timer.fromMap(Map<String, dynamic> map) {
    return Timer(
      timeRemaining: map['timeRemaining'] as int,
      timerState: map['timerState'] as TimerState,
    );
  }

//</editor-fold>
}