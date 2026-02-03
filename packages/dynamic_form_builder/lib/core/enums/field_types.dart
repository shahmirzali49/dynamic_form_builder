enum FieldType {
  text('text'),
  multiline('multiline'),
  number('number'),
  dropdown('dropdown'),
  checkbox('checkbox'),
  date('date'),
  radio('radio'),
  slider('slider'),
  phone('phone');

  final String fieldName;
  const FieldType(this.fieldName);

  static FieldType fromFieldName(String fieldName) {
    return FieldType.values.firstWhere(
      (e) => e.fieldName == fieldName,
      orElse: () {
        throw Exception('Invalid field type: $fieldName');
      },
    );
  }
}
