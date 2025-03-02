part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final AuthResponse authData;
 
  SignUpSuccess({required this.authData});
}

final class SignUpFailed extends SignUpState {
  final String errMessage;

  SignUpFailed({required this.errMessage});
}

final class SignUpLoading extends SignUpState {}
