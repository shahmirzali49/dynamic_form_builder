import 'package:dynamic_form_builder/presentation/cubit/form_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormState.copyWith', () {
    test('can explicitly clear loadError with null', () {
      const initial = FormState(loadError: 'Load failed');
      final updated = initial.copyWith(loadError: null);
      expect(updated.loadError, isNull);
    });

    test('keeps loadError unchanged when omitted', () {
      const initial = FormState(loadError: 'Load failed');
      final updated = initial.copyWith(isLoading: true);
      expect(updated.loadError, 'Load failed');
    });
  });
}
