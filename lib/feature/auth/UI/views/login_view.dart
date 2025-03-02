import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:new_app/feature/auth/UI/widgets/login/login_view_body.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';
import 'package:new_app/feature/auth/logic/logIn/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
