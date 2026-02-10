import 'package:dynamic_form_builder/core/di/injection.dart';
import 'package:dynamic_form_builder/domain/usecases/load_form_use_case.dart';
import 'package:dynamic_form_builder/presentation/cubit/form_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    setupInjection();
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('setupInjection', () {
    test('registers FormCubit as factory (new instance each resolve)', () {
      final first = getIt<FormCubit>();
      final second = getIt<FormCubit>();

      expect(identical(first, second), false);
      first.close();
      second.close();
    });

    test('keeps use cases as lazy singletons', () {
      final first = getIt<LoadFormUseCase>();
      final second = getIt<LoadFormUseCase>();

      expect(identical(first, second), true);
    });
  });
}
