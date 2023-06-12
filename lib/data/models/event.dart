import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class Event {
  final Uuid id;
  final String name;
  final String desc;
  final String avatar;

  Event(
      {required this.id,
      required this.name,
      required this.desc,
      required this.avatar});
}
