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
  if (!getIt.isRegistered<ThemeCubit>()) {
    getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  }

  if (!getIt.isRegistered<FormDatasource>()) {
    getIt.registerLazySingleton<FormDatasource>(() => FormDatasourceImpl());
  }
  if (!getIt.isRegistered<FormRepository>()) {
    getIt.registerLazySingleton<FormRepository>(
      () => FormRepositoryImpl(getIt<FormDatasource>()),
    );
  }

  if (!getIt.isRegistered<LoadFormUseCase>()) {
    getIt.registerLazySingleton<LoadFormUseCase>(
      () => LoadFormUseCase(getIt<FormRepository>()),
    );
  }
  if (!getIt.isRegistered<ApplyRulesAndValidateUseCase>()) {
    getIt.registerLazySingleton<ApplyRulesAndValidateUseCase>(
      () => ApplyRulesAndValidateUseCase(),
    );
  }
  if (!getIt.isRegistered<GetSubmissionPayloadUseCase>()) {
    getIt.registerLazySingleton<GetSubmissionPayloadUseCase>(
      () => GetSubmissionPayloadUseCase(),
    );
  }
  if (!getIt.isRegistered<FormCubit>()) {
    // Per-screen state holder: every request gets a fresh Cubit instance.
    getIt.registerFactory<FormCubit>(
      () => FormCubit(
        getIt<LoadFormUseCase>(),
        getIt<ApplyRulesAndValidateUseCase>(),
        getIt<GetSubmissionPayloadUseCase>(),
      ),
    );
  }
}
