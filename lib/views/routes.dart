import 'package:flutter/material.dart';

import 'home/welcome_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';

class Routes {
  Routes._();

  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static final Map<String, Widget> screens = {
    login: const LoginScreen(),
    welcome: const WelcomeScreen(),
    register: const RegisterScreen(),
  };

  static final Map<String, Widget Function(BuildContext)> routes = screens.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
