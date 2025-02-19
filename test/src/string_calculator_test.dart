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

    test('should throw exception for negative numbers', () {
      expect(
        () => calculator.add('-1,2'),
        throwsA(
          predicate(
            (e) =>
                e is ArgumentError &&
                e.message == 'negative numbers not allowed: -1',
          ),
        ),
      );
    });

    test('should show all negative numbers in exception message', () {
      expect(
        () => calculator.add('-1,-2,3,-4'),
        throwsA(
          predicate(
            (e) =>
                e is ArgumentError &&
                e.message == 'negative numbers not allowed: -1, -2, -4',
          ),
        ),
      );
    });

    test('should ignore numbers greater than 1000', () {
      expect(calculator.add('2,1001'), equals(2));
      expect(calculator.add('1000,2'), equals(1002)); // 1000 is still valid
      expect(calculator.add('1001,2,3,1002,4'), equals(9)); // only sum 2,3,4
    });

    test('should handle delimiters of any length', () {
      expect(calculator.add('//[***]\n1***2***3'), equals(6));
      expect(calculator.add('//[####]\n1####2####3'), equals(6));
      expect(calculator.add('//[&&&&]\n1&&&&2&&&&3'), equals(6));
    });

    test('should handle multiple delimiters', () {
      expect(calculator.add('//[*][%]\n1*2%3'), equals(6));
      expect(calculator.add('//[*][#]\n1*2#3'), equals(6));
    });

    test('should handle all delimiter combinations', () {
      expect(calculator.add('//[***][#][%]\n1***2#3%4'), equals(10));
      expect(calculator.add('//[##][!!!][@@]\n1##2!!!3@@4'), equals(10));
      expect(calculator.add('//[*][%%][###]\n1*2%%3###4'), equals(10));
      expect(calculator.add('//[***][###]\n1001***2###3'), equals(5));
    });
  });
}
