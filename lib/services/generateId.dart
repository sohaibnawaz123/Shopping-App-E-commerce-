import 'dart:math';

String generateId() {
  DateTime now = DateTime.now();
  int random = Random().nextInt(99999);
  String id = "${now.millisecondsSinceEpoch}_$random";
  return id;
}
