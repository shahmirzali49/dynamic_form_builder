import 'package:dynamic_form_builer/core/theme/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjection() {
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
