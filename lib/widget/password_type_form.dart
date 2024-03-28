import 'package:flutter/material.dart';
import 'package:password_generator/models/password_generator_form.dart';

class PasswordTypeForm extends StatelessWidget {
  PasswordType passwordType;
  void Function(PasswordType? value) onChangeEasyToSay;
  void Function(PasswordType? value) onChangeEasyToRead;
  void Function(PasswordType? value) onChangeAllCharacters;

  PasswordTypeForm({
    required this.passwordType,
    required this.onChangeEasyToSay,
    required this.onChangeEasyToRead,
    required this.onChangeAllCharacters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          child: Text(
            'Tipo de senha',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black87,
            ),
          ),
        ),
        Row(
          children: [
            Radio<PasswordType>(
              value: PasswordType.easyToSay,
              groupValue: passwordType,
              onChanged: onChangeEasyToSay,
            ),
            const Text(
              'Fácil de falar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        Row(
          children: [
            Radio<PasswordType>(
                value: PasswordType.easyToRead,
                groupValue: passwordType,
                onChanged: onChangeEasyToRead),
            const Text(
              'Fácil de ler',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        Row(
          children: [
            Radio<PasswordType>(
                value: PasswordType.allCharacters,
                groupValue: passwordType,
                onChanged: onChangeAllCharacters),
            const Text(
              'Todos os caracteres',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
      ],
    );
  }
}
