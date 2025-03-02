import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthFailureType {
  emailAlreadyInUse,
  weakPassword,
  invalidCredentials,
  emailNotVerified,
  schemaMismatch,
  emailLinkError,
  oAuthFailure,
  unexpected,
}

class Failure implements Exception {
  final AuthFailureType type;
  final String message;

  Failure({required this.type, required this.message});

  factory Failure.fromException(AuthException error) {
    String errorMessage = error.message;
    if (errorMessage.contains('Email is already taken')) {
      return Failure(
          type: AuthFailureType.emailAlreadyInUse, message: errorMessage);
    } else if (errorMessage.contains('Password should be at least')) {
      return Failure(type: AuthFailureType.weakPassword, message: errorMessage);
    } else if (errorMessage.contains('Incorrect email or password')) {
      return Failure(
          type: AuthFailureType.invalidCredentials, message: errorMessage);
    } else if (errorMessage.contains('Email link')) {
      return Failure(
          type: AuthFailureType.emailLinkError, message: errorMessage);
    } else if (errorMessage.contains('Schema mismatch')) {
      return Failure(
          type: AuthFailureType.schemaMismatch, message: errorMessage);
    } else if (errorMessage.contains('OAuth')) {
      return Failure(type: AuthFailureType.oAuthFailure, message: errorMessage);
    } else {
      return Failure(type: AuthFailureType.unexpected, message: errorMessage);
    }
  }
}
