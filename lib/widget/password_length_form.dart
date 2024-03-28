import 'package:flutter/material.dart';

class PasswordLengthForm extends StatelessWidget {
  int passwordLength;
  double widthWidget;
  void Function(double value) onChange;

  PasswordLengthForm(
      {required this.passwordLength,
      required this.widthWidget,
      required this.onChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tamanho da senha',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.numbers,
              color: Colors.black54,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              passwordLength.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(
              width: widthWidget,
              child: Slider(
                value: double.parse(passwordLength.toStringAsFixed(2)),
                min: 1.0,
                max: 50.0,
                divisions: 50,
                label: passwordLength.toStringAsFixed(0),
                onChanged: onChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
