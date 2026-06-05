# Project Structure Refactor Design

**Date:** 2026-06-04

## Goal

Refactor the Flutter project toward the base structure described in `docs/base_structure.md` while keeping behavior stable and making the migration executable in small, verifiable stages.

## Current State

The current repository is organized mainly under:

```text
lib/
|-- helper/
|-- infrastructure/
`-- presentation/
```

Observed gaps against the target structure:

- Shared code is not separated into a dedicated `base/` layer.
- Feature code is not grouped under feature modules.
- Some domain models currently live inside `presentation`.
- Repositories import feature presentation models, which reverses the intended dependency direction.
- Application bootstrap, DI, and routing are still effectively colocated in `main.dart`.

## Chosen Approach

Use a staged full refactor.

This means the repository will move to the full target architecture, but in controlled migration steps so the app can remain buildable and testable throughout the process.

This was chosen over a big-bang rewrite because the current code already contains working UI and tests, and a full move in one pass would make import churn and regression risk unnecessarily high.

## Target Structure

```text
lib/
|-- app/
|   |-- bootstrap/
|   |-- di/
|   `-- router/
|-- base/
|   |-- configs_app/
|   |-- domain/
|   |-- services/
|   |-- utils/
|   `-- widgets/
|-- features/
|   |-- cart/
|   |   |-- di/
|   |   |-- domain/
|   |   |   `-- entities/
|   |   |-- infrastructure/
|   |   |   |-- params/
|   |   |   `-- repositories/
|   |   |-- presentation/
|   |   |   |-- blocs/
|   |   |   |-- pages/
|   |   |   `-- widgets/
|   |   `-- use_cases/
|   |-- customer_profile/
|   |-- home/
|   `-- shared/
|-- l10n/
`-- main.dart
```

## Mapping from Current Structure

- `lib/helper/*` -> `lib/base/utils/*`
- reusable items from `lib/presentation/widgets/*` -> `lib/base/widgets/*`
- app-level but feature-adjacent shared widgets -> `lib/features/shared/*`
- `lib/infrastructure/repositories/home/*` -> `lib/features/home/infrastructure/repositories/*`
- `lib/infrastructure/repositories/customer_profile/*` -> `lib/features/customer_profile/infrastructure/repositories/*`
- `lib/presentation/pages/home/*` -> `lib/features/home/presentation/*`
- `lib/presentation/pages/customer_profile/*` -> `lib/features/customer_profile/presentation/*`
- `lib/presentation/pages/cart/*` -> `lib/features/cart/presentation/*`

## Layer Rules

### Presentation

- Contains pages, widgets, blocs/cubits, and UI state.
- Calls use cases, not repositories directly.
- Should not own domain entities.

### Use Cases

- Expose business actions to presentation.
- Depend on repository contracts.
- Keep UI flow and rendering concerns out of this layer.

### Infrastructure

- Holds repository contracts and implementations.
- Handles mock/local/api data access depending on the current application stage.
- Must not import from feature presentation folders.

### Domain

- Holds feature entities and domain-facing models.
- Replaces current models placed under presentation.
- Does not contain UI-specific concerns.

### Base

- Holds code reused across multiple features or app bootstrap.
- Must stay intentional; it is not a dumping ground for unrelated helpers.

## Naming Conventions

- `*_use_case.dart`
- `*_repository.dart`
- `*_repository_impl.dart`
- `*_params.dart`
- `*_entity.dart`
- `*_cubit.dart`
- `*_page.dart`

## Migration Stages

### Stage 1: Build the app shell

- Create `lib/app/bootstrap`, `lib/app/di`, and `lib/app/router`.
- Reduce `main.dart` to a thin entrypoint.
- Keep behavior unchanged.

### Stage 2: Extract shared/base code

- Move `helper` content into `base/utils`.
- Review current shared presentation widgets and split them between `base/widgets` and `features/shared`.
- Standardize naming for new folders and files.

### Stage 3: Migrate `customer_profile`

- Move presentation models into domain entities.
- Move repositories into feature infrastructure.
- Introduce explicit use cases.
- Move cubit, pages, and widgets under the feature module.

`customer_profile` is the reference implementation for the target pattern.

### Stage 4: Migrate `home` and `cart`

- Apply the same layering pattern to `home`.
- Restructure `cart`, which currently mixes models, bloc/cubit, and widgets more heavily.

### Stage 5: Remove compatibility leftovers

- Delete obsolete folders and imports after all features are migrated.
- Run tests and complete final import cleanup.

## Testing Strategy

- Preserve the current widget smoke test for `customer_profile`.
- Add focused tests where risk is highest during migration:
  - use case tests
  - cubit/bloc tests for main success/error flows
  - smoke widget tests for primary screens
- Do not expand scope into golden testing in this refactor.

## Non-Goals

- No backend/data-source redesign beyond what is needed to correct layering.
- No UI redesign.
- No feature behavior changes unless required to preserve architecture boundaries.

## Execution Notes

- Keep each migration stage buildable.
- Prefer controlled file moves and import updates over bulk structural churn.
- Preserve current mock behavior first, especially in repository implementations, before introducing more advanced DI or networking changes.
