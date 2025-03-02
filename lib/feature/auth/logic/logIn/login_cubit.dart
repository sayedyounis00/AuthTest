import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;
  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    emit(LoginLoading());
    var result =
        await authRepo.signInWithEmail(email: email, password: password);
    result.fold(
      (failure) => emit(LoginFailed(errMessage: failure.message)),
      (success) => emit(LoginSuccess()),
    );
  }
}
