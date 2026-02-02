import 'dart:convert';

import 'package:dynamic_form_builer/core/widgets/theme_toggle_button.dart';
import 'package:dynamic_form_builer/domain/usecases/apply_rules_and_validate_use_case.dart';
import 'package:dynamic_form_builer/domain/usecases/get_submission_payload_use_case.dart';
import 'package:dynamic_form_builer/domain/usecases/load_form_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/submission_payload.dart';
import '../../domain/repositories/form_repository.dart';
import '../cubit/form_cubit.dart';
import '../cubit/form_state.dart' as app;
import '../widgets/dynamic_field.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repo = context.read<FormRepository>();
        final loadFormUseCase = LoadFormUseCase(repo);
        final applyRulesAndValidateUseCase = ApplyRulesAndValidateUseCase();
        final getSubmissionPayloadUseCase = GetSubmissionPayloadUseCase();
        final cubit = FormCubit(
          loadFormUseCase,
          applyRulesAndValidateUseCase,
          getSubmissionPayloadUseCase,
        );
        cubit.loadForm(assetPath);
        return cubit;
      },
      child: const _FormView(),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        actions: const [ThemeToggleButton()],
      ),
      body: BlocBuilder<FormCubit, app.FormState>(
        builder: (context, state) {
          if (state.isLoading && state.form == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading form…',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state.hasLoadError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 56,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.loadError ?? 'Unknown error',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded, size: 20),
                      label: const Text('Back'),
                    ),
                  ],
                ),
              ),
            );
          }
          final form = state.form!;
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              form.title,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Fill in the fields below. Validation updates as you type.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state.submitError != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.errorContainer.withValues(
                            alpha: 0.6,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.error.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 20,
                              color: colorScheme.error,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                state.submitError!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onErrorContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    ...form.fields
                        .where((f) => state.isVisible(f.id))
                        .map(
                          (field) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DynamicField(
                              field: field,
                              value: state.values[field.id],
                              error: state.getDisplayError(field.id),
                              options: state.getOptions(field),
                              onChanged: (v) => context
                                  .read<FormCubit>()
                                  .setValue(field.id, v),
                              onTouched: () => context
                                  .read<FormCubit>()
                                  .touchField(field.id),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.read<FormCubit>().submit(),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ),
              if (state.submissionResult != null)
                _SubmissionOutput(payload: state.submissionResult!),
            ],
          );
        },
      ),
    );
  }
}

class _SubmissionOutput extends StatelessWidget {
  const _SubmissionOutput({required this.payload});

  final SubmissionPayload payload;

  @override
  Widget build(BuildContext context) {
    const encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(payload.toJson());
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 22,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                'Submission output',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: SelectableText(jsonString, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
