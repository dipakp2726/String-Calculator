# String Calculator

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

## Overview
The String Calculator is a Dart library that provides functionality for parsing and calculating sums from strings containing numbers with various delimiter patterns. This implementation follows Test-Driven Development (TDD) principles and supports multiple advanced features including custom delimiters, number filtering, and error handling.
## Features
The String Calculator supports the following features:
### Basic Operations

- Empty string handling (returns 0)
- Single number processing
- Multiple number addition
- Negative number detection and error reporting

### Advanced Features

- Numbers greater than 1000 are ignored in calculations
- Custom delimiter support using the format "//[delimiter]\n"
- Multiple delimiter support using the format "//[delim1][delim2]\n"
- Variable-length delimiter support
- Newline character as an alternative delimiter


## Installation 💻

Install via `dart pub add`:

```sh
dart pub add string_calculator
```

## Running Tests 🧪

To run all unit tests:

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis