// ignore_for_file: prefer_const_constructors
import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  late StringCalculator calculator;

  setUp(() {
    calculator = StringCalculator();
  });

  group('String Calculator', () {
    test('should return 0 for empty string', () {
      expect(calculator.add(''), equals(0));
    });

    test('should return number for single number string', () {
      expect(calculator.add('1'), equals(1));
      expect(calculator.add('5'), equals(5));
    });
  });
}
