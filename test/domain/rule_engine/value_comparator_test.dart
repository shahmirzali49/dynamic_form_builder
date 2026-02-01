import 'package:dynamic_form_builer/domain/rule_engine/value_comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValueComparator', () {
    group('==', () {
      test('same value returns true', () {
        expect(
          ValueComparator.compare(
            actualValue: 'Business',
            operator: '==',
            expectedValue: 'Business',
          ),
          true,
        );
      });

      test('int and string "1" are equal (trimmed string)', () {
        expect(
          ValueComparator.compare(actualValue: 1, operator: '==', expectedValue: '1'),
          true,
        );
      });

      test('1.0 and 1 are equal (num)', () {
        expect(
          ValueComparator.compare(actualValue: 1.0, operator: '==', expectedValue: 1),
          true,
        );
      });

      test('different values return false', () {
        expect(
          ValueComparator.compare(
            actualValue: 'Personal',
            operator: '==',
            expectedValue: 'Business',
          ),
          false,
        );
      });

      test('trimmed strings match', () {
        expect(
          ValueComparator.compare(
            actualValue: '  A  ',
            operator: '==',
            expectedValue: 'A',
          ),
          true,
        );
      });
    });

    group('!=', () {
      test('different values return true', () {
        expect(
          ValueComparator.compare(
            actualValue: 'A',
            operator: '!=',
            expectedValue: 'B',
          ),
          true,
        );
      });

      test('equal values return false', () {
        expect(
          ValueComparator.compare(
            actualValue: 'A',
            operator: '!=',
            expectedValue: 'A',
          ),
          false,
        );
      });
    });

    group('numeric (>, >=, <, <=)', () {
      test('> 5 and 3 returns true', () {
        expect(
          ValueComparator.compare(
            actualValue: 5,
            operator: '>',
            expectedValue: 3,
          ),
          true,
        );
      });

      test('> "10" and 5 (string parsed as num)', () {
        expect(
          ValueComparator.compare(
            actualValue: '10',
            operator: '>',
            expectedValue: 5,
          ),
          true,
        );
      });

      test('>= 5 and 5 returns true', () {
        expect(
          ValueComparator.compare(
            actualValue: 5,
            operator: '>=',
            expectedValue: 5,
          ),
          true,
        );
      });

      test('< 2 and 5 returns true', () {
        expect(
          ValueComparator.compare(
            actualValue: 2,
            operator: '<',
            expectedValue: 5,
          ),
          true,
        );
      });

      test('<= 3 and 3 returns true', () {
        expect(
          ValueComparator.compare(
            actualValue: 3,
            operator: '<=',
            expectedValue: 3,
          ),
          true,
        );
      });

      test('non-numeric returns false', () {
        expect(
          ValueComparator.compare(
            actualValue: 'abc',
            operator: '>',
            expectedValue: 5,
          ),
          false,
        );
      });
    });

    group('in', () {
      test('value in list returns true', () {
        expect(
          ValueComparator.compare(
            actualValue: 'Business',
            operator: 'in',
            expectedValue: ['Personal', 'Business'],
          ),
          true,
        );
      });

      test('value not in list returns false', () {
        expect(
          ValueComparator.compare(
            actualValue: 'Other',
            operator: 'in',
            expectedValue: ['Personal', 'Business'],
          ),
          false,
        );
      });

      test('int 1 in list ["1"] returns true (_equals coercion)', () {
        expect(
          ValueComparator.compare(
            actualValue: 1,
            operator: 'in',
            expectedValue: ['1', '2'],
          ),
          true,
        );
      });

      test('expected not a list returns false', () {
        expect(
          ValueComparator.compare(
            actualValue: 'A',
            operator: 'in',
            expectedValue: 'not a list',
          ),
          false,
        );
      });
    });

    group('contains', () {
      test('actual contains expected returns true', () {
        expect(
          ValueComparator.compare(
            actualValue: 'hello world',
            operator: 'contains',
            expectedValue: 'world',
          ),
          true,
        );
      });

      test('actual does not contain expected returns false', () {
        expect(
          ValueComparator.compare(
            actualValue: 'hello',
            operator: 'contains',
            expectedValue: 'xyz',
          ),
          false,
        );
      });

      test('null actual uses empty string', () {
        expect(
          ValueComparator.compare(
            actualValue: null,
            operator: 'contains',
            expectedValue: 'x',
          ),
          false,
        );
      });
    });

    group('unknown operator', () {
      test('returns false', () {
        expect(
          ValueComparator.compare(
            actualValue: 1,
            operator: '??',
            expectedValue: 1,
          ),
          false,
        );
      });
    });
  });
}
