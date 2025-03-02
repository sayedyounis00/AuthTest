import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/core/routing/router.dart';
import 'package:new_app/feature/auth/UI/widgets/grident_button.dart';
import 'package:new_app/feature/auth/UI/widgets/input_feild.dart';

class ConfirmCodeForm extends StatefulWidget {
  const ConfirmCodeForm({super.key});

  @override
  State<ConfirmCodeForm> createState() => _ConfirmCodeFormState();
}

class _ConfirmCodeFormState extends State<ConfirmCodeForm> {
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  bool _isProcessing = false;
  bool _isResendDisabled = false;
  int _resendTimer = 60;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) return 'Code is required';
    if (value.length != 6) return 'Code must be 6 digits';
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'Only numbers allowed';
    return null;
  }

  void _startResendTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_resendTimer == 0) {
          _timer?.cancel();
          _isResendDisabled = false;
        } else {
          _resendTimer--;
        }
      });
    });
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification successful!')),
        );
      }
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
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
                  'Check your email for the 6-digit code',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 25),
                InputField(
                  label: 'Verification Code',
                  icon: Icons.lock_reset,
                  controller: codeController,
                  validator: validateCode,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Text(
                  'Didn\'t receive the code?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                TextButton(
                  onPressed: _isResendDisabled
                      ? null
                      : () {
                          _startResendTimer();
                          setState(() {
                            _isResendDisabled = true;
                            _resendTimer = 60;
                          });
                        },
                  child: Text(
                    _isResendDisabled ? "Resend $_resendTimer" : 'Resend Code',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 30),
                GradientButton(
                  text: _isProcessing ? 'VERIFYING...' : 'VERIFY',
                  colors: [Colors.pink[400]!, Colors.deepOrange[400]!],
                  onPressed: () {
                    //! proplem is here
                    _isProcessing ? null : () => _submitForm(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
