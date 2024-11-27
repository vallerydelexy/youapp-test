import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/views/home/welcome_screen.dart';
import 'package:test/views/routes.dart';
import 'package:test/widgets/gradient_background.dart';

import 'services/bloc/app_bloc.dart';
import 'services/bloc/app_bloc_state.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouApp Test',
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      initialRoute: Routes.welcome,
      routes: Routes.routes,
      home: BlocProvider(
        create: (context) => AppBloc(),
        child: GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocConsumer<AppBloc, AppState>(
              listener: (context, state) => {},
              builder: (context, state) => const WelcomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
