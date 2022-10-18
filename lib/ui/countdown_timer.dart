import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meditation_memo/service/timer_service.dart';
import 'package:simple_meditation_memo/ui_state/timer_state.dart';

class CountdownTimer extends ConsumerWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: (() {
          switch(ref.watch(timerStateProvider)) {
            case TimerState.initialized:
              return const Text('init');
            case TimerState.started:
              return ref.watch(timerProvider(const Duration(seconds: 5))).when(
                data: (data) => Text(Duration(seconds: data).toString()),
                error: (error, stackTrace) => const Text('err'),
                loading: () => const CircularProgressIndicator(),
              );
            case TimerState.canceled:
              return const Text('canceled');
            case TimerState.finished:
              return const Text('finished!');
          }
        })(),
      ),
    );
  }
}
