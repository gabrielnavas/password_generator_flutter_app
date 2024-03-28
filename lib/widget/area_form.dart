import 'package:flutter/material.dart';

class AreaForm extends StatelessWidget {
  final Widget child;
  const AreaForm({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: child,
      ),
    );
  }
}
