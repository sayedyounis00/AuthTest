import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/core/helper/validate_functions.dart';
import 'package:new_app/core/routing/router.dart';
import 'package:new_app/core/widgets/failure_widget.dart';
import 'package:new_app/feature/auth/UI/widgets/grident_button.dart';
import 'package:new_app/feature/auth/UI/widgets/input_feild.dart';
import 'package:new_app/feature/auth/logic/logIn/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.25,
      left: 20,
      right: 20,
      child: Card(
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                    label: 'Email',
                    icon: Icons.email,
                    controller: emailController,
                    validator: ValidateFunction.validateEmail),
                const SizedBox(height: 20),
                InputField(
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: obsecureText,
                    suffixIcon: IconButton(
                        onPressed: () {
                          obsecureText = !obsecureText;
                          setState(() {});
                        },
                        icon: Icon(obsecureText
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye)),
                    controller: passwordController,
                    validator: ValidateFunction.validatePassword),
                const SizedBox(height: 30),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return GradientButton(
                      text: state is LoginLoading ? " loading.." : 'LOG IN',
                      colors: const [Colors.purple, Colors.deepPurple],
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .signInWithEmail(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then(
                            (value) {
                              if (context.mounted) {
                                Navigator.pushNamed(context, AppRoutes.home);
                              }
                            },
                          );
                          if (state is LoginFailed) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  FailureWidget(errorMessage: state.errMessage),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.forgotPassword),
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
