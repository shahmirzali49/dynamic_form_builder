import 'package:dynamic_form_builer/core/enums/field_types.dart';
import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:dynamic_form_builer/domain/entities/rule_entity.dart';
import 'package:dynamic_form_builer/domain/rule_engine/rule_applier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<FieldEntity> fields;

  setUp(() {
    fields = [
      const FieldEntity(
        id: 'accountType',
        label: 'Account Type',
        type: FieldType.dropdown,
      ),
      const FieldEntity(
        id: 'companyName',
        label: 'Company',
        type: FieldType.text,
      ),
    ];
  });

  group('RuleApplier', () {
    test(
      'initial result has all fields visible and required from field definition',
      () {
        final result = RuleApplier.apply([], fields, {});

        expect(result.visibility['accountType'], true);
        expect(result.visibility['companyName'], true);
        expect(result.requiredFlags['accountType'], false);
        expect(result.requiredFlags['companyName'], false);
      },
    );

    test(
      'when condition is true applies then actions (setvisible, setrequired)',
      () {
        final rules = [
          RuleEntity(
            id: 'show_company',
            when: ConditionEntity(
              fieldId: 'accountType',
              operator: '==',
              value: 'Business',
            ),
            then: [
              ActionEntity(
                action: 'setvisible',
                targetFieldId: 'companyName',
                value: true,
              ),
              ActionEntity(
                action: 'setrequired',
                targetFieldId: 'companyName',
                value: true,
              ),
            ],
            elseActions: [
              ActionEntity(
                action: 'setvisible',
                targetFieldId: 'companyName',
                value: false,
              ),
              ActionEntity(
                action: 'setrequired',
                targetFieldId: 'companyName',
                value: false,
              ),
            ],
          ),
        ];

        final result = RuleApplier.apply(rules, fields, {
          'accountType': 'Business',
        });

        expect(result.visibility['companyName'], true);
        expect(result.requiredFlags['companyName'], true);
      },
    );

    test('when condition is false applies else actions', () {
      final rules = [
        RuleEntity(
          id: 'show_company',
          when: ConditionEntity(
            fieldId: 'accountType',
            operator: '==',
            value: 'Business',
          ),
          then: [
            ActionEntity(
              action: 'setvisible',
              targetFieldId: 'companyName',
              value: true,
            ),
          ],
          elseActions: [
            ActionEntity(
              action: 'setvisible',
              targetFieldId: 'companyName',
              value: false,
            ),
          ],
        ),
      ];

      final result = RuleApplier.apply(rules, fields, {
        'accountType': 'Personal',
      });

      expect(result.visibility['companyName'], false);
    });

    test('setvalue updates result.values', () {
      final rules = [
        RuleEntity(
          id: 'set_default',
          when: ConditionEntity(
            fieldId: 'accountType',
            operator: '==',
            value: 'Business',
          ),
          then: [
            ActionEntity(
              action: 'setvalue',
              targetFieldId: 'companyName',
              value: 'ACME',
            ),
          ],
          elseActions: const [],
        ),
      ];

      final result = RuleApplier.apply(rules, fields, {
        'accountType': 'Business',
      });

      expect(result.values['companyName'], 'ACME');
    });

    test('setoptions updates result.options', () {
      final rules = [
        RuleEntity(
          id: 'set_opts',
          when: ConditionEntity(
            fieldId: 'accountType',
            operator: '==',
            value: 'Business',
          ),
          then: [
            ActionEntity(
              action: 'setoptions',
              targetFieldId: 'companyName',
              value: ['A', 'B', 'C'],
            ),
          ],
          elseActions: const [],
        ),
      ];

      final result = RuleApplier.apply(rules, fields, {
        'accountType': 'Business',
      });

      expect(result.options['companyName'], ['A', 'B', 'C']);
    });

    test('currentValues are copied into result.values', () {
      final result = RuleApplier.apply([], fields, {
        'accountType': 'Personal',
        'other': 42,
      });

      expect(result.values['accountType'], 'Personal');
      expect(result.values['other'], 42);
    });
  });
}
