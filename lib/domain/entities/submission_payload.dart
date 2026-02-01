class SubmissionPayload {
  const SubmissionPayload({
    required this.formId,
    required this.version,
    required this.submittedAt,
    required this.values,
  });

  final String formId;
  final int version;
  final String submittedAt;
  final Map<String, dynamic> values;

  Map<String, dynamic> toJson() => {
    'formId': formId,
    'version': version,
    'submittedAt': submittedAt,
    'values': values,
  };
}
