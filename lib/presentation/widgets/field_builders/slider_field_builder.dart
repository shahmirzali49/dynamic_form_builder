import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:flutter/material.dart';


class SliderFieldBuilder extends StatelessWidget {
  const SliderFieldBuilder({
    super.key,
    required this.field,
    required this.value,
    required this.error,
    required this.onChanged,
  });

  final FieldEntity field;
  final num value;
  final String? error;
  final ValueChanged<num> onChanged;

  @override
  Widget build(BuildContext context) {
    final min = field.validators['min'] is num
        ? (field.validators['min'] as num).toDouble()
        : 0.0;
    final max = field.validators['max'] is num
        ? (field.validators['max'] as num).toDouble()
        : 100.0;
    final clamped = value.toDouble().clamp(min, max);
    return InputDecorator(
      decoration: InputDecoration(
        labelText: field.label,
        errorText: error,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            value: clamped,
            min: min,
            max: max,
            divisions: (max - min).clamp(1, 100).toInt(),
            onChanged: (v) => onChanged(v),
          ),
          Text(clamped.toStringAsFixed(0)),
        ],
      ),
    );
  }
}
