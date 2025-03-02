import 'package:new_app/core/network/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthResponse>> registerWithEmail(
      {required String email, required String password});
      //?
  Future<Either<Failure, AuthResponse>> signInWithEmail(
      {required String email, required String password});
      //?
   Future<Either<Failure, String>> forgetPassword({required String email});
}
