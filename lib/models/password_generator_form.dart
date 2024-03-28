import 'package:password_generator/models/password.dart';
import 'package:password_generator/models/password_settings.dart';

enum PasswordType { allCharacters, easyToRead, easyToSay }

class PasswordGeneratorForm {
  Password password = Password();

  PasswordType passwordType = PasswordType.allCharacters;

  void changeLengthPassword(int length) {
    password.changeLengthPassword(length);
  }

  void changeTypePassword(PasswordType type) {
    passwordType = type;
    if (passwordType == PasswordType.allCharacters) {
      password.settings.allCharactersPasswordType();
    } else if (passwordType == PasswordType.easyToSay) {
      password.settings.easyToSay();
    } else if (passwordType == PasswordType.easyToRead) {
      password.settings.easyToRead();
    }
  }

  void refreshPassword() {
    final PasswordSettings settings = password.settings;
    password = Password(
      length: settings.length,
      hasUppercase: settings.hasUppercase,
      hasLowercase: settings.hasLowercase,
      hasNumbers: settings.hasNumbers,
      hasSymbols: settings.hasSymbols,
    );
  }

  bool disableNumbersOption() {
    return passwordType == PasswordType.easyToSay;
  }

  bool disableSymbolsOption() {
    return passwordType == PasswordType.easyToSay ||
        passwordType == PasswordType.easyToRead;
  }
}
