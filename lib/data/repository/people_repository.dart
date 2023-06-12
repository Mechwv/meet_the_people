import 'package:meet_the_people/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:meet_the_people/data/models/person.dart';
import 'package:uuid/uuid.dart';

import '../di/di.dart';
import '../source/network/api_result_handler.dart';

class PeopleRepository {
  Future<ApiResults> getPeopleNear() async {
    return Future.delayed(const Duration(seconds: 1), () {
      final persons = _generatePersons();
      return ApiSuccess(persons, 200);
    });
  }
}

List<Person> _generatePersons() {
  final List<Person> persons = [];
  final uuids = sl<GlobalCubit>().uuids;
  for (var i = 0; i < 20; i++) {
    persons.add(Person(
        id: uuids[i],
        name: "Михаил Ломоносов",
        desc: "Всегда рад живому общению и новым знакомствам",
        avatar:
            "https://cdn.culture.ru/images/0b926ae7-2a2b-5e67-acbb-1867b42b890f"));
    print("PERSON_$i id: ${uuids[i]}");
  }
  return persons;
}
