import 'package:dynamic_form_builder/core/enums/field_types.dart';
import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';

import 'field_builders/checkbox_field_builder.dart';
import 'field_builders/date_field_builder.dart';
import 'field_builders/dropdown_field_builder.dart';
import 'field_builders/multiline_field_builder.dart';
import 'field_builders/number_field_builder.dart';
import 'field_builders/phone_field_builder.dart';
import 'field_builders/radio_field_builder.dart';
import 'field_builders/slider_field_builder.dart';
import 'field_builders/text_field_builder.dart';

class DynamicField extends StatelessWidget {
  const DynamicField({
    super.key,
    required this.field,
    required this.value,
    required this.error,
    required this.options,
    required this.onChanged,
    this.onTouched,
  });

  final FieldEntity field;
  final dynamic value;
  final String? error;
  final List<String> options;
  final ValueChanged<dynamic> onChanged;
  final VoidCallback? onTouched;

  @override
  Widget build(BuildContext context) {
    final child = _DynamicFieldWidget(
      field: field,
      value: value,
      error: error,
      options: options,
      onChanged: onChanged,
    );
    // Date picker handles its own “touch”; for others we use focus loss to mark field as touched.
    if (onTouched != null && field.type != FieldType.date) {
      return Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) onTouched!();
        },
        child: child,
      );
    }
    return child;
  }
}

class _DynamicFieldWidget extends StatelessWidget {
  const _DynamicFieldWidget({
    required this.field,
    required this.value,
    required this.error,
    required this.options,
    required this.onChanged,
  });

  final FieldEntity field;
  final dynamic value;
  final String? error;
  final List<String> options;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    switch (field.type) {
      case FieldType.text:
        return TextFieldBuilder(
          field: field,
          value: value,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.multiline:
        return MultilineFieldBuilder(
          field: field,
          value: value,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.number:
        return NumberFieldBuilder(
          field: field,
          value: value,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.dropdown:
        return DropdownFieldBuilder(
          field: field,
          options: options,
          value: value,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.checkbox:
        return CheckboxFieldBuilder(
          field: field,
          value: value == true,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.date:
        return DateFieldBuilder(
          field: field,
          value: value,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.radio:
        return RadioFieldBuilder(
          field: field,
          options: options,
          value: value,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.slider:
        final numVal = value is num ? value : 0;
        return SliderFieldBuilder(
          field: field,
          value: numVal,
          error: error,
          onChanged: onChanged,
        );
      case FieldType.phone:
        return PhoneFieldBuilder(
          field: field,
          value: value,
          error: error,
          onChanged: onChanged,
        );
    }
  }
}
