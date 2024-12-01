import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';

class DarkBackground extends StatelessWidget {
  final Widget child;

  const DarkBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          FocusScope.of(context).unfocus();
        },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ColorApp.dark,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: child,
        ),
      ),
    );
  }
}
