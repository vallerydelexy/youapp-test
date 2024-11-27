import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarBackButton extends StatelessWidget {
  const AppbarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: const Row(children: [
        Icon(CupertinoIcons.back, color: Colors.white),
        Text("Back", style: TextStyle(color: Colors.white, fontSize: 14)),
      ]),
    );
  }
}
