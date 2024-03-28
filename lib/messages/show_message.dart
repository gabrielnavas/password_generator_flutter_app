import 'package:flutter/material.dart';

class ShowMessage {
  static void showMessageSnack(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
