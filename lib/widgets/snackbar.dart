import 'package:flutter/material.dart';


class SnackBarApp {
  static void success(BuildContext context, String? message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ??= '', style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.green.withOpacity(0.8),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  static void danger(BuildContext context, String? message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ??= '', style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red.withOpacity(0.8),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  static void warning(BuildContext context, String? message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ??= '', style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.yellow.withOpacity(0.8),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  static void info(BuildContext context, String? message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ??= '', style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.withOpacity(0.8),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
