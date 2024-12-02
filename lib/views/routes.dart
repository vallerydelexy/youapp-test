import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/services/api/auth_api.dart';
import 'package:test/services/api/user_api.dart';
import 'package:test/services/bloc/login_bloc.dart';
import 'package:test/services/bloc/profile_form_bloc.dart';
import 'package:test/services/bloc/register_bloc.dart';
import 'package:test/services/bloc/user_bloc.dart';

import 'home/welcome_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'profile/profile_screen.dart';
import 'profile/interest_screen.dart';

class Routes {
  Routes._();

  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String about = '/about';
  static const String interest = '/about/interest';

  static final Map<String, Widget> screens = {
    login: BlocProvider(create: (context) => LoginBloc(AuthApi()), child: const LoginScreen()),
    welcome: const WelcomeScreen(),
    register: BlocProvider(create: (context) => RegisterBloc(AuthApi()), child: const RegisterScreen()),
    about: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(userApi: UserApi()),
        ),
        BlocProvider(
          create: (context) => ProfileFormBloc(UserApi()),
        ),
      ],
      child: const ProfileScreen(),
    ),
    interest: BlocProvider(
      create: (context) => ProfileFormBloc(UserApi()),
      child: const InterestScreen(),
    ),
  };

  static final Map<String, Widget Function(BuildContext)> routes =
      screens.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
