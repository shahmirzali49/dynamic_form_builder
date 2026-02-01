import 'package:equatable/equatable.dart';

import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:dynamic_form_builer/domain/entities/form_entity.dart';
import 'package:dynamic_form_builer/domain/entities/submission_payload.dart';

class FormState extends Equatable {
  final FormEntity? form;
  final Map<String, dynamic> values;
  final Map<String, String> errors;
  final Map<String, bool> visibility;
  final Map<String, bool> requiredFlags;
  final Map<String, List<String>> optionsOverrides;
  final bool isLoading;
  final String? loadError;
  final String? submitError;

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
    this.submitError,
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
    String? submitError,
    SubmissionPayload? submissionResult,
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
      submitError: submitError ?? this.submitError,
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
    submitError,
    submissionResult,
    touchedFields,
    submittedOnce,
  ];
}
