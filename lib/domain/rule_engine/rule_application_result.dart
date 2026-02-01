class RuleApplicationResult {
  final Map<String, bool> visibility;
  final Map<String, bool> requiredFlags;
  final Map<String, dynamic> values;
  final Map<String, List<String>> options;

  const RuleApplicationResult({
    required this.visibility,
    required this.requiredFlags,
    required this.values,
    required this.options,
  });

  RuleApplicationResult copyWith({
    Map<String, bool>? visibility,
    Map<String, bool>? requiredFlags,
    Map<String, dynamic>? values,
    Map<String, List<String>>? options,
  }) {
    return RuleApplicationResult(
      visibility: visibility ?? this.visibility,
      requiredFlags: requiredFlags ?? this.requiredFlags,
      values: values ?? this.values,
      options: options ?? this.options,
    );
  }

  @override
  String toString() {
    return '''RuleApplicationResult(visibility: $visibility, requiredFlags: $requiredFlags, values: $values, options: $options)''';
  }
}
