
class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult({required this.isValid, this.errorMessage});

  static const valid = ValidationResult(isValid: true);
  static ValidationResult invalid(String message) =>
      ValidationResult(isValid: false, errorMessage: message);
}
