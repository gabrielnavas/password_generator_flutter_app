import 'package:flutter/material.dart';
import 'package:password_generator/messages/show_message.dart';
import 'package:password_generator/models/password_generator_form.dart';
import 'package:password_generator/widget/area_form.dart';
import 'package:password_generator/widget/password_filters_form.dart';
import 'package:password_generator/widget/password_generated_form.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AreaForm(
              child: PasswordLengthForm(
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
            ),
            const Divider(),
            AreaForm(
              child: PasswordTypeForm(
                passwordType: _passwordGeneratorForm.passwordType,
                onChangeEasyToSay: onHandlePasswordType,
                onChangeEasyToRead: onHandlePasswordType,
                onChangeAllCharacters: onHandlePasswordType,
              ),
            ),
            const Divider(),
            AreaForm(
              child: PasswordFiltersForm(
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
            ),
            const Divider(),
            AreaForm(
              child: PasswordGeneratedForm(
                passwordController: _passwordController,
                passwordGeneratorForm: _passwordGeneratorForm,
                widthScreen: widthScreen,
                refreshPassword: _refreshPassword,
                password: _passwordGeneratorForm.password.value,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _refreshPassword(BuildContext context) {
    setState(() {
      _passwordGeneratorForm.refreshPassword();
      ShowMessage.showMessageSnack(context, 'Senha gerada com sucesso!');
    });
  }
}
