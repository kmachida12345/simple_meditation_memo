import 'package:flutter/material.dart';
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

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (ref.watch(timerProvider).timerState) {
      case TimerState.idle:
        return const InitialButton();
      case TimerState.started:
        return Column(
          children: const [
            RemainingTimerText(),
            StartedButton()
          ],
        );
      case TimerState.canceled:
        return const Text('canceled');
      case TimerState.finished:
        ref.read(meditationRecordRepositoryProvider).add(
          ref.watch(recordProvider)
        );
        return const Finished();
      case TimerState.paused:
        return Column(
          children: const [
            RemainingTimerText(),
            PausedButton()
          ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            ref.read(timerProvider.notifier).start(4);

            ref.read(recordProvider).startedAt = DateTime.now();
            ref.read(recordProvider).duration = ref.read(timerProvider).timeRemaining;

          },
          icon: const Icon(Icons.start),
        ),
      ],
    );
  }
}

class Finished extends StatelessWidget {
  const Finished({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('finished!');
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
