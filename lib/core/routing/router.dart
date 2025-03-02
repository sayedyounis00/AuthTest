import 'package:flutter/material.dart';
import 'package:new_app/feature/auth/UI/views/confirm_view.dart';
import 'package:new_app/feature/auth/UI/views/forget_password_view.dart';
import 'package:new_app/feature/auth/UI/views/login_view.dart';
import 'package:new_app/feature/auth/UI/views/registeration_view.dart';
import 'package:new_app/feature/home/home_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String confirmEmail = '/ConfirmEmail';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _buildRoute(const LoginView());
      case register:
        return _buildRoute(const RegisterView());
      case confirmEmail:
        return _buildRoute(const ConfirmView());
      case forgotPassword:
        return _buildRoute(const ForgetPasswordView());
      case home:
        return _buildRoute(const HomeView());
      default:
        return _buildRoute(const ErrorPage());
    }
  }

  static MaterialPageRoute _buildRoute(Widget child) {
    return MaterialPageRoute(
      builder: (context) => child,
      settings: const RouteSettings(),
      fullscreenDialog: true,
      maintainState: true,
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Error Page"),
      ),
    );
  }
}
