import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';

class DropdownFieldBuilder extends StatelessWidget {
  const DropdownFieldBuilder({
    super.key,
    required this.field,
    required this.options,
    required this.value,
    required this.error,
    required this.onChanged,
  });

  final FieldEntity field;
  final List<String> options;
  final String value;
  final String? error;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: field.label, errorText: error),
      items: options
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: options.isEmpty ? null : onChanged,
    );
  }
}
