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
  /// @throws ArgumentError if the string contains negative numbers.
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    var numbersToProcess = numbers;
    var delimiters = <String>[','];

    if (numbers.startsWith('//')) {
      final parseResult = _parseDelimitersAndNumbers(numbers);
      delimiters = parseResult.delimiters;
      numbersToProcess = parseResult.numbers;
    }

    return _sumNumbers(numbersToProcess, delimiters);
  }

  DelimiterParseResult _parseDelimitersAndNumbers(String input) {
    final firstNewLine = input.indexOf('\n');
    final delimiterSection = input.substring(2, firstNewLine);
    final numbers = input.substring(firstNewLine + 1);
    final delimiters = <String>[];

    if (delimiterSection.contains('[')) {
      final pattern = RegExp(r'\[(.*?)\]');
      final matches = pattern.allMatches(delimiterSection);

      for (final match in matches) {
        if (match.group(1) != null) {
          delimiters.add(match.group(1)!);
        }
      }
    } else {
      delimiters.add(delimiterSection);
    }

    return DelimiterParseResult(delimiters, numbers);
  }

  int _sumNumbers(String numbersStr, List<String> delimiters) {
    var processedNumbers = numbersStr;

    for (final delimiter in delimiters) {
      processedNumbers = processedNumbers.replaceAll(delimiter, ',');
    }

    final parsedNumbers = processedNumbers
        .split(',')
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

/// {@template DelimiterParseResult}
/// hold the result of parsing delimiters and numbers from a string.
/// {@endtemplate}
class DelimiterParseResult {
  /// {@macro DelimiterParseResult}
  DelimiterParseResult(this.delimiters, this.numbers);

  /// The list of delimiters extracted from the input string.
  final List<String> delimiters;

  /// The numbers part of the input string after removing the delimiter section.
  final String numbers;
}
