import 'package:get_it/get_it.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_cubit.dart';
import 'package:meet_the_people/business_logic/cubit/profile_cubit/profile_cubit.dart';
import 'package:meet_the_people/business_logic/services/location_service.dart';

import '../../business_logic/cubit/global_cubit/global_cubit.dart';
import '../../router/app_router.dart';
import '../source/local/my_shared_preferences.dart';
import '../source/network/my_dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MyDio>(
    () => MyDio(),
  );
  sl.registerLazySingleton<MySharedPref>(
    () => MySharedPref(),
  );
  sl.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
  sl.registerLazySingleton<GlobalCubit>(
    () => GlobalCubit(),
  );
  sl.registerLazySingleton<ProfileCubit>(
        () => ProfileCubit(),
  );
  sl.registerLazySingleton<MapCubit>(
        () => MapCubit(),
  );
  sl.registerLazySingleton<LocationService>(
          () => LocationService()
  );
}
