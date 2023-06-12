import 'dart:typed_data';

import 'package:uuid/uuid.dart';

class Person {
  final String id;
  final String name;
  final String desc;
  final String avatar;

  Person(
      {required this.id,
      required this.name,
      required this.desc,
      required this.avatar});
}
