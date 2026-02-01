import 'package:dynamic_form_builer/core/enums/field_types.dart';

class FieldEntity {
  final String id;
  final String label;
  final FieldType type;
  final bool required;
  final dynamic defaultValue;
  final List<String> options;
  final Map<String, dynamic> validators;

  const FieldEntity({
    required this.id,
    required this.label,
    required this.type,
    this.required = false,
    this.defaultValue,
    this.options = const [],
    this.validators = const {},
  });
}
