import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:new_app/feature/auth/UI/widgets/forget_password/forget_pass_view_body.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';
import 'package:new_app/feature/auth/logic/forgetPassword/forget_password_cubit.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(getIt.get<AuthRepo>()),
      child: const Scaffold(
        body: ForgetPasswordViewBody(),
      ),
    );
  }
}
