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
        const Text(
          'Tamanho da senha',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              passwordLength.toStringAsFixed(2),
              // _passwordGeneratorForm.password.settings.length
              //     .toStringAsFixed(0),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(
              // width: widthScreen * .85,
              width: widthWidget,
              child: Slider(
                // value: double.parse(_passwordGeneratorForm
                //     .password.settings.length
                //     .toStringAsFixed(2)),
                value: double.parse(passwordLength.toStringAsFixed(2)),
                min: 1.0,
                max: 50.0,
                divisions: 50,
                // label: _passwordGeneratorForm.password.settings.length
                //     .round()
                //     .toString(),
                label: passwordLength.toStringAsFixed(2),
                // onChanged: (double value) {
                //   setState(() {
                //     _passwordGeneratorForm.changeLengthPassword(value.toInt());
                //     _passwordGeneratorForm.refreshPassword();
                //   });
                // },
                onChanged: onChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
