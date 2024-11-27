import 'package:flutter/material.dart';

import 'package:test/views/home/welcome_screen.dart';
import 'package:test/views/routes.dart';



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
      home: const WelcomeScreen()
    );
  }
}
