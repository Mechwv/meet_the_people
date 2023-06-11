
import 'package:bloc/bloc.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(): super(MapInitial());

}