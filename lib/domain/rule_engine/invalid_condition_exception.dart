class InvalidConditionException implements Exception {
  final String message;

  InvalidConditionException(this.message);

  @override
  String toString() => 'InvalidConditionException: $message';
}
