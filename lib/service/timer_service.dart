import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider = StreamProvider.family<String, Duration>(
  (ref, arg) {
    const oneSec = Duration(seconds: 1);
    return Stream.periodic(
      oneSec,
      (computationCount) => Duration(seconds: (arg.inSeconds - computationCount)).toString(),
    );
  },
);
