import 'package:dynamic_form_builder/domain/entities/rule_entity.dart';

class ConditionDto {
  final String? fieldId;
  final String? operator;
  final dynamic value;
  final List<ConditionDto>? conditions;

  const ConditionDto({
    this.fieldId,
    this.operator,
    this.value,
    this.conditions,
  });

  factory ConditionDto.fromJson(Map<String, dynamic> json) {
    return ConditionDto(
      fieldId: json['fieldId'] as String?,
      operator: json['operator'] as String?,
      value: json['value'],
      conditions: (json['conditions'] as List<dynamic>?)
          ?.map((e) => ConditionDto.fromJson(e))
          .toList(),
    );
  }

  ConditionEntity toEntity() {
    return ConditionEntity(
      fieldId: fieldId,
      operator: operator,
      value: value,
      conditions: conditions?.map((c) => c.toEntity()).toList(),
    );
  }
}

class ActionDto {
  final String action;
  final String targetFieldId;
  final dynamic value;

  const ActionDto({
    required this.action,
    required this.targetFieldId,
    required this.value,
  });

  factory ActionDto.fromJson(Map<String, dynamic> json) {
    return ActionDto(
      action: json['action'] as String,
      targetFieldId: json['targetFieldId'] as String,
      value: json['value'],
    );
  }

  ActionEntity toEntity() {
    return ActionEntity(
      action: action,
      targetFieldId: targetFieldId,
      value: value,
    );
  }
}

class RuleDto {
  final String id;
  final Map<String, dynamic> when;
  final List<dynamic> then;
  final List<dynamic> elseCondition;

  const RuleDto({
    required this.id,
    required this.when,
    required this.then,
    required this.elseCondition,
  });

  factory RuleDto.fromJson(Map<String, dynamic> json) {
    return RuleDto(
      id: json['id'] as String,
      when: json['when'] as Map<String, dynamic>,
      then: json['then'] as List<dynamic>,
      elseCondition: (json['else'] as List<dynamic>),
    );
  }

  RuleEntity toEntity() {
    return RuleEntity(
      id: id,
      when: ConditionDto.fromJson(when).toEntity(),
      then: then.map((e) => ActionDto.fromJson(e).toEntity()).toList(),
      elseActions: elseCondition
          .map((e) => ActionDto.fromJson(e).toEntity())
          .toList(),
    );
  }
}
