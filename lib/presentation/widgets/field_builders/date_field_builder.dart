import 'package:dynamic_form_builer/core/extensions/context_extensions.dart';
import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFieldBuilder extends StatelessWidget {
  const DateFieldBuilder({
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

  DateTime? get _parsedDate => value.isEmpty ? null : DateTime.tryParse(value);

  @override
  Widget build(BuildContext context) {
    final DateTime? date = _parsedDate;
    final display = date != null ? DateFormat.yMMMd().format(date) : '';
    return InkWell(
      onTap: () async {
        final firstDate = _parseDate(field.validators['dateMin'] as String);
        final lastDate = _parseDate(field.validators['dateMax'] as String);
        DateTime initial = date ?? DateTime.now();
        if (initial.isBefore(firstDate)) initial = firstDate;
        if (initial.isAfter(lastDate)) initial = lastDate;
        final picked = await showDatePicker(
          context: context,
          useRootNavigator: true,
          initialDate: initial,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (context.mounted && picked != null) {
          onChanged(DateFormat('yyyy-MM-dd').format(picked));
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: field.label,
          errorText: error,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(display.isEmpty ? context.locale.selectDate : display),
      ),
    );
  }

  DateTime _parseDate(String? s) {
    if (s == null || s.isEmpty) {
      throw ArgumentError(
        'Date string (dateMin/dateMax) cannot be null or empty',
      );
    }
    final result = DateTime.tryParse(s);
    if (result == null) {
      throw FormatException('Invalid date format: "$s"');
    }
    return result;
  }
}
