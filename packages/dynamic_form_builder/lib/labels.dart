/// Default English labels for the form UI. Override via [DynamicFormScreen.labels].
class DynamicFormLabels {
  const DynamicFormLabels({
    this.formTitle = 'Form',
    this.loadingForm = 'Loading form…',
    this.fillFieldsHint = 'Fill in the fields below.',
    this.submit = 'Submit',
    this.submissionOutput = 'Submission',
    this.back = 'Back',
    this.unknownError = 'Something went wrong.',
    this.selectDate = 'Select date',
  });

  final String formTitle;
  final String loadingForm;
  final String fillFieldsHint;
  final String submit;
  final String submissionOutput;
  final String back;
  final String unknownError;
  final String selectDate;

  static const en = DynamicFormLabels();
}
