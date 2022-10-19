import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
          return const Text('err');
        }

        return Scaffold(
          body: ListView(
            children: snapshot.data!.map((e) => RecordListItem(record: e!,)).toList(),
          ),
        );
      }
    );
  }

}

class RecordListItem extends StatelessWidget {
  final MeditationRecord record;

  const RecordListItem({required this.record, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP").format(record.startedAt)),
            Text('${Duration(seconds: record.duration).inMinutes} minute(s)')
          ],
        ),
      ),
    );
  }

}