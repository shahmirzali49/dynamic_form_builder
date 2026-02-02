import 'package:dynamic_form_builer/core/constants/app_constants.dart';
import 'package:dynamic_form_builer/core/extensions/context_extensions.dart';
import 'package:dynamic_form_builer/core/models/form_info.dart';
import 'package:dynamic_form_builer/core/navigation/app_router.dart';
import 'package:dynamic_form_builer/core/ui/widgets/theme_toggle_button.dart';
import 'package:dynamic_form_builer/presentation/widgets/form_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _formTitle(FormInfo formInfo, dynamic locale) {
    switch (formInfo.urlName) {
      case 'customer_onboarding':
        return locale.formTitleNewConnectionRequest;
      case 'travel_request':
        return locale.formTitleTravelRequest;
      case 'feedback_and_registration':
        return locale.formTitleFeedbackRegistration;
      default:
        return formInfo.title;
    }
  }

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
                context.locale.appTitle,
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
                    context.locale.selectAForm,
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
                        title: _formTitle(formInfo, context.locale),
                        subtitle: context.locale.loadFormFrom(
                          formInfo.assetPath,
                        ),
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
