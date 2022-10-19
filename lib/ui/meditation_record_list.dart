import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meditation_memo/data/meditation_record.dart';
import 'package:simple_meditation_memo/repository/meditation_record_repository.dart';

class MeditationRecordList extends ConsumerWidget {
  const MeditationRecordList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(meditationRecordRepositoryProvider);

    return FutureBuilder(
      future: records.getAllRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data == null) {
          return Text('data');
        }

        return Scaffold(
          body: Column(
            children: snapshot.data!.map((e) => Text(e?.toString() ?? '')).toList(),
          ),
        );
      }
    );
  }

}