import 'package:dynamic_form_builder/domain/entities/field_entity.dart';
import 'package:dynamic_form_builder/domain/entities/form_entity.dart';
import 'package:dynamic_form_builder/domain/entities/submission_payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_state.freezed.dart';

@freezed
abstract class FormState with _$FormState {
  const FormState._();

  const factory FormState({
    FormEntity? form,
    @Default(<String, dynamic>{}) Map<String, dynamic> values,
    @Default(<String, String>{}) Map<String, String> errors,
    @Default(<String, bool>{}) Map<String, bool> visibility,
    @Default(<String, bool>{}) Map<String, bool> requiredFlags,
    @Default(<String, List<String>>{})
    Map<String, List<String>> optionsOverrides,
    @Default(false) bool isLoading,
    String? loadError,
    SubmissionPayload? submissionResult,
    @Default(<String>{}) Set<String> touchedFields,
    @Default(false) bool submittedOnce,
  }) = _FormState;

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
}
