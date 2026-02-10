import 'dart:convert';

import 'package:dynamic_form_builder/core/enums/field_types.dart';
import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:dynamic_form_builder/domain/entities/form_entity.dart';
import 'package:dynamic_form_builder/domain/usecases/get_submission_payload_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GetSubmissionPayloadUseCase useCase;
  late FormEntity form;

  setUp(() {
    useCase = GetSubmissionPayloadUseCase();
    // Fields in non-alphabetical order to verify output is sorted
    form = FormEntity(
      formId: 'test_form',
      title: 'Test Form',
      version: 1,
      fields: const [
        FieldEntity(id: 'zebra', label: 'Zebra', type: FieldType.text),
        FieldEntity(id: 'alpha', label: 'Alpha', type: FieldType.text),
        FieldEntity(id: 'middle', label: 'Middle', type: FieldType.text),
      ],
      rules: const [],
    );
  });

  group('GetSubmissionPayloadUseCase', () {
    test('values keys are in deterministic sorted order', () {
      final visibility = <String, bool>{
        'zebra': true,
        'alpha': true,
        'middle': true,
      };
      final values = <String, dynamic>{
        'zebra': 'z',
        'alpha': 'a',
        'middle': 'm',
      };

      final payload = useCase.getSubmissionPayload(
        form: form,
        values: values,
        visibility: visibility,
      );

      final keys = payload.values.keys.toList();
      expect(keys, isNotEmpty);
      expect(keys, equals(['alpha', 'middle', 'zebra']));
    });

    test('only visible fields appear in values', () {
      final visibility = <String, bool>{
        'zebra': true,
        'alpha': false,
        'middle': true,
      };
      final values = <String, dynamic>{
        'zebra': 'z',
        'alpha': 'a',
        'middle': 'm',
      };

      final payload = useCase.getSubmissionPayload(
        form: form,
        values: values,
        visibility: visibility,
      );

      expect(payload.values.keys, containsAll(['middle', 'zebra']));
      expect(payload.values.keys, isNot(contains('alpha')));
      expect(payload.values.length, 2);
    });

    test('toJson produces identical output for same input (deterministic)', () {
      final visibility = <String, bool>{
        'zebra': true,
        'alpha': true,
        'middle': true,
      };
      final values = <String, dynamic>{
        'zebra': 'z',
        'alpha': 'a',
        'middle': 'm',
      };

      final payload1 = useCase.getSubmissionPayload(
        form: form,
        values: values,
        visibility: visibility,
      );
      final payload2 = useCase.getSubmissionPayload(
        form: form,
        values: values,
        visibility: visibility,
      );

      final json1 = payload1.toJson();
      final json2 = payload2.toJson();

      expect(json1['formId'], json2['formId']);
      expect(json1['version'], json2['version']);
      final values1 = json1['values'] as Map<String, dynamic>;
      final values2 = json2['values'] as Map<String, dynamic>;
      expect(values1.keys.toList(), values2.keys.toList());
      expect(jsonEncode(json1['values']), jsonEncode(json2['values']));
    });
  });
}
