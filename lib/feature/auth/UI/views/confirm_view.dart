import 'package:flutter/material.dart';
import 'package:new_app/feature/auth/UI/widgets/confirmView/confirm_view_body.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ConfirmViewBody(),
    );
  }
}
