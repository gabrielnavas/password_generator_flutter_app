import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/models/password_generator_form.dart';

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
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tamanho da senha',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _passwordGeneratorForm.password.settings.length
                      .toStringAsFixed(0),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(
                  width: widthScreen * .85,
                  child: Slider(
                    value: double.parse(_passwordGeneratorForm
                        .password.settings.length
                        .toStringAsFixed(2)),
                    min: 1.0,
                    max: 50.0,
                    divisions: 50,
                    label: _passwordGeneratorForm.password.settings.length
                        .round()
                        .toString(),
                    onChanged: (double value) {
                      setState(() {
                        _passwordGeneratorForm
                            .changeLengthPassword(value.toInt());
                        _passwordGeneratorForm.refreshPassword();
                      });
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
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
                  groupValue: _passwordGeneratorForm.passwordType,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _passwordGeneratorForm.changeTypePassword(value);
                      _passwordGeneratorForm.refreshPassword();
                    });
                  },
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
                  groupValue: _passwordGeneratorForm.passwordType,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _passwordGeneratorForm.changeTypePassword(value);
                      _passwordGeneratorForm.refreshPassword();
                    });
                  },
                ),
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
                  groupValue: _passwordGeneratorForm.passwordType,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _passwordGeneratorForm.changeTypePassword(value);
                      _passwordGeneratorForm.refreshPassword();
                    });
                  },
                ),
                const Text(
                  'Todos os caracteres',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              child: Text(
                'Filtros',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black87,
                ),
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
                    value:
                        _passwordGeneratorForm.password.settings.hasUppercase,
                    onChanged: (bool? value) {
                      setState(() {
                        _passwordGeneratorForm.password.settings.hasUppercase =
                            value!;
                        _passwordGeneratorForm.refreshPassword();
                      });
                    }),
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
                    value:
                        _passwordGeneratorForm.password.settings.hasLowercase,
                    onChanged: (bool? value) {
                      setState(() {
                        _passwordGeneratorForm.password.settings.hasLowercase =
                            value!;
                        _passwordGeneratorForm.refreshPassword();
                      });
                    }),
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
                    value: _passwordGeneratorForm.password.settings.hasNumbers,
                    onChanged: _passwordGeneratorForm.disableNumbersOption()
                        ? null
                        : (bool? value) {
                            setState(() {
                              _passwordGeneratorForm
                                  .password.settings.hasNumbers = value!;
                              _passwordGeneratorForm.refreshPassword();
                            });
                          }),
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
                    value: _passwordGeneratorForm.password.settings.hasSymbols,
                    onChanged: _passwordGeneratorForm.disableSymbolsOption()
                        ? null
                        : (bool? value) {
                            setState(() {
                              _passwordGeneratorForm
                                  .password.settings.hasSymbols = value!;
                              _passwordGeneratorForm.refreshPassword();
                            });
                          }),
                const Text(
                  'Símbolos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  child: Text(
                    'Senha gerada',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.blueAccent,
                  iconSize: 32,
                  onPressed: _copyToClipboard,
                  icon: const Icon(Icons.copy),
                ),
                IconButton(
                  color: Colors.blueAccent,
                  iconSize: 32,
                  onPressed: () => setState(() {
                    _passwordGeneratorForm.refreshPassword();
                  }),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: _passwordController.text.isEmpty
                  ? const Center(
                      child: Text(
                        "Selecione um dos filtros",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )
                  : TextField(
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
          ],
        ),
      ),
    );
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(
        ClipboardData(text: _passwordGeneratorForm.password.value));
  }
}
