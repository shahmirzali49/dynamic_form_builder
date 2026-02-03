import 'package:dynamic_form_builder/domain/rule_engine/rule_application_result.dart';

class ApplyRulesResult {
  const ApplyRulesResult({required this.ruleResult, required this.errors});

  final RuleApplicationResult ruleResult;
  final Map<String, String> errors;
}
