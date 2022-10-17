import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:simple_meditation_memo/data/meditation_record.dart';

import '../data/review.dart';

final ProviderFamily<MeditationRecordService, Isar>
    meditationRecordServiceProvider =
    Provider.family<MeditationRecordService, Isar>(
        (_, isar) => MeditationRecordService(isar: isar));

class MeditationRecordService {
  MeditationRecordService({required this.isar});

  final Isar isar;

  Future<int> add({required Review? review, String? comment}) async {
    final record = MeditationRecord()
      ..review = review
      ..comment = comment
      ..startedAt = DateTime.now()
      ..endAt = DateTime.now();
    return isar.writeTxn(() => isar.meditationRecords.put(record));
  }

  Future<List<MeditationRecord?>> getAll() {
    return isar.meditationRecords.where().findAll();
  }
}
