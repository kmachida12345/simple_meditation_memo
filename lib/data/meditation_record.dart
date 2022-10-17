import 'package:isar/isar.dart';

import 'review.dart';

part 'meditation_record.g.dart';

@collection
class MeditationRecord {
  Id id = Isar.autoIncrement;
  late DateTime startedAt;
  late DateTime endAt;
  String? comment;
  Review? review;
}

