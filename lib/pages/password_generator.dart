import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/models/password_generator_form.dart';
import 'package:password_generator/widget/password_filters_form.dart';
import 'package:password_generator/widget/password_length_form.dart';
import 'package:password_generator/widget/password_type_form.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  final TextEditingController _passwordController = TextEditingController();

  PasswordGeneratorForm _passwordGeneratorForm = PasswordGeneratorForm();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  void onHandlePasswordType(value) {
    if (value == null) {
      return;
    }
    setState(() {
      _passwordGeneratorForm.changeTypePassword(value);
      _passwordGeneratorForm.refreshPassword();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    _passwordController.text = _passwordGeneratorForm.password.value;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Gerador de senhas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PasswordLengthForm(
                  passwordLength:
                      _passwordGeneratorForm.password.settings.length,
                  widthWidget: widthScreen * 0.78,
                  onChange: (double value) {
                    setState(() {
                      _passwordGeneratorForm
                          .changeLengthPassword(value.toInt());
                      _passwordGeneratorForm.refreshPassword();
                    });
                  }),
              const Divider(),
              PasswordTypeForm(
                passwordType: _passwordGeneratorForm.passwordType,
                onChangeEasyToSay: onHandlePasswordType,
                onChangeEasyToRead: onHandlePasswordType,
                onChangeAllCharacters: onHandlePasswordType,
              ),
              const Divider(),
              PasswordFiltersForm(
                passwordGeneratorForm: _passwordGeneratorForm,
                onChangeUpperCase: (value) => setState(() {
                  _passwordGeneratorForm.password.settings.hasUppercase =
                      value!;
                  _passwordGeneratorForm.refreshPassword();
                }),
                onChangeLowerCase: (value) => setState(() {
                  _passwordGeneratorForm.password.settings.hasLowercase =
                      value!;
                  _passwordGeneratorForm.refreshPassword();
                }),
                onChangeNumbers: (value) => setState(() {
                  _passwordGeneratorForm.password.settings.hasNumbers = value!;
                  _passwordGeneratorForm.refreshPassword();
                }),
                onChangeSymbols: (value) => setState(() {
                  _passwordGeneratorForm.password.settings.hasSymbols = value!;
                  _passwordGeneratorForm.refreshPassword();
                }),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      _passwordController.text.isEmpty
                          ? 'Selecione um filtro...'
                          : 'Senha gerada',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  if (_passwordController.text.isNotEmpty)
                    IconButton(
                      color: Colors.blueAccent,
                      iconSize: 32,
                      onPressed: () => _copyToClipboard(context),
                      icon: const Icon(Icons.copy),
                    ),
                  if (_passwordController.text.isNotEmpty)
                    IconButton(
                      color: Colors.blueAccent,
                      iconSize: 32,
                      onPressed: () => refreshPassword(context),
                      icon: const Icon(Icons.refresh),
                    ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                width: widthScreen * 0.90,
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 27),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  controller: _passwordController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(
            ClipboardData(text: _passwordGeneratorForm.password.value))
        .then((_) {
      _showMessage('Senha copiada para área de transferência!');
    });
  }

  void refreshPassword(BuildContext context) {
    setState(() {
      _passwordGeneratorForm.refreshPassword();
      _showMessage('Senha gerada com sucesso!');
    });
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
