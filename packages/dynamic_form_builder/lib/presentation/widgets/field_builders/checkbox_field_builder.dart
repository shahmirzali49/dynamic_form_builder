import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';

class CheckboxFieldBuilder extends StatelessWidget {
  const CheckboxFieldBuilder({
    super.key,
    required this.field,
    required this.value,
    required this.error,
    required this.onChanged,
  });

  final FieldEntity field;
  final bool value;
  final String? error;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(errorText: error),
      child: CheckboxListTile(
        title: Text(field.label),
        value: value,
        onChanged: (v) => onChanged(v ?? false),
      ),
    );
  }
}
