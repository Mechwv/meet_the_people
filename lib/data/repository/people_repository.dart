import 'package:meet_the_people/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:meet_the_people/data/models/person.dart';
import 'package:uuid/uuid.dart';

import '../di/di.dart';
import '../source/network/api_result_handler.dart';

class PeopleRepository {

  List<Person> persons = [];

  Future<ApiResults> getPeopleNear() async {

    return Future.delayed(const Duration(seconds: 1), () {
      _generatePersons();
      return ApiSuccess(persons, 200);
    });
  }

  void _generatePersons() {
    final uuids = sl<GlobalCubit>().uuids;
    // for (var i = 0; i < 20; i++) {
    //   persons.add(Person(
    //       id: uuids[i],
    //       name: "Михаил Ломоносов",
    //       desc: "Всегда рад живому общению и новым знакомствам",
    //       avatar:
    //           "https://cdn.culture.ru/images/0b926ae7-2a2b-5e67-acbb-1867b42b890f"));
    //   print("PERSON_$i id: ${uuids[i]}")
    // }
    persons = [
      Person(
          id: uuids[0],
          name: "Михаил Ломоносов",
          desc: "Всегда рад живому общению и новым знакомствам",
          avatar:
          "https://cdn.culture.ru/images/0b926ae7-2a2b-5e67-acbb-1867b42b890f"),
      Person(
          id: uuids[1],
          name: "Никола Тесла",
          desc: "Нет ничего, что в большей степени могло бы привлечь внимание человека и заслужило бы быть предметом изучения, чем природа",
          avatar:
          "https://avatars.dzeninfra.ru/get-zen_doc/3842094/pub_5f4fa25b50251b530385f7e4_5f4fa5014ceb137c3d2730a4/scale_1200"),
      Person(
          id: uuids[2],
          name: "Антон Чехов",
          desc: "В человеке должно быть всё прекрасно: и лицо, и одежда, и душа, и мысли.",
          avatar:
          "https://cdn.culture.ru/images/96a7ec23-bff7-50d5-9336-500a3632db2f"),
      Person(
          id: uuids[3],
          name: "Юрий Гагарин",
          desc: "Поехали!",
          avatar:
          "https://s12.stc.yc.kpcdn.net/share/i/12/10808682/de-1200.jpg"),
      Person(
          id: uuids[4],
          name: "Константин Циолковский",
          desc: "Невозможное сегодня станет возможным завтра",
          avatar:
          "https://dolgoprudnymuseum.ru/wp-content/uploads/2022/09/Konstantin-Tsiolkovsky-tsiolkovsky_org-009-www-color.jpg"),
    ];
  }
}


