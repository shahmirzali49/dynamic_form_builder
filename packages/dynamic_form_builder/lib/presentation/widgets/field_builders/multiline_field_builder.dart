import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';

class MultilineFieldBuilder extends StatelessWidget {
  const MultilineFieldBuilder({
    super.key,
    required this.field,
    required this.value,
    required this.error,
    required this.onChanged,
  });

  final FieldEntity field;
  final String value;
  final String? error;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: field.label,
        errorText: error,
        alignLabelWithHint: true,
      ),
      onChanged: onChanged,
      maxLines: 4,
      maxLength: field.validators['maxLength'] as int?,
    );
  }
}
