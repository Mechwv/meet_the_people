import 'package:bloc/bloc.dart';

import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());


}
