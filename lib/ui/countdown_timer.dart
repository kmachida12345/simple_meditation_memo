import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meditation_memo/service/timer_service.dart';

class CountdownTimer extends ConsumerWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ref.watch(timerProvider(const Duration(seconds: 5))).when(
              data: (data) => Text(data),
              error: (error, stackTrace) => const Text('err'),
              loading: () => const CircularProgressIndicator(),
            ),
      ),
    );
  }
}
