# dynamic_form_builder

A Flutter package that renders dynamic forms from JSON definitions. Supports validation and conditional rules.

**No global setup.** Use the widget; it creates its own dependencies.

## Installation

```yaml
dependencies:
  dynamic_form_builder:
    path: packages/dynamic_form_builder  # when inside a monorepo
  # or from pub.dev:
  # dynamic_form_builder: ^1.0.0
```

## Usage

Use [DynamicFormScreen] with an asset path. No `main()` setup required.

```dart
import 'package:dynamic_form_builder/dynamic_form_builder.dart';

// In your app (e.g. in a route):
DynamicFormScreen(
  assetPath: 'assets/forms/my_form.json',
)
```

**Optional: labels** (e.g. for localization):

```dart
DynamicFormScreen(
  assetPath: 'assets/forms/my_form.json',
  labels: DynamicFormLabels(
    formTitle: 'Form',
    loadingForm: 'Loading…',
    submit: 'Submit',
    // … other strings
  ),
)
```

**Optional: custom data source** (e.g. load from network instead of assets):

```dart
DynamicFormScreen(
  assetPath: 'my_form_id',  // or any identifier your source needs
  formDatasource: MyNetworkFormDatasource(),
)
```

## JSON schema

See the root project [README JSON schema](../../README.md#json-schema-documentation) for the form definition format.

## Customization

- **FormDatasource**: Implement [FormDatasource] and pass it as [DynamicFormScreen.formDatasource]. Default is [AssetFormDatasource] (loads from `rootBundle`).
- **Labels**: Override [DynamicFormLabels] for all form UI strings (localization).
