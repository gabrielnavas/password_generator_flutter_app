import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/models/password.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  final TextEditingController _passwordController = TextEditingController();

  late Password _password;

  @override
  void initState() {
    super.initState();
    _initPassword();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    _passwordController.text = _password.value;

    return Scaffold(
      resizeToAvoidBottomInset: false, //don't forget this!
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
                  _password.settings.length.toStringAsFixed(0),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(
                  width: widthScreen * .85,
                  child: Slider(
                    value: double.parse(
                        _password.settings.length.toStringAsFixed(2)),
                    max: 50,
                    divisions: 50,
                    label: _password.settings.length.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _password.settings.length = value.toInt();
                        _refreshPassword();
                      });
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
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
                    value: _password.settings.hasUppercase,
                    onChanged: (bool? value) {
                      setState(() => _password.settings.hasUppercase = value!);
                      _refreshPassword();
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
                    value: _password.settings.hasLowercase,
                    onChanged: (bool? value) {
                      setState(() => _password.settings.hasLowercase = value!);
                      _refreshPassword();
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
                    value: _password.settings.hasNumbers,
                    onChanged: (bool? value) {
                      setState(() => _password.settings.hasNumbers = value!);
                      _refreshPassword();
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
                    value: _password.settings.hasSymbols,
                    onChanged: (bool? value) {
                      setState(() => _password.settings.hasSymbols = value!);
                      _refreshPassword();
                    }),
                const Text(
                  'Símbolos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  child: Text(
                    'Senha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  onPressed: _copyToClipboard,
                  icon: const Icon(Icons.copy),
                ),
                IconButton(
                  iconSize: 32,
                  onPressed: _refreshPassword,
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
    await Clipboard.setData(ClipboardData(text: _password.value));
  }

  void _initPassword() {
    setState(() {
      _password = Password(
        length: 20,
        hasUppercase: true,
        hasLowercase: true,
        hasNumbers: true,
        hasSymbols: false,
      );
    });
  }

  void _refreshPassword() {
    setState(() {
      _password = _password.clone();
    });
  }
}
