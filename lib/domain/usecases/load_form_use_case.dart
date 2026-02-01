import 'package:dynamic_form_builer/core/enums/field_types.dart';
import 'package:dynamic_form_builer/domain/entities/field_entity.dart';
import 'package:dynamic_form_builer/domain/entities/load_form_result.dart';
import 'package:dynamic_form_builer/domain/repositories/form_repository.dart';
import 'package:dynamic_form_builer/domain/rule_engine/rule_applier.dart';

class LoadFormUseCase {
  LoadFormUseCase(this._repository);

  final FormRepository _repository;
  Future<LoadFormResult> call(String assetPath) async {
    final form = await _repository.loadForm(assetPath);
    final initialValues = _buildInitialValues(form.fields);
    final result = RuleApplier.apply(form.rules, form.fields, initialValues);
    return LoadFormResult(form: form, ruleResult: result);
  }

  static Map<String, dynamic> _buildInitialValues(List<FieldEntity> fields) {
    final values = <String, dynamic>{};
    for (final f in fields) {
      if (f.defaultValue != null) {
        values[f.id] = f.defaultValue;
      } else if (f.type == FieldType.checkbox) {
        values[f.id] = false;
      } else {
        values[f.id] = '';
      }
    }
    return values;
  }
}
