/// JSON-driven dynamic form builder for Flutter.
///
/// Use [DynamicFormScreen] with an asset path to show a form loaded from JSON.
/// No global setup is required; the widget creates its own dependencies.
library;

export 'package:dynamic_form_builder/core/enums/field_types.dart';
export 'package:dynamic_form_builder/data/datasources/form_datasource.dart';
export 'package:dynamic_form_builder/domain/entities/field_entity.dart';
export 'package:dynamic_form_builder/domain/entities/form_entity.dart';
export 'package:dynamic_form_builder/domain/entities/submission_payload.dart';
export 'package:dynamic_form_builder/domain/repositories/form_repository.dart';
export 'package:dynamic_form_builder/labels.dart';
export 'package:dynamic_form_builder/presentation/cubit/form_cubit.dart';
export 'package:dynamic_form_builder/presentation/cubit/form_state.dart';
export 'package:dynamic_form_builder/presentation/screens/form_screen.dart';
export 'package:dynamic_form_builder/presentation/widgets/form_card.dart';
