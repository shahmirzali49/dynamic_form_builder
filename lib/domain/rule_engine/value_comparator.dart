class ValueComparator {
  ValueComparator._();

  static bool compare({
    required dynamic actualValue,
    required String operator,
    required dynamic expectedValue,
  }) {
    switch (operator) {
      case '==':
        return _equals(actualValue, expectedValue);
      case '!=':
        return !_equals(actualValue, expectedValue);
      case '>':
        return _numericCompare(actualValue, expectedValue, (a, b) => a > b);
      case '>=':
        return _numericCompare(actualValue, expectedValue, (a, b) => a >= b);
      case '<':
        return _numericCompare(actualValue, expectedValue, (a, b) => a < b);
      case '<=':
        return _numericCompare(actualValue, expectedValue, (a, b) => a <= b);
      case 'in':
        return _valueInList(actualValue, expectedValue);
      case 'contains':
        return _stringContains(actualValue, expectedValue);
      default:
        return false;
    }
  }

  static bool _equals(dynamic a, dynamic b) {
    if (a == b) return true;
    if (a == null || b == null) return false;
    if (a is num && b is num) return a == b;
    if (a is bool && b is bool) return a == b;
    final aStr = a.toString().trim();
    final bStr = b.toString().trim();
    return aStr == bStr;
  }

  static bool _numericCompare(
    dynamic actual,
    dynamic expected,
    bool Function(num, num) compare,
  ) {
    final numActual = _toNum(actual);
    final numExpected = _toNum(expected);
    if (numActual == null || numExpected == null) return false;
    return compare(numActual, numExpected);
  }

  static num? _toNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    final trimmed = value.toString().trim();
    return num.tryParse(trimmed);
  }

  static bool _valueInList(dynamic actual, dynamic expected) {
    if (expected is! List) return false;
    for (final item in expected) {
      if (_equals(actual, item)) return true;
    }
    return false;
  }

  static bool _stringContains(dynamic actual, dynamic expected) {
    if (expected == null) return false;
    final actualStr = actual?.toString() ?? '';
    final expectedStr = expected.toString();
    return actualStr.contains(expectedStr);
  }
}
