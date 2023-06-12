import 'package:bloc/bloc.dart';
import 'package:meet_the_people/business_logic/cubit/people_cubit/people_state.dart';
import 'package:meet_the_people/data/models/person.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../data/repository/people_repository.dart';
import '../../../data/source/network/api_result_handler.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial());

  List<Person> peopleNear = [];

  List<Point> teslaMovement = [
    Point(latitude: 55.62667161534179, longitude: 37.419802532771),
    Point(latitude: 55.626927448190855, longitude: 37.41997723334393),
    Point(latitude: 55.627293751395776, longitude: 37.420151933916884),
    Point(latitude: 55.62750306596913, longitude: 37.420326634489754),
    Point(latitude: 55.6276949366751, longitude: 37.42041912302838),
    Point(latitude: 55.6279100633145, longitude: 37.420470505549815),
    Point(latitude: 55.62802634749065, longitude: 37.42035746400265),
    Point(latitude: 55.62810193201935, longitude: 37.420151933916884),
    Point(latitude: 55.62817751640163, longitude: 37.41995668033536),
    Point(latitude: 55.62846822419986, longitude: 37.419802532771),
  ];

  List<Point> lomonosovMovement = [
    Point(latitude: 55.62974739243334, longitude: 37.4216523635437),
    Point(latitude: 55.63275919594249, longitude: 37.41836351178074),
    Point(latitude: 55.6327882681208, longitude: 37.418569075200736),
    Point(latitude: 55.63281152584784, longitude: 37.41889797667278),
    Point(latitude: 55.632962700735675, longitude: 37.41896992386978),
    Point(latitude: 55.6331022462661, longitude: 37.418815751304805),
    Point(latitude: 55.6332650487541, longitude: 37.41868213508175),
    Point(latitude: 55.63340459320312, longitude: 37.418548518858756),
    Point(latitude: 55.63357320874644, longitude: 37.41845601531972),
    Point(latitude: 55.63381159499529, longitude: 37.41829156458368),
  ];

  void getPeopleNear() async {
    emit(PeopleLoadingState());
    ApiResults res = await PeopleRepository().getPeopleNear();
    if (res is ApiSuccess) {
      peopleNear.addAll(res.data as List<Person>);
    }
    print("PEOPLE_NEAR:$peopleNear");
    emit(PeopleLoadSuccess());
  }

  void getCoordinates() async {}
}
