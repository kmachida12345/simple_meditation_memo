import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meditation_memo/data/meditation_record.dart';
import 'package:simple_meditation_memo/repository/meditation_record_repository.dart';
import 'package:simple_meditation_memo/service/timer_service.dart';
import 'package:simple_meditation_memo/ui_state/timer_state.dart';

class CountdownTimer extends ConsumerWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: TimerScreen(),
      ),
    );
  }
}

final recordProvider = Provider((ref) => MeditationRecord());
final durationProvider = StateProvider((ref) => const Duration());

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(timerProvider).timerState) {
      case TimerState.idle:
        return const InitialButton();
      case TimerState.started:
        return Column(
          children: const [RemainingTimerText(), StartedButton()],
        );
      case TimerState.finished:
        FlutterRingtonePlayer.playAlarm(asAlarm: true, volume: 0.2);
        ref
            .read(meditationRecordRepositoryProvider)
            .add(ref.read(recordProvider));
        return const Finished();
      case TimerState.paused:
        return Column(
          children: const [RemainingTimerText(), PausedButton()],
        );
    }
  }
}

class StartedButton extends ConsumerWidget {
  const StartedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            ref.read(timerProvider.notifier).cancel();
          },
          icon: const Icon(Icons.stop),
        ),
        IconButton(
          onPressed: () {
            ref.read(timerProvider.notifier).pause();
          },
          icon: const Icon(Icons.pause),
        ),
      ],
    );
  }
}

class InitialButton extends ConsumerWidget {
  const InitialButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          DurationPicker(
            duration: ref.watch(durationProvider),
            onChange: (value) =>
                ref.read(durationProvider.notifier).state = value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  ref
                      .read(timerProvider.notifier)
                      .start(ref.read(durationProvider));

                  ref.read(recordProvider).startedAt = DateTime.now();
                  ref.read(recordProvider).duration =
                      ref.read(timerProvider).timeRemaining;
                },
                icon: const Icon(Icons.start),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Finished extends ConsumerWidget {
  const Finished({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          FlutterRingtonePlayer.stop();
          ref.read(timerProvider.notifier).cancel();
        },
        child: const Text('Finish!'));
  }
}

class RemainingTimerText extends ConsumerWidget {
  const RemainingTimerText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(ref.watch(timerProvider).timeRemaining.toString());
  }
}

class PausedButton extends ConsumerWidget {
  const PausedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            ref.read(timerProvider.notifier).cancel();
          },
          icon: const Icon(Icons.stop),
        ),
        IconButton(
          onPressed: () {
            ref.read(timerProvider.notifier).resume();
          },
          icon: const Icon(Icons.restart_alt),
        ),
      ],
    );
  }
}
