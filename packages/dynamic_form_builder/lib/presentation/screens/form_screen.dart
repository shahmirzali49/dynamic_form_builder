import 'dart:convert';

import 'package:dynamic_form_builder/data/datasources/form_datasource.dart';
import 'package:dynamic_form_builder/data/repositories/form_repository_impl.dart';
import 'package:dynamic_form_builder/domain/entities/submission_payload.dart';
import 'package:dynamic_form_builder/domain/usecases/apply_rules_and_validate_use_case.dart';
import 'package:dynamic_form_builder/domain/usecases/get_submission_payload_use_case.dart';
import 'package:dynamic_form_builder/domain/usecases/load_form_use_case.dart';
import 'package:dynamic_form_builder/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/form_cubit.dart';
import '../cubit/form_state.dart' as app;
import '../widgets/dynamic_field.dart';

/// Full-screen dynamic form loaded from an asset path.
///
/// Dependencies (datasource, repository, use cases, cubit) are created internally.
/// Pass [formDatasource] only when you need a custom source (e.g. network);
/// otherwise forms are loaded from Flutter assets via [AssetFormDatasource].
///
/// Use [DynamicFormLabels] to override UI strings (e.g. for localization).
class DynamicFormScreen extends StatelessWidget {
  const DynamicFormScreen({
    super.key,
    required this.assetPath,
    this.formDatasource,
    this.labels = const DynamicFormLabels(),
    this.appBarTitle,
    this.actions,
    this.onBack,
  });

  final String assetPath;

  /// Optional. When null, [AssetFormDatasource] is used (loads from rootBundle).
  final FormDatasource? formDatasource;

  final DynamicFormLabels labels;
  final String? appBarTitle;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final path = assetPath;
    final ds = formDatasource;

    return BlocProvider<FormCubit>(
      create: (_) {
        final datasource = ds ?? AssetFormDatasource();
        final repository = FormRepositoryImpl(datasource);
        final loadUseCase = LoadFormUseCase(repository);
        final applyUseCase = ApplyRulesAndValidateUseCase();
        final payloadUseCase = GetSubmissionPayloadUseCase();
        final cubit = FormCubit(loadUseCase, applyUseCase, payloadUseCase);
        cubit.loadForm(path);
        return cubit;
      },
      child: _DynamicFormView(
        labels: labels,
        appBarTitle: appBarTitle ?? labels.formTitle,
        actions: actions,
        onBack: onBack,
      ),
    );
  }
}

class _DynamicFormView extends StatelessWidget {
  const _DynamicFormView({
    required this.labels,
    required this.appBarTitle,
    this.actions,
    this.onBack,
  });

  final DynamicFormLabels labels;
  final String appBarTitle;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: onBack != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: onBack,
              )
            : (actions == null && onBack == null
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    )),
        actions: actions,
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
                    labels.loadingForm,
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
                      state.loadError ?? labels.unknownError,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: onBack ?? () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_rounded, size: 20),
                      label: Text(labels.back),
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
                              labels.fillFieldsHint,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                              selectDateLabel: labels.selectDate,
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
                      child: Text(labels.submit),
                    ),
                  ),
                ),
              ),
              if (state.submissionResult != null)
                _SubmissionOutput(
                  payload: state.submissionResult!,
                  label: labels.submissionOutput,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SubmissionOutput extends StatelessWidget {
  const _SubmissionOutput({required this.payload, required this.label});

  final SubmissionPayload payload;
  final String label;

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
                label,
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
