import 'package:dynamic_form_builder/core/ui/screens/not_found_screen.dart';
import 'package:dynamic_form_builder/core/utils/form_utils.dart';
import 'package:dynamic_form_builder/presentation/screens/form_screen.dart';
import 'package:dynamic_form_builder/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

/// Declares app routes: home and dynamic form by URL name (form name must exist in AppConstants).
class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String form = '/form/:formName';

  static String formPath(String formName) => '/form/$formName';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    // debugLogDiagnostics: true,
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
          // Unknown form name shows not-found instead of crashing.
          if (assetPath == null) {
            return NotFoundScreen(formName: formName);
          }
          return FormScreen(assetPath: assetPath);
        },
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundScreen(message: state.uri.toString()),
  );
}
