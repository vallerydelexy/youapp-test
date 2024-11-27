import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({super.key, required this.onTap, required this.title, required this.disabled});

  final bool disabled;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorApp.secondary.withOpacity(disabled ? 0.3 : 1),
              ColorApp.primary.withOpacity(disabled ? 0.3 : 1),
            ],
          ),
          boxShadow: disabled ? [] : [
            BoxShadow(
              color: ColorApp.secondary.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: -10,
              offset: const Offset(0, 20),
            ),
            BoxShadow(
              color: ColorApp.primary.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: -10,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white.withOpacity(disabled ? 0.3 : 1), fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
