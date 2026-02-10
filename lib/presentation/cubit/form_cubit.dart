import 'package:dynamic_form_builder/domain/usecases/apply_rules_and_validate_use_case.dart';
import 'package:dynamic_form_builder/domain/usecases/get_submission_payload_use_case.dart';
import 'package:dynamic_form_builder/domain/usecases/load_form_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_state.dart';

/// Manages form state: load form, update values (and re-run rules + validation), touch fields, submit.
class FormCubit extends Cubit<FormState> {
  FormCubit(
    this._loadFormUseCase,
    this._applyRulesAndValidateUseCase,
    this._getSubmissionPayloadUseCase,
  ) : super(const FormState());

  final LoadFormUseCase _loadFormUseCase;
  final ApplyRulesAndValidateUseCase _applyRulesAndValidateUseCase;
  final GetSubmissionPayloadUseCase _getSubmissionPayloadUseCase;

  Future<void> loadForm(String assetPath) async {
    emit(const FormState(isLoading: true));
    try {
      final result = await _loadFormUseCase(assetPath);
      emit(
        FormState(
          form: result.form,
          values: result.ruleResult.values,
          visibility: result.ruleResult.visibility,
          requiredFlags: result.ruleResult.requiredFlags,
          optionsOverrides: result.ruleResult.options,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, loadError: e.toString()));
    }
  }

  /// Updates one field, re-applies rules and validation, then emits new state.
  void setValue(String fieldId, dynamic value) {
    final form = state.form;
    if (form == null) return;
    final newValues = Map<String, dynamic>.from(state.values)
      ..[fieldId] = value;
    final applyResult = _applyRulesAndValidateUseCase(form, newValues);
    final touched = Set<String>.from(state.touchedFields)..add(fieldId);
    emit(
      state.copyWith(
        values: applyResult.ruleResult.values,
        visibility: applyResult.ruleResult.visibility,
        requiredFlags: applyResult.ruleResult.requiredFlags,
        optionsOverrides: applyResult.ruleResult.options,
        errors: applyResult.errors,
        submissionResult: null,
        touchedFields: touched,
      ),
    );
  }

  void touchField(String fieldId) {
    if (state.touchedFields.contains(fieldId)) return;
    emit(
      state.copyWith(
        touchedFields: Set<String>.from(state.touchedFields)..add(fieldId),
      ),
    );
  }

  /// Validates; on success builds and stores submission payload.
  void submit() {
    final form = state.form;
    if (form == null) return;
    final applyResult = _applyRulesAndValidateUseCase(form, state.values);
    if (applyResult.errors.isNotEmpty) {
      emit(
        state.copyWith(
          errors: applyResult.errors,
          submissionResult: null,
          submittedOnce: true,
        ),
      );
      return;
    }
    final payload = _getSubmissionPayloadUseCase.getSubmissionPayload(
      form: form,
      values: applyResult.ruleResult.values,
      visibility: applyResult.ruleResult.visibility,
    );
    emit(state.copyWith(errors: {}, submissionResult: payload));
  }
}
