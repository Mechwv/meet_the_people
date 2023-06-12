import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/di/di.dart';
import '../../../data/source/local/my_shared_preferences.dart';
import '../../../data/source/local/my_shared_preferences_keys.dart';

import 'package:meet_the_people/constants/constant_methods.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalStates> {
  GlobalCubit() : super(GlobalInitial());

  List<String> uuids = [];

  static GlobalCubit get(context) => BlocProvider.of<GlobalCubit>(context);

  bool isLightTheme = false;
  void changeAppTheme() {
    isLightTheme = !isLightTheme;
    sl<MySharedPref>().putBoolean(key: MySharedKeys.theme, value: isLightTheme);
    emit(ChangeAppThemeState());
  }

  void getAppTheme() {
    isLightTheme =
        sl<MySharedPref>().getBoolean(key: MySharedKeys.theme) ?? true;
  }

  void initSetup() {
    uuids.addAll(uuidGen(5));
    print("GLOBAL_SET_UP_OK $uuids");
  }
}
