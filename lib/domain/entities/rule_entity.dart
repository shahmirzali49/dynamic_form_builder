/// A single condition: either a leaf (fieldId + operator + value) or a logical group (operator + conditions).
class ConditionEntity {
  final String? fieldId;
  final String? operator;
  final dynamic value;
  final List<ConditionEntity>? conditions;

  const ConditionEntity({
    this.fieldId,
    this.operator,
    this.value,
    this.conditions,
  });
}

/// One action to apply when a rule’s condition is true (e.g. setVisible, setRequired, setValue, setOptions).
class ActionEntity {
  final String action;
  final String targetFieldId;
  final dynamic value;

  const ActionEntity({
    required this.action,
    required this.targetFieldId,
    required this.value,
  });
}

/// One rule: when the condition holds, run then-actions; otherwise run else-actions.
class RuleEntity {
  final String id;
  final ConditionEntity when;
  final List<ActionEntity> then;
  final List<ActionEntity> elseActions;

  const RuleEntity({
    required this.id,
    required this.when,
    required this.then,
    this.elseActions = const [],
  });
}
