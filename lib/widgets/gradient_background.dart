import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const RadialGradient(
          center: Alignment(1, -0.9),
          radius: 2,
          colors: [
            Color(0xFF1F4247),
            Color(0xFF0D1D23),
            Color(0xFF09141A),
          ],
          stops: [0.0, 0.562, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: child,
      ),
    );
  }
}
