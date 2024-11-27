import 'package:flutter/material.dart';
import 'package:test/utils/colors.dart';

class SleekButton extends StatelessWidget {
  const SleekButton({super.key, required this.title, required this.onTap, required this.icon});
  final IconData icon;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: ColorApp.faintWhite,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 10), child: Icon(icon, color: Colors.white)),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
