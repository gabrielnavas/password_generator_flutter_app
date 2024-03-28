import 'package:password_generator/models/abc.dart';
import 'package:password_generator/models/numbers.dart';
import 'package:password_generator/models/symbols.dart';

class PasswordSettings {
  int length;
  bool hasUppercase;
  bool hasLowercase;
  bool hasNumbers;
  bool hasSymbols;

  PasswordSettings({
    required this.length,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumbers,
    required this.hasSymbols,
  });

  List<Function> functionsGenerator() {
    List<dynamic Function()> functionsGenerators = [];
    if (hasUppercase) {
      functionsGenerators.add(Abc.generateUppercase);
    }
    if (hasLowercase) {
      functionsGenerators.add(Abc.generateLowercase);
    }
    if (hasNumbers) {
      functionsGenerators.add(Numbers.generateRandom);
    }
    if (hasSymbols) {
      functionsGenerators.add(Symbols.generateRandom);
    }
    return functionsGenerators;
  }
}
