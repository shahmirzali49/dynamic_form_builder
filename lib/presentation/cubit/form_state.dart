import 'package:equatable/equatable.dart';

import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:dynamic_form_builder/domain/entities/form_entity.dart';
import 'package:dynamic_form_builder/domain/entities/submission_payload.dart';

class FormState extends Equatable {
  final FormEntity? form;
  final Map<String, dynamic> values;
  final Map<String, String> errors;
  final Map<String, bool> visibility;
  final Map<String, bool> requiredFlags;
  final Map<String, List<String>> optionsOverrides;
  final bool isLoading;
  final String? loadError;

  final SubmissionPayload? submissionResult;
  final Set<String> touchedFields;
  final bool submittedOnce;

  const FormState({
    this.form,
    this.values = const {},
    this.errors = const {},
    this.visibility = const {},
    this.requiredFlags = const {},
    this.optionsOverrides = const {},
    this.isLoading = false,
    this.loadError,
    this.submissionResult,
    this.touchedFields = const <String>{},
    this.submittedOnce = false,
  });

  bool get isLoaded => form != null && !isLoading;
  bool get hasLoadError => loadError != null;

  bool isRequired(String fieldId) {
    if (requiredFlags.containsKey(fieldId)) return requiredFlags[fieldId]!;
    final field = form?.fields.where((f) => f.id == fieldId).firstOrNull;
    return field?.required ?? false;
  }

  List<String> getOptions(FieldEntity field) {
    if (optionsOverrides.containsKey(field.id)) {
      return optionsOverrides[field.id]!;
    }
    return field.options;
  }

  bool isVisible(String fieldId) => visibility[fieldId] ?? true;

  /// Shows error for a field only after submit or after the user has touched that field.
  String? getDisplayError(String fieldId) {
    if (!errors.containsKey(fieldId)) return null;
    if (submittedOnce || touchedFields.contains(fieldId)) {
      return errors[fieldId];
    }
    return null;
  }

  FormState copyWith({
    FormEntity? form,
    Map<String, dynamic>? values,
    Map<String, String>? errors,
    Map<String, bool>? visibility,
    Map<String, bool>? requiredFlags,
    Map<String, List<String>>? optionsOverrides,
    bool? isLoading,
    String? loadError,
    SubmissionPayload? submissionResult,

    /// When true, submission result is cleared (e.g. after a new value change).
    bool clearSubmissionResult = false,
    Set<String>? touchedFields,
    bool? submittedOnce,
  }) {
    return FormState(
      form: form ?? this.form,
      values: values ?? this.values,
      errors: errors ?? this.errors,
      visibility: visibility ?? this.visibility,
      requiredFlags: requiredFlags ?? this.requiredFlags,
      optionsOverrides: optionsOverrides ?? this.optionsOverrides,
      isLoading: isLoading ?? this.isLoading,
      loadError: loadError ?? this.loadError,
      submissionResult: clearSubmissionResult
          ? null
          : (submissionResult ?? this.submissionResult),
      touchedFields: touchedFields ?? this.touchedFields,
      submittedOnce: submittedOnce ?? this.submittedOnce,
    );
  }

  @override
  List<Object?> get props => [
    form,
    values,
    errors,
    visibility,
    requiredFlags,
    optionsOverrides,
    isLoading,
    loadError,
    submissionResult,
    touchedFields,
    submittedOnce,
  ];
}
