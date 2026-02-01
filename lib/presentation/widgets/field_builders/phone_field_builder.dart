import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PhoneFieldBuilder extends StatelessWidget {
  const PhoneFieldBuilder({
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
        prefixText: '+ ',
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d'))],
      onChanged: onChanged,
    );
  }
}
