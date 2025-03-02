part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {}

final class ForgetPasswordFailed extends ForgetPasswordState {
  final String errMessage;

  ForgetPasswordFailed({required this.errMessage});
}

final class ForgetPasswordLoading extends ForgetPasswordState {}
