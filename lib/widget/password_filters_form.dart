import 'package:flutter/material.dart';
import 'package:password_generator/models/password_generator_form.dart';

class PasswordFiltersForm extends StatelessWidget {
  final PasswordGeneratorForm passwordGeneratorForm;
  final Function(bool? value) onChangeUpperCase;
  final Function(bool? value) onChangeLowerCase;
  final Function(bool? value) onChangeNumbers;
  final Function(bool? value) onChangeSymbols;

  const PasswordFiltersForm({
    required this.passwordGeneratorForm,
    required this.onChangeUpperCase,
    required this.onChangeLowerCase,
    required this.onChangeNumbers,
    required this.onChangeSymbols,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Filtros disponíveis',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.filter_alt_outlined,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.white;
                }
                return Colors.blue;
              }),
              value: passwordGeneratorForm.password.settings.hasUppercase,
              onChanged: onChangeUpperCase,
            ),
            const Text(
              'Letras maiúsculas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.white;
                  }
                  return Colors.blueAccent;
                }),
                value: passwordGeneratorForm.password.settings.hasLowercase,
                onChanged: onChangeLowerCase),
            const Text(
              'Letras minúsculas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.white;
                }
                return Colors.blue;
              }),
              value: passwordGeneratorForm.password.settings.hasNumbers,
              onChanged: passwordGeneratorForm.disableNumbersOption()
                  ? null
                  : onChangeNumbers,
            ),
            const Text(
              'Números',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.white;
                }
                return Colors.blue;
              }),
              value: passwordGeneratorForm.password.settings.hasSymbols,
              onChanged: passwordGeneratorForm.disableSymbolsOption()
                  ? null
                  : onChangeSymbols,
            ),
            const Text(
              'Símbolos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
