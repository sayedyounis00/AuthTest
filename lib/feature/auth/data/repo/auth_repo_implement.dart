import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:new_app/core/network/failure.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImplement implements AuthRepo {
  final SupabaseClient _supabase = Supabase.instance.client;
  @override
  //? Register With Email and Password
  Future<Either<Failure, AuthResponse>> registerWithEmail(
      {required String email, required String password}) async {
    try {
      AuthResponse result = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return right(result);
    } on AuthException catch (e) {
      return left(Failure.fromException(e));
    }
  }

  //? [sign in  With Email and Password]
  @override
  Future<Either<Failure, AuthResponse>> signInWithEmail(
      {required String email, required String password}) async {
    try {
      AuthResponse result = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return right(result);
    } on AuthException catch (e) {
      log(e.toString());
      return left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(
      {required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      log("Success");
      return right("Success Login");
    } on AuthException catch (e) {
      log(e.toString());
      return left(Failure.fromException(e));
    }
  }

  // //? SignOut
  // @override
  // Future<void> signOut() async {
  //   await _supabase.auth.signOut();
  // }

  // //? getUserEmail
  // @override
  // String? getUserEmail() {
  //   final session = _supabase.auth.currentSession;
  //   final user = session?.user;
  //   final email = user?.email;
  //   return email;
  // }
}
