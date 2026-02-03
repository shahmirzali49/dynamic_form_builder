import 'package:dynamic_form_builer/core/extensions/context_extensions.dart';
import 'package:dynamic_form_builer/core/ui/screens/not_found_screen.dart';
import 'package:dynamic_form_builer/core/ui/widgets/theme_toggle_button.dart';
import 'package:dynamic_form_builer/core/utils/form_utils.dart';
import 'package:dynamic_form_builer/presentation/screens/home_screen.dart';
import 'package:dynamic_form_builder/dynamic_form_builder.dart';
import 'package:go_router/go_router.dart';

/// Declares app routes: home and dynamic form by URL name (form name must exist in AppConstants).
class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String form = '/form/:formName';

  static String formPath(String formName) => '/form/$formName';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: form,
        name: 'form',
        builder: (context, state) {
          final formName = state.pathParameters['formName'];
          final assetPath = formName != null
              ? FormUtils.getAssetPathForFormName(formName)
              : null;
          if (assetPath == null) {
            return NotFoundScreen(formName: formName);
          }
          final locale = context.locale;
          final labels = DynamicFormLabels(
            formTitle: locale.form,
            loadingForm: locale.loadingForm,
            fillFieldsHint: locale.fillFieldsHint,
            submit: locale.submit,
            submissionOutput: locale.submissionOutput,
            back: locale.back,
            unknownError: locale.unknownError,
            selectDate: locale.selectDate,
          );
          return DynamicFormScreen(
            assetPath: assetPath,
            labels: labels,
            actions: const [ThemeToggleButton()],
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundScreen(message: state.uri.toString()),
  );
}
