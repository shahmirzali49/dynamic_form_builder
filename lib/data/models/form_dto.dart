import '../../domain/entities/form_entity.dart';
import 'field_dto.dart';
import 'rule_dto.dart';

class FormDto {
  final String formId;
  final String title;
  final int version;
  final List<FieldDto> fields;
  final List<RuleDto> rules;

  const FormDto({
    required this.formId,
    required this.title,
    required this.version,
    this.fields = const [],
    this.rules = const [],
  });

  factory FormDto.fromJson(Map<String, dynamic> json) {
    final fieldsList = json['fields'] as List<dynamic>? ?? [];
    final rulesList = json['rules'] as List<dynamic>? ?? [];
    return FormDto(
      formId: json['formId'] as String,
      title: json['title'] as String,
      version: (json['version'] as num).toInt(),
      fields: fieldsList
          .map((e) => FieldDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      rules: rulesList
          .map((e) => RuleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  FormEntity toEntity() {
    return FormEntity(
      formId: formId,
      title: title,
      version: version,
      fields: fields.map((dto) => dto.toEntity()).toList(),
      rules: rules.map((dto) => dto.toEntity()).toList(),
    );
  }
}
