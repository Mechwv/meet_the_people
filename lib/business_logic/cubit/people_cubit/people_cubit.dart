import 'package:bloc/bloc.dart';
import 'package:meet_the_people/business_logic/cubit/people_cubit/people_state.dart';
import 'package:meet_the_people/data/models/person.dart';

import '../../../data/repository/people_repository.dart';
import '../../../data/source/network/api_result_handler.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial());

  List<Person> peopleNear = [];

  void getPeopleNear() async {
    emit(PeopleLoadingState());
    ApiResults res = await PeopleRepository().getPeopleNear();
    if (res is ApiSuccess) {
      peopleNear.addAll(res.data as List<Person>);
    }
    print("PEOPLE_NEAR:$peopleNear");
    emit(PeopleLoadSuccess());
  }

}
