
import 'package:isar/isar.dart';

@embedded
class Review {
  int? review;

  bool isValid() {
    return review != null ? 0 < review! && review! < 6 : false;
  }
}