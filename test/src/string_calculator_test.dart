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
  });
}
