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

  Future<int> add({required MeditationRecord record}) async {
    return isar.writeTxn(() => isar.meditationRecords.put(record));
  }

  Future<List<MeditationRecord?>> getAll() {
    return isar.meditationRecords.where().findAll();
  }
}
