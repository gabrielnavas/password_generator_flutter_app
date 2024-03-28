import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:password_generator/messages/show_message.dart';
import 'package:password_generator/models/password_generator_form.dart';

class PasswordGeneratedForm extends StatelessWidget {
  final TextEditingController passwordController;
  final PasswordGeneratorForm passwordGeneratorForm;
  double widthScreen;
  Function(BuildContext context) refreshPassword;
  final String password;

  PasswordGeneratedForm({
    required this.passwordController,
    required this.passwordGeneratorForm,
    required this.widthScreen,
    required this.refreshPassword,
    required this.password,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const colorBackgroundItems = Color.fromARGB(179, 227, 227, 227);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Text(
                passwordController.text.isEmpty ? '' : 'Senha gerada',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            if (passwordController.text.isNotEmpty)
              IconButton(
                color: Colors.blueAccent,
                iconSize: 32,
                onPressed: () => _copyToClipboard(context),
                icon: const Icon(Icons.copy),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => colorBackgroundItems,
                  ),
                ),
              ),
            const SizedBox(
              width: 10,
            ),
            if (passwordController.text.isNotEmpty)
              IconButton(
                color: Colors.blueAccent,
                iconSize: 32,
                onPressed: () => refreshPassword(context),
                icon: const Icon(Icons.refresh),
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => colorBackgroundItems,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: widthScreen * 0.90,
          child: TextField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Selecione um filtro...",
              fillColor: colorBackgroundItems,
            ),
            textAlign: TextAlign.center,
            controller: passwordController,
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: password)).then((_) {
      ShowMessage.showMessageSnack(
          context, 'Senha copiada para área de transferência!');
    });
  }
}
