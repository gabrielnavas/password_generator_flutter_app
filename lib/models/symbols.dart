import 'dart:math';

class Symbols {
  static const String _symbols = "!@#\$%^&*()_+-={}[]|\\:;\"\'<>,.?/";

  static String generateRandom() {
    final int index = Random().nextInt(_symbols.length);
    final String symbolSelected = _symbols[index];
    return symbolSelected;
  }
}
