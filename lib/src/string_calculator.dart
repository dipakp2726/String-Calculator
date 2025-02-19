/// {@template string_calculator}
/// String calculator with TDD
/// {@endtemplate}
class StringCalculator {
  /// {@macro string_calculator}
  const StringCalculator();

  /// Adds the numbers in the given string.
  ///
  /// @param numbers The string containing numbers separated by commas.
  /// @return The sum of the numbers in the string.
  int add(String numbers) {
    if (numbers.isEmpty) return 0;
    return int.parse(numbers);
  }
}
