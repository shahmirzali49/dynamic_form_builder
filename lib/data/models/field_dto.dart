import 'package:dynamic_form_builer/core/enums/field_types.dart';
import 'package:dynamic_form_builer/domain/entities/field_entity.dart';

class FieldDto {
  final String id;
  final String label;
  final String type;
  final bool required;
  final dynamic defaultValue;
  final List<dynamic>? options;
  final Map<String, dynamic> validators;

  const FieldDto({
    required this.id,
    required this.label,
    required this.type,
    required this.required,
    this.defaultValue,
    this.options,
    this.validators = const {},
  });

  factory FieldDto.fromJson(Map<String, dynamic> json) {
    return FieldDto(
      id: json['id'] as String,
      label: json['label'] as String,
      type: json['type'] as String,
      required: json['required'] as bool,
      defaultValue: json['defaultValue'],
      options: json['options'] as List<dynamic>?,
      validators: (json['validators'] as Map<String, dynamic>?) ?? {},
    );
  }

  FieldEntity toEntity() {
    return FieldEntity(
      id: id,
      label: label,
      type: FieldType.fromFieldName(type),
      required: required,
      defaultValue: defaultValue,
      options: (options ?? []).map((e) => e.toString()).toList(),
      validators: validators,
    );
  }
}
