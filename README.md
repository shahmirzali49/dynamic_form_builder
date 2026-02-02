# Dynamic Form Builder

A Flutter application that renders forms from JSON definitions. Forms support validation, conditional visibility, and multiple field types. The app runs on mobile, web, and desktop.

---

## Project overview and features

- **JSON-driven forms**: Forms are defined in JSON files under `assets/forms/`. No code changes are needed to add or edit a form; only the JSON is updated.
- **Field types**: Text, multiline, number, dropdown, checkbox, date, radio, slider, and phone. Each type has a dedicated UI and validation.
- **Validation**: Per-field rules (e.g. min/max length, regex, date range, number range). Validation runs on submit and invalid fields are highlighted.
- **Conditional logic (rules)**: Show/hide fields, change required state, or set values based on other fields. Supports single conditions and combined conditions (`and` / `or` / `not`).
- **Theme**: Light and dark theme with a toggle on the home and form screens.
- **Localisation**: Strings are externalised via `l10n` (e.g. `app_en.arb`) for easier translation and maintenance.
- **Routing**: Declarative routing with **go_router**. Form screens are reached by path (e.g. `/form/customer_onboarding`).

Example forms included:

- **New Connection Request** (`customer_onboarding`) – account type, plan, contact preferences, conditional company and premium fields.
- **Travel Request** (`travel_request`) – travel details and approval flow.
- **Feedback & Registration** (`feedback_and_registration`) – feedback form with ratings and comments.

---

## Architecture decisions and rationale

The project follows a **layered architecture** (data → domain → presentation) so that business logic stays independent of UI and data sources.

### Layers

1. **Data** (`lib/data/`)
   - **DTOs**: `FormDto`, `FieldDto`, `RuleDto` (and nested `ConditionDto`, `ActionDto`) map from JSON to domain.
   - **Datasource**: `FormDatasource` loads JSON from Flutter assets.
   - **Repository implementation**: `FormRepositoryImpl` uses the datasource and converts DTOs to domain entities. This is the only place that knows about assets/JSON.

2. **Domain** (`lib/domain/`)
   - **Entities**: Plain models such as `FormEntity`, `FieldEntity`, `RuleEntity` used across the app.
   - **Repository interface**: `FormRepository` is defined here; the app depends on this abstraction, not on the concrete implementation.
   - **Use cases**: `LoadFormUseCase`, `ApplyRulesAndValidateUseCase`, `GetSubmissionPayloadUseCase` encapsulate steps (load form, apply rules and validate, build submission payload). Presentation and data stay decoupled.
   - **Rule engine**: `ConditionEvaluator`, `ValueComparator`, `RuleApplier` evaluate conditions and apply actions (visibility, required, value). Kept in domain so rules can be tested without Flutter.
   - **Validators**: Per-type validators (e.g. `TextValidator`, `NumberValidator`, `DateValidator`) implement a common interface. Validation rules come from the JSON schema.

3. **Presentation** (`lib/presentation/`)
   - **Cubit**: `FormCubit` holds form state, calls use cases, and exposes events (e.g. load form, field changed, submit). Uses **flutter_bloc**.
   - **Pages**: `HomeScreen` lists forms; `FormScreen` shows one form and wires fields to the cubit.
   - **Widgets**: `DynamicField` delegates to field builders (e.g. `TextFieldBuilder`, `DropdownFieldBuilder`). Adding a new field type means adding a builder and registering it; the form screen stays unchanged.

4. **Core** (`lib/core/`)
   - **Theme**: `AppTheme`, `ThemeCubit`, shared colors and text styles for light/dark.
   - **Navigation**: `AppRouter` with go_router; form path is `/form/:formName`.
   - **L10n**: ARB files and generated localisations.
   - **Constants**: App title and list of forms (title, asset path, URL name) so the home screen and router stay in sync.


- **Cubit over Bloc**: For this app, Cubit’s simpler API (methods instead of event classes) is enough and keeps the code shorter.


---

## How to run the application

### Prerequisites

- **Flutter SDK** 3.38.8 or later
- **Dart** 3.10.7+.

### Setup and run

1. **Clone the project** 

2. **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the app**:

- **Chrome (web)**  
  ```bash
  flutter run -d chrome
  ```


4. **Use the app**  
   - Open the home screen, choose a form (e.g. “New Connection Request”).  
   - You are taken to `/form/customer_onboarding` (or the corresponding path).  
   - Fill the form; conditional fields appear/hide and required state updates according to rules.  
   - Use the theme toggle to switch light/dark.  
   - Submit to see client-side validation and a summary of the submitted payload.

---

## How to run tests

All tests are in the `test/` folder and target domain logic (rule engine, validators, use cases).

From the project root:

```bash
flutter test
```


---

## JSON schema documentation

Forms are stored as JSON in `assets/forms/`. The schema below describes the structure the app expects.

### Root: form object

| Property | Type   | Required | Description |
|----------|--------|----------|-------------|
| `formId` | string | Yes      | Unique form identifier. |
| `title`  | string | Yes      | Form title shown in the UI. |
| `version`| number | Yes      | Form version (integer). |
| `fields` | array  | Yes      | List of field objects (see below). |
| `rules`  | array  | No       | List of rule objects for conditional behaviour (see below). |

### Field object

| Property       | Type   | Required | Description |
|----------------|--------|----------|-------------|
| `id`           | string | Yes      | Unique field id; used in rules and submission payload. |
| `label`        | string | Yes      | Label shown next to the field. |
| `type`         | string | Yes      | One of: `text`, `multiline`, `number`, `dropdown`, `checkbox`, `date`, `radio`, `slider`, `phone`. |
| `required`     | boolean| Yes      | Whether the field must be filled before submit. |
| `defaultValue` | any    | No       | Initial value. |
| `options`      | array  | No       | For `dropdown`, `radio`: list of option strings. |
| `validators`   | object | No       | Validation options; see “Validators” below. |

### Validators (per field type)

- **text / multiline**  
  - `minLength` (number), `maxLength` (number)  
  - `regex` (string): pattern for format validation  
  - `contains` (string): value must contain this substring  

- **number**  
  - `min`, `max` (number)  
  - `integerOnly` (boolean): if true, only integers allowed  

- **date**  
  - `dateMin` (string, ISO date e.g. `"2024-01-01"`)  
  - `dateMax` (string, ISO date)  

- **phone**  
  - No extra keys in the current implementation; required/optional is still enforced.  

Other types (dropdown, checkbox, radio, slider) use only the `required` flag from the field; you can pass an empty `validators: {}` for consistency.

### Rule object

Rules define conditional visibility, required state, and default values.

| Property | Type   | Required | Description |
|----------|--------|----------|-------------|
| `id`     | string | Yes      | Unique rule id (for debugging). |
| `when`   | object | Yes      | Condition (see “Condition object”). |
| `then`   | array  | Yes      | List of action objects when the condition is true. |
| `else`   | array  | Yes      | List of action objects when the condition is false. |

### Condition object

Either a **single condition** or a **logical group**:

**Single condition:**

| Property   | Type   | Required | Description |
|------------|--------|----------|-------------|
| `fieldId`  | string | Yes      | Id of the field to test. |
| `operator` | string | Yes      | One of: `==`, `!=`, `>`, `>=`, `<`, `<=`, `in`, `contains`. |
| `value`    | any    | Yes      | Value to compare with the field’s current value. For `in`, an array. |

**Logical group:**

| Property    | Type   | Required | Description |
|-------------|--------|----------|-------------|
| `operator`  | string | Yes      | `and`, `or`, or `not`. |
| `conditions`| array  | Yes      | List of condition objects (single or nested groups). |

### Action object

| Property       | Type   | Required | Description |
|----------------|--------|----------|-------------|
| `action`       | string | Yes      | One of: `setVisible`, `setRequired`, `setValue`. |
| `targetFieldId`| string | Yes      | Id of the field to update. |
| `value`       | any    | Yes      | For `setVisible`/`setRequired`: boolean. For `setValue`: the value to set. |

### Example snippet

```json
{
  "formId": "example_form",
  "title": "Example Form",
  "version": 1,
  "fields": [
    {
      "id": "accountType",
      "label": "Account Type",
      "type": "dropdown",
      "required": true,
      "options": ["Personal", "Business"],
      "validators": {}
    },
    {
      "id": "companyName",
      "label": "Company Name",
      "type": "text",
      "required": false,
      "validators": { "minLength": 2, "maxLength": 100 }
    }
  ],
  "rules": [
    {
      "id": "show_company_for_business",
      "when": { "fieldId": "accountType", "operator": "==", "value": "Business" },
      "then": [
        { "action": "setVisible", "targetFieldId": "companyName", "value": true },
        { "action": "setRequired", "targetFieldId": "companyName", "value": true }
      ],
      "else": [
        { "action": "setVisible", "targetFieldId": "companyName", "value": false },
        { "action": "setRequired", "targetFieldId": "companyName", "value": false }
      ]
    }
  ]
}
```

Full examples are in `assets/forms/` (e.g. `customer_onboarding.json`, `travel_request.json`, `feedback_and_registration.json`).

---

## Adding a new form

1. Add a new JSON file under `assets/forms/` following the schema above.
2. In `lib/core/constants/app_constants.dart`, add a `FormInfo` entry with `title`, `assetPath` (e.g. `'assets/forms/your_form.json'`), and `urlName` (e.g. `'your_form'`).
3. Run the app and open the new form from the home screen or by navigating to `/form/your_form`.

No other code changes are required; the app discovers the form via `AppConstants.forms` and resolves the asset path in the router.
