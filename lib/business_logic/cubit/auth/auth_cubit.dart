
import 'package:bloc/bloc.dart';
import 'package:meet_the_people/business_logic/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(): super(AuthInitial());

  void auth() {
    emit(AuthSuccess());
  }
}