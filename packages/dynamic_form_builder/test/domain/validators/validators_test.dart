import 'package:dynamic_form_builder/core/enums/field_types.dart';
import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:dynamic_form_builder/domain/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators (field validators)', () {
    group('required', () {
      test('returns invalid when required text field is empty', () {
        final field = FieldEntity(
          id: 'name',
          label: 'Name',
          type: FieldType.text,
          required: true,
          validators: {},
        );
        final result = Validators.validateField(field, null);
        expect(result.isValid, false);
        expect(result.errorMessage, 'This field is required');
      });

      test('returns valid when required text field has value', () {
        final field = FieldEntity(
          id: 'name',
          label: 'Name',
          type: FieldType.text,
          required: true,
          validators: {},
        );
        final result = Validators.validateField(field, 'Ali');
        expect(result.isValid, true);
      });

      test('returns invalid when required number field is empty', () {
        final field = FieldEntity(
          id: 'age',
          label: 'Age',
          type: FieldType.number,
          required: true,
          validators: {},
        );
        final result = Validators.validateField(field, null);
        expect(result.isValid, false);
        expect(result.errorMessage, 'This field is required');
      });
    });

    group('text validators', () {
      test('minLength returns invalid when below minimum', () {
        final field = FieldEntity(
          id: 'code',
          label: 'Code',
          type: FieldType.text,
          required: false,
          validators: {'minLength': 5},
        );
        final result = Validators.validateField(field, 'abc');
        expect(result.isValid, false);
        expect(result.errorMessage, 'Must be at least 5 characters');
      });

      test('minLength returns valid when at or above minimum', () {
        final field = FieldEntity(
          id: 'code',
          label: 'Code',
          type: FieldType.text,
          required: false,
          validators: {'minLength': 5},
        );
        expect(Validators.validateField(field, 'hello').isValid, true);
        expect(Validators.validateField(field, 'hello!').isValid, true);
      });

      test('maxLength returns invalid when above maximum', () {
        final field = FieldEntity(
          id: 'title',
          label: 'Title',
          type: FieldType.text,
          required: false,
          validators: {'maxLength': 10},
        );
        final result = Validators.validateField(field, 'hello Azercell');
        expect(result.isValid, false);
        expect(result.errorMessage, 'Must be at most 10 characters');
      });

      test('maxLength returns valid when at or below maximum', () {
        final field = FieldEntity(
          id: 'title',
          label: 'Title',
          type: FieldType.text,
          required: false,
          validators: {'maxLength': 10},
        );
        expect(Validators.validateField(field, 'hi').isValid, true);
        expect(Validators.validateField(field, '1234567890').isValid, true);
      });

      test('regex returns invalid when pattern does not match', () {
        final field = FieldEntity(
          id: 'email',
          label: 'Email',
          type: FieldType.text,
          required: false,
          validators: {'regex': r'^[\w\-\.]+@[\w\-]+\.\w+$'},
        );
        final result = Validators.validateField(field, 'not-an-email');
        expect(result.isValid, false);
        expect(result.errorMessage, 'Invalid format');
      });

      test('regex returns valid when pattern matches', () {
        final field = FieldEntity(
          id: 'email',
          label: 'Email',
          type: FieldType.text,
          required: false,
          validators: {'regex': r'^[\w\-\.]+@[\w\-]+\.\w+$'},
        );
        final result = Validators.validateField(field, 'ali@gmail.com');
        expect(result.isValid, true);
      });
    });

    group('number validators', () {
      test('min returns invalid when below minimum', () {
        final field = FieldEntity(
          id: 'age',
          label: 'Age',
          type: FieldType.number,
          required: false,
          validators: {'min': 18},
        );
        final result = Validators.validateField(field, 15);
        expect(result.isValid, false);
        expect(result.errorMessage, 'Must be at least 18');
      });

      test('max returns invalid when above maximum', () {
        final field = FieldEntity(
          id: 'score',
          label: 'Score',
          type: FieldType.number,
          required: false,
          validators: {'max': 100},
        );
        final result = Validators.validateField(field, 150);
        expect(result.isValid, false);
        expect(result.errorMessage, 'Must be at most 100');
      });

      test('integerOnly returns invalid for decimals', () {
        final field = FieldEntity(
          id: 'count',
          label: 'Count',
          type: FieldType.number,
          required: false,
          validators: {'integerOnly': true},
        );
        final result = Validators.validateField(field, 3.14);
        expect(result.isValid, false);
        expect(result.errorMessage, 'Must be a whole number');
      });

      test('integerOnly returns valid for whole numbers', () {
        final field = FieldEntity(
          id: 'count',
          label: 'Count',
          type: FieldType.number,
          required: false,
          validators: {'integerOnly': true},
        );
        expect(Validators.validateField(field, 42).isValid, true);
      });
    });

    group('date validators', () {
      test('dateMin returns invalid when before minimum', () {
        final field = FieldEntity(
          id: 'startDate',
          label: 'Start Date',
          type: FieldType.date,
          required: false,
          validators: {'dateMin': '2024-06-01'},
        );
        final result = Validators.validateField(field, '2024-01-15');
        expect(result.isValid, false);
        expect(result.errorMessage, contains('2024-06-01'));
      });

      test('dateMax returns invalid when after maximum', () {
        final field = FieldEntity(
          id: 'endDate',
          label: 'End Date',
          type: FieldType.date,
          required: false,
          validators: {'dateMax': '2024-12-31'},
        );
        final result = Validators.validateField(field, '2025-01-01');
        expect(result.isValid, false);
        expect(result.errorMessage, contains('2024-12-31'));
      });

      test('date within range returns valid', () {
        final field = FieldEntity(
          id: 'eventDate',
          label: 'Event Date',
          type: FieldType.date,
          required: false,
          validators: {'dateMin': '2024-01-01', 'dateMax': '2024-12-31'},
        );
        final result = Validators.validateField(field, '2024-06-15');
        expect(result.isValid, true);
      });
    });
  });
}
