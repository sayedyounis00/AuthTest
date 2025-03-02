// registration_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:new_app/feature/auth/UI/widgets/registeration/registeration_view_body.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';
import 'package:new_app/feature/auth/logic/register/sign_up_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = GetIt.instance;
    return BlocProvider(
      create: (context) => SignUpCubit(repo.get<AuthRepo>()),
      child: const Scaffold(
        body: RegisterViewBody(),
      ),
    );
  }
}
