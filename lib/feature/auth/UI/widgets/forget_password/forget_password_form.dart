import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/core/widgets/failure_widget.dart';
import 'package:new_app/feature/auth/UI/widgets/grident_button.dart';
import 'package:new_app/feature/auth/UI/widgets/input_feild.dart';
import 'package:new_app/feature/auth/logic/forgetPassword/forget_password_cubit.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool _isProcessing = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  void submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isProcessing = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reset email sent!')),
      );
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
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
                Text(
                  'Enter your email to reset your password',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 25),
                InputField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                  validator: validateEmail,
                ),
                const SizedBox(height: 30),
                BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordSuccess) {
                      _isProcessing ? null : submitForm(context);
                    } else if (state is ForgetPasswordFailed) {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            FailureWidget(errorMessage: state.errMessage),
                      );
                    }
                  },
                  child: GradientButton(
                    text: _isProcessing ? 'SENDING...' : 'RESET PASSWORD',
                    colors: [Colors.pink[400]!, Colors.deepOrange[400]!],
                    onPressed: () {
                      BlocProvider.of<ForgetPasswordCubit>(context)
                          .forgetPassword(emailController.text);
                    },
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
