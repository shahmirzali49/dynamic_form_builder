import 'package:dynamic_form_builer/domain/entities/form_entity.dart';
import 'package:dynamic_form_builer/domain/rule_engine/rule_application_result.dart';

class LoadFormResult {
  const LoadFormResult({required this.form, required this.ruleResult});

  final FormEntity form;
  final RuleApplicationResult ruleResult;
}
