/// A calculator that performs addition operations on strings containing numbers
/// with various delimiter patterns.
///
/// This calculator supports:
/// - Basic comma-separated numbers
/// - Custom delimiters
/// - Multiple delimiters of varying lengths
/// - Number filtering (ignores numbers > 1000)
/// - Negative number detection
class StringCalculator {
  /// {@macro string_calculator}
  const StringCalculator();

  /// Adds numbers from a string input based on specified delimiters.
  ///
  /// The input string can be in following formats:
  /// - Empty string: Returns 0
  /// - Simple numbers: "1,2,3" returns 6
  /// - Custom delimiter: "//;\n1;2;3" returns 6
  /// - Multiple delimiters: "//[*][\%]\n1*2%3" returns 6
  /// - Variable length delimiters: "//[***]\n1***2***3" returns 6
  ///
  /// Numbers greater than 1000 are ignored in the sum.
  ///
  /// Throws [ArgumentError] if negative numbers are found.
  ///
  /// Example:
  /// ```dart
  /// final calculator = StringCalculator();
  /// print(calculator.add("1,2,3")); // Outputs: 6
  /// print(calculator.add("//[*][%]\n1*2%3")); // Outputs: 6
  /// ```
  ///
  /// @param numbers The input string containing numbers and delimiters
  /// @return The sum of all valid numbers in the string
  /// @throws ArgumentError if negative numbers are present
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

  /// Parses the input string to extract delimiters and numbers.
  ///
  /// Handles multiple formats of delimiter specifications:
  /// - Single delimiter: "//;\n1;2;3"
  /// - Multiple delimiters: "//[*][\%]\n1*2%3"
  /// - Variable length delimiters: "//[***]\n1***2***3"
  ///
  /// The delimiter section must start with "//" and end with "\n".
  ///
  /// Example:
  /// ```dart
  /// var result = _parseDelimitersAndNumbers("//[*][%]\n1*2%3");
  /// print(result.delimiters); // Outputs: [*, %]
  /// print(result.numbers); // Outputs: 1*2%3
  /// ```
  ///
  /// @param input The full input string including delimiter specification
  /// @return A [DelimiterParseResult] containing extracted delimiters
  /// and numbers
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

  /// Processes the numbers string with given delimiters and calculates the sum.
  ///
  /// This method:
  /// 1. Replaces all delimiters with a common delimiter (comma)
  /// 2. Splits the string into numbers
  /// 3. Filters out numbers greater than 1000
  /// 4. Checks for negative numbers
  /// 5. Calculates the sum
  ///
  /// Example:
  /// ```dart
  /// var sum = _sumNumbers("1*2%3", ['*', '%']);
  /// print(sum); // Outputs: 6
  /// ```
  ///
  /// @param numbersStr The string containing numbers
  /// @param delimiters List of delimiters to process
  /// @return The sum of all valid numbers
  /// @throws ArgumentError if negative numbers are found
  int _sumNumbers(String numbersStr, List<String> delimiters) {
    delimiters.add('\n');
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
        'negative numbers not allowed: ${negativeNumbers.join(", ")}',
      );
    }

    return parsedNumbers.reduce((a, b) => a + b);
  }
}

/// A container class for storing parsed delimiter information and numbers.
///
/// This class holds the results of parsing a string calculator input,
/// separating the delimiters from the actual numbers to be processed.
class DelimiterParseResult {
  /// Creates a new [DelimiterParseResult] instance.
  ///
  /// @param delimiters List of extracted delimiters
  /// @param numbers The remaining string containing numbers
  DelimiterParseResult(this.delimiters, this.numbers);

  /// List of extracted delimiters
  final List<String> delimiters;

  /// The remaining string containing only numbers and delimiters
  final String numbers;
}
