import 'package:dynamic_form_builder/domain/entities/form_entity.dart';
import 'package:dynamic_form_builder/domain/rule_engine/rule_application_result.dart';

class LoadFormResult {
  const LoadFormResult({required this.form, required this.ruleResult});

  final FormEntity form;
  final RuleApplicationResult ruleResult;
}
