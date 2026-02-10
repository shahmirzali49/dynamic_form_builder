import 'package:dynamic_form_builder/core/extensions/context_extensions.dart';
import 'package:dynamic_form_builder/core/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, this.message, this.formName});

  final String? message;
  final String? formName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final displayMessage =
        message ??
        (formName != null
            ? context.locale.formNotFound(formName!)
            : context.locale.pageNotFound);

    return Scaffold(
      appBar: AppBar(title: Text(context.locale.error)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              displayMessage,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go(AppRouter.home),
              icon: const Icon(Icons.home),
              label: Text(context.locale.goToHome),
            ),
          ],
        ),
      ),
    );
  }
}
