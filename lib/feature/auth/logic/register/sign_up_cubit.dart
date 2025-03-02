import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.auth) : super(SignUpInitial());
  final AuthRepo auth;
  Future<void> register(
      {required String email, required String password}) async {
    emit(SignUpLoading());
    var result = await auth.registerWithEmail(email: email, password: password);
    result.fold(
      (failure) => emit(SignUpFailed(errMessage: failure.message)),
      (success) => emit(SignUpSuccess(authData: success)),
    );
  }
}
