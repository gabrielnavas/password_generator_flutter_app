import 'package:password_generator/models/abc.dart';
import 'package:password_generator/models/numbers.dart';
import 'package:password_generator/models/symbols.dart';

class PasswordSettings {
  late int _length;
  late bool _hasUppercase;
  late bool _hasLowercase;
  late bool _hasNumbers;
  late bool _hasSymbols;

  PasswordSettings({
    required length,
    required hasUppercase,
    required hasLowercase,
    required hasNumbers,
    required hasSymbols,
  }) {
    _length = length;
    _hasUppercase = hasUppercase;
    _hasLowercase = hasLowercase;
    _hasNumbers = hasNumbers;
    _hasSymbols = hasSymbols;
  }

  set hasUppercase(bool value) => _hasUppercase = value;
  bool get hasUppercase => _hasUppercase;

  set hasLowercase(bool value) => _hasLowercase = value;
  bool get hasLowercase => _hasLowercase;

  set hasNumbers(bool value) => _hasNumbers = value;
  bool get hasNumbers => _hasNumbers;

  set hasSymbols(bool value) => _hasSymbols = value;
  bool get hasSymbols => _hasSymbols;

  set length(int value) => _length = value;
  int get length => _length;

  void allCharactersPasswordType() {
    hasLowercase = true;
    hasUppercase = true;
    hasNumbers = true;
    hasSymbols = true;
  }

  void easyToSay() {
    hasLowercase = true;
    hasUppercase = true;
    hasNumbers = false;
    hasSymbols = false;
  }

  void easyToRead() {
    hasLowercase = true;
    hasUppercase = true;
    hasNumbers = true;
    hasSymbols = false;
  }

  List<Function> functionsGenerator() {
    List<dynamic Function()> functionsGenerators = [];
    if (_hasUppercase) {
      functionsGenerators.add(Abc.generateUppercase);
    }
    if (_hasLowercase) {
      functionsGenerators.add(Abc.generateLowercase);
    }
    if (_hasNumbers) {
      functionsGenerators.add(Numbers.generateRandom);
    }
    if (_hasSymbols) {
      functionsGenerators.add(Symbols.generateRandom);
    }
    return functionsGenerators;
  }
}
