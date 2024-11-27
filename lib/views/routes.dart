import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/services/api/auth_api.dart';
import 'package:test/services/bloc/login_bloc.dart';

import 'home/welcome_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';

class Routes {
  Routes._();

  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static final Map<String, Widget> screens = {
    login: BlocProvider(create: (context) => LoginBloc(AuthApi()), child: const LoginScreen()),
    welcome: const WelcomeScreen(),
    register: const RegisterScreen(),
  };

  static final Map<String, Widget Function(BuildContext)> routes =
      screens.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
