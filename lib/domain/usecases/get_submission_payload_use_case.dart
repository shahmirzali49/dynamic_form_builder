

import 'package:dynamic_form_builer/domain/entities/form_entity.dart';
import 'package:dynamic_form_builer/domain/entities/submission_payload.dart';

class GetSubmissionPayloadUseCase {
  SubmissionPayload getSubmissionPayload({
    required FormEntity form,
    required Map<String, dynamic> values,
    required Map<String, bool> visibility,
  }) {
    final visibleIds =
        form.fields
            .where((f) => visibility[f.id] == true)
            .map((f) => f.id)
            .toList()
          ..sort();
    final payloadValues = <String, dynamic>{};
    for (final id in visibleIds) {
      if (values.containsKey(id)) {
        payloadValues[id] = values[id];
      }
    }
    return SubmissionPayload(
      formId: form.formId,
      version: form.version,
      submittedAt: DateTime.now().toUtc().toIso8601String(),
      values: payloadValues,
    );
  }
}
