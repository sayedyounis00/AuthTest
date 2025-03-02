import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.auth) : super(ForgetPasswordInitial());
  final AuthRepo auth;
  void forgetPassword(email) async {
    emit(ForgetPasswordLoading());
    var result = await auth.forgetPassword(email: email);
    result.fold(
      (fail) => emit(ForgetPasswordFailed(errMessage: fail.message)),
      (success) => emit(ForgetPasswordSuccess()),
    );
  }
}
