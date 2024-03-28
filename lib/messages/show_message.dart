import 'package:flutter/material.dart';

class ShowMessage {
  static void showMessageSnack(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
