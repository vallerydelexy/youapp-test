import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/widgets/sleek_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: const Center(
          child: Column(
            children: [
              Text("YOUAPP TEST",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  )),
              Text("By Rizki Aprita", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SleekButton(
              title: "Login with Email/Phone",
              onTap: () => Navigator.pushNamed(context, '/login'),
              icon: CupertinoIcons.device_phone_portrait),
          const SizedBox(height: 20),
          SleekButton(
              title: "Register a new account", onTap: () => Navigator.pushNamed(context, '/register'), icon: CupertinoIcons.add_circled),
          const SizedBox(height: 20),
        ]),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: const Text("© 2024 Rizki Aprita", style: TextStyle(color: Colors.grey)),
        ),
      ),
    ]);
  }
}
