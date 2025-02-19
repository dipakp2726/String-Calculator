/// {@template string_calculator}
/// String calculator with TDD
/// {@endtemplate}
class StringCalculator {
  /// {@macro string_calculator}
  const StringCalculator();

  /// Adds the numbers in the given string.
  ///
  /// The string can contain numbers separated by commas. If the string is
  /// empty, the method returns 0. If the string contains a single number,
  /// it returns that number. The method also handles newlines as delimiters.
  /// Additionally, a custom delimiter can be specified at the beginning of
  /// the string in the format `//<delimiter>\n<numbers>`.
  ///
  /// @param numbers The string containing numbers separated by commas,
  /// newlines, or a custom delimiter.
  /// @return The sum of the numbers in the string.
  /// @throws ArgumentError if the string contains negative numbers.class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    var numbersToProcess = numbers;
    var delimiter = ',';

    if (numbers.startsWith('//')) {
      final firstNewLine = numbers.indexOf('\n');
      final delimiterSection = numbers.substring(2, firstNewLine);

      if (delimiterSection.startsWith('[') && delimiterSection.endsWith(']')) {
        delimiter = delimiterSection.substring(1, delimiterSection.length - 1);
      } else {
        delimiter = delimiterSection;
      }

      numbersToProcess = numbers.substring(firstNewLine + 1);
    }

    final parsedNumbers = numbersToProcess
        .replaceAll('\n', delimiter)
        .split(delimiter)
        .map((str) => int.parse(str.trim()))
        .where((number) => number <= 1000)
        .toList();

    final negativeNumbers = parsedNumbers.where((n) => n < 0).toList();
    if (negativeNumbers.isNotEmpty) {
      throw ArgumentError(
          'negative numbers not allowed: ${negativeNumbers.join(", ")}');
    }

    return parsedNumbers.reduce((a, b) => a + b);
  }
}
