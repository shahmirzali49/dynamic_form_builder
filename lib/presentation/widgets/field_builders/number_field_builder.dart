import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NumberFieldBuilder extends StatelessWidget {
  const NumberFieldBuilder({
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
    final integerOnly = field.validators['integerOnly'] as bool? ?? false;
    return TextFormField(
      initialValue: value.toString(),
      decoration: InputDecoration(
        labelText: field.label,
        errorText: error,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        if (integerOnly) FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: onChanged,
    );
  }
}
