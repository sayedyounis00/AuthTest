// registration_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/core/helper/validate_functions.dart';
import 'package:new_app/core/routing/router.dart';
import 'package:new_app/core/widgets/failure_widget.dart';
import 'package:new_app/feature/auth/UI/widgets/grident_button.dart';
import 'package:new_app/feature/auth/UI/widgets/input_feild.dart';
import 'package:new_app/feature/auth/logic/register/sign_up_cubit.dart';
import 'password_strength_meter.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool obsecureText = true;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    confirmPasswordController.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.25,
      left: 20,
      right: 20,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  label: 'Full Name',
                  icon: Icons.person,
                  controller: nameController,
                  validator: ValidateFunction.validateName,
                ),
                const SizedBox(height: 15),
                InputField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                  validator: ValidateFunction.validateEmail,
                ),
                const SizedBox(height: 15),
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
                          ? Icons.remove_red_eye_rounded
                          : Icons.remove_red_eye_outlined)),
                  controller: passwordController,
                  validator: ValidateFunction.validatePassword,
                  onChange: (val) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                PasswordStrengthMeter(password: passwordController.text),
                const SizedBox(height: 15),
                InputField(
                  label: 'Confirm Password',
                  icon: Icons.lock_reset,
                  obscureText: obsecureText,
                  controller: confirmPasswordController,
                  validator: validateConfirmPassword,
                ),
                const SizedBox(height: 25),
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return GradientButton(
                      text: state is SignUpLoading ? 'Loading' : 'REGISTER',
                      colors: [Colors.pink[400]!, Colors.deepOrange[400]!],
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<SignUpCubit>(context)
                              .register(
                            email: emailController.text,
                            password: passwordController.text,
                          )
                              .then((value) {
                            if (context.mounted) {
                              Navigator.pushNamed(
                                  context, AppRoutes.confirmEmail);
                            }
                          });
                          if (state is SignUpFailed) {
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
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.login),
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
