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

    // test/string_calculator_test.dart
    test('should return sum for two comma separated numbers', () {
      expect(calculator.add('1,5'), equals(6));
      expect(calculator.add('2,3'), equals(5));
    });

    test('should handle multiple numbers', () {
      expect(calculator.add('1,2,3,4,5'), equals(15));
      expect(calculator.add('10,20,30'), equals(60));
    });

    test('should handle new lines between numbers', () {
      expect(calculator.add('1\n2,3'), equals(6));
      expect(calculator.add('1,2\n3'), equals(6));
    });

    test('should support custom delimiters', () {
      expect(calculator.add('//;\n1;2'), equals(3));
      expect(calculator.add('//|\n1|2|3'), equals(6));
    });
  });
}
