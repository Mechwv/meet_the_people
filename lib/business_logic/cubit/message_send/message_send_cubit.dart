
import 'package:bloc/bloc.dart';
import 'package:meet_the_people/business_logic/cubit/auth/auth_state.dart';
import 'package:meet_the_people/business_logic/cubit/message_send/message_send_state.dart';

class MessageSendCubit extends Cubit<MessageSendState> {
  MessageSendCubit(): super(MessageSendInitial());

  void send() {
    emit(MessageSendSuccess());
  }
}