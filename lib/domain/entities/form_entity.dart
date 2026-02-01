import 'field_entity.dart';
import 'rule_entity.dart';

class FormEntity {
  final String formId;
  final String title;
  final int version;
  final List<FieldEntity> fields;
  final List<RuleEntity> rules;

  const FormEntity({
    required this.formId,
    required this.title,
    required this.version,
    required this.fields,
    required this.rules,
  });
}
