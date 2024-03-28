import 'dart:math';

class Abc {
  static const String _abc = "abcdefghijklmnopqrstuvwxyz";

  static String generateLowercase() {
    final int index = Random().nextInt(_abc.length);
    final String abcSelected = _abc[index];
    return abcSelected;
  }

  static String generateUppercase() {
    final int index = Random().nextInt(_abc.length);
    final String abcSelected = _abc[index];
    final String abcUppercase = abcSelected.toUpperCase();
    return abcUppercase;
  }
}
