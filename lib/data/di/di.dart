import 'package:get_it/get_it.dart';
import 'package:meet_the_people/business_logic/cubit/event_cubit/event_cubit.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_cubit.dart';
import 'package:meet_the_people/business_logic/cubit/people_cubit/people_cubit.dart';
import 'package:meet_the_people/business_logic/cubit/profile_cubit/profile_cubit.dart';
import 'package:meet_the_people/business_logic/services/location_service.dart';

import '../../business_logic/cubit/auth/auth_cubit.dart';
import '../../business_logic/cubit/global_cubit/global_cubit.dart';
import '../../business_logic/cubit/message_send/message_send_cubit.dart';
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
  sl.registerLazySingleton<PeopleCubit>(
        () => PeopleCubit(),
  );
  sl.registerLazySingleton<EventCubit>(
        () => EventCubit(),
  );
  sl.registerLazySingleton<MapCubit>(
        () => MapCubit(),
  );
  sl.registerLazySingleton<AuthCubit>(
        () => AuthCubit(),
  );
  sl.registerLazySingleton<MessageSendCubit>(
        () => MessageSendCubit(),
  );
  sl.registerLazySingleton<LocationService>(
          () => LocationService()
  );
}
