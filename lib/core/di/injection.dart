import 'package:dynamic_form_builder/core/theme/theme_cubit.dart';
import 'package:dynamic_form_builder/data/datasources/form_datasource.dart';
import 'package:dynamic_form_builder/data/repositories/form_repository_impl.dart';
import 'package:dynamic_form_builder/domain/repositories/form_repository.dart';
import 'package:dynamic_form_builder/domain/usecases/apply_rules_and_validate_use_case.dart';
import 'package:dynamic_form_builder/domain/usecases/get_submission_payload_use_case.dart';
import 'package:dynamic_form_builder/domain/usecases/load_form_use_case.dart';
import 'package:dynamic_form_builder/presentation/cubit/form_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjection() {
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  getIt.registerLazySingleton<FormDatasource>(() => FormDatasourceImpl());
  getIt.registerLazySingleton<FormRepository>(
    () => FormRepositoryImpl(getIt<FormDatasource>()),
  );

  getIt.registerLazySingleton<LoadFormUseCase>(
    () => LoadFormUseCase(getIt<FormRepository>()),
  );
  getIt.registerLazySingleton<ApplyRulesAndValidateUseCase>(
    () => ApplyRulesAndValidateUseCase(),
  );
  getIt.registerLazySingleton<GetSubmissionPayloadUseCase>(
    () => GetSubmissionPayloadUseCase(),
  );
  getIt.registerLazySingleton<FormCubit>(
    () => FormCubit(
      getIt<LoadFormUseCase>(),
      getIt<ApplyRulesAndValidateUseCase>(),
      getIt<GetSubmissionPayloadUseCase>(),
    ),
  );
}
