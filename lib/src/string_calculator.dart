/// {@template string_calculator}
/// String calculator with TDD
/// {@endtemplate}
class StringCalculator {
  /// {@macro string_calculator}
  const StringCalculator();

  /// Adds the numbers in the given string.
  ///
  /// The string can contain numbers separated by commas.If the string is empty,
  /// the method returns 0. If the string contains a single number,
  /// it returns that number.
  ///
  /// @param numbers The string containing numbers separated by commas.
  /// @return The sum of the numbers in the string.
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    return numbers
        .split(',')
        .map(
          int.parse,
        )
        .reduce(
          (a, b) => a + b,
        );
  }
}
