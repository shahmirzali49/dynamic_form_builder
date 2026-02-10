import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';

class RadioFieldBuilder extends StatelessWidget {
  const RadioFieldBuilder({
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
    return InputDecorator(
      decoration: InputDecoration(labelText: field.label, errorText: error),
      child: RadioGroup<String>(
        groupValue: value.isEmpty ? null : value,
        onChanged: onChanged,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((o) => RadioListTile<String>(title: Text(o), value: o))
              .toList(),
        ),
      ),
    );
  }
}
