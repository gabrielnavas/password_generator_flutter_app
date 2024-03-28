import 'dart:math';

class Numbers {
  static const String _numbers = "0123456789";

  static int generateRandom() {
    final int index = Random().nextInt(_numbers.length);
    final String numberSelected = _numbers[index];
    return int.parse(numberSelected);
  }
}
