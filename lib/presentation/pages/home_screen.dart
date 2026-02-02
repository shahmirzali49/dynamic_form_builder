import 'package:dynamic_form_builer/core/constants/app_constants.dart';
import 'package:dynamic_form_builer/core/extensions/context_extensions.dart';
import 'package:dynamic_form_builer/core/navigation/app_router.dart';
import 'package:dynamic_form_builer/core/ui/widgets/theme_toggle_button.dart';
import 'package:dynamic_form_builer/presentation/widgets/form_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = context.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 2,
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            surfaceTintColor: colorScheme.primary.withValues(alpha: 0.08),
            actions: const [ThemeToggleButton()],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                AppConstants.appTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: false,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a form',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...AppConstants.forms.asMap().entries.map((entry) {
                    final index = entry.key;
                    final formInfo = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < AppConstants.forms.length - 1 ? 12 : 0,
                      ),
                      child: FormCard(
                        title: formInfo.title,
                        subtitle: 'Load form from ${formInfo.assetPath}',
                        onTap: () =>
                            context.push(AppRouter.formPath(formInfo.urlName)),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
