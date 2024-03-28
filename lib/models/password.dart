import 'dart:math';

import 'package:password_generator/models/password_settings.dart';

class Password {
  late PasswordSettings settings;

  String _value = "";

  Password({
    int length = 20,
    bool hasUppercase = false,
    bool hasLowercase = false,
    bool hasNumbers = false,
    bool hasSymbols = false,
  }) {
    settings = PasswordSettings(
      length: length,
      hasUppercase: hasUppercase,
      hasLowercase: hasLowercase,
      hasNumbers: hasNumbers,
      hasSymbols: hasSymbols,
    );
    _generate();
  }

  void changeLengthPassword(int length) {
    settings.length = length;
  }

  Password clone() {
    return Password(
      length: settings.length,
      hasUppercase: settings.hasUppercase,
      hasLowercase: settings.hasLowercase,
      hasNumbers: settings.hasNumbers,
      hasSymbols: settings.hasSymbols,
    );
  }

  String get value => _value;

  void _generate() {
    List<Function> functionsGenerators = settings.functionsGenerator();
    if (functionsGenerators.isEmpty) {
      return;
    }

    String password = "";
    for (int i = 0; i < settings.length; i++) {
      int randomFunctionGenerator =
          Random().nextInt(functionsGenerators.length);
      final function = functionsGenerators[randomFunctionGenerator];
      String chr = function().toString();
      password += chr;
    }

    _value = password;
  }
}
