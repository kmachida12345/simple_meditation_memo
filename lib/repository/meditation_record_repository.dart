import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_meditation_memo/data/meditation_record.dart';
import 'package:simple_meditation_memo/data/review.dart';
import 'package:simple_meditation_memo/main.dart';
import 'package:simple_meditation_memo/service/meditation_record_service.dart';

final Provider<MeditationRecordRepository> meditationRecordRepositoryProvider =
    Provider<MeditationRecordRepository>((ref) => MeditationRecordRepository(
        service: ref.watch(meditationRecordServiceProvider(isar))));

class MeditationRecordRepository {
  MeditationRecordRepository({required this.service});

  final MeditationRecordService service;

  Future<List<MeditationRecord?>> getAllRecords() async {
    return await service.getAll();
  }

  Future<void> add(MeditationRecord record) async {
    await service.add(record: record);
  }
}
