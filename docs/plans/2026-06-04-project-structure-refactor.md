# Project Structure Refactor Implementation Plan

> **For Antigravity:** REQUIRED WORKFLOW: Use `.agent/workflows/execute-plan.md` to execute this plan in single-flow mode.

**Goal:** Refactor the Flutter app from its current flat structure into the approved staged architecture with `app`, `base`, and `features` modules while keeping the app behavior stable.

**Architecture:** The migration will create the target folder structure first, then move shared code and bootstrap concerns, then migrate each feature into `domain`, `infrastructure`, `use_cases`, and `presentation` layers. The work is sequenced so imports, behavior, and tests can be verified after each stage.

**Tech Stack:** Flutter, Dart, flutter_bloc, widget tests

---

### Task 1: Create tracking docs and target directories

**Files:**
- Create: `docs/plans/task.md`
- Create: `docs/plans/2026-06-04-project-structure-refactor-design.md`
- Create: `docs/plans/2026-06-04-project-structure-refactor.md`
- Create: `lib/app/bootstrap/.gitkeep`
- Create: `lib/app/di/.gitkeep`
- Create: `lib/app/router/.gitkeep`
- Create: `lib/base/configs_app/.gitkeep`
- Create: `lib/base/domain/.gitkeep`
- Create: `lib/base/services/.gitkeep`
- Create: `lib/base/utils/.gitkeep`
- Create: `lib/base/widgets/.gitkeep`
- Create: `lib/features/shared/.gitkeep`

**Step 1: Create the empty target directories**

Create the folder skeleton that matches the approved architecture without moving any app logic yet.

**Step 2: Verify the new folders exist**

Run: `rg --files lib/app lib/base lib/features`
Expected: output includes the new scaffold paths

**Step 3: Commit**

```bash
git add docs/plans lib/app lib/base lib/features
git commit -m "chore: scaffold target project structure"
```

### Task 2: Introduce app bootstrap and thin main entrypoint

**Files:**
- Create: `lib/app/bootstrap/app.dart`
- Modify: `lib/main.dart`

**Step 1: Write the failing smoke test expectation**

Document the expected behavior:
- app still starts with `CustomerProfileScreen`
- existing bloc providers are still registered

If no direct app-entry test exists yet, use the existing widget test as the guardrail.

**Step 2: Implement thin bootstrap**

Move `MaterialApp` creation and root `MultiBlocProvider` into `lib/app/bootstrap/app.dart`.
Keep `main.dart` limited to calling `runApp(...)`.

**Step 3: Run the relevant widget test**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

**Step 4: Commit**

```bash
git add lib/main.dart lib/app/bootstrap/app.dart test/customer_profile/customer_profile_screen_test.dart
git commit -m "refactor: extract app bootstrap"
```

### Task 3: Move shared helper code into `base/utils`

**Files:**
- Create: `lib/base/utils/`
- Modify: files under `lib/helper/`
- Modify: imports that reference `lib/helper/*`

**Step 1: Inventory helper usage**

Run: `rg "helper/" lib test`
Expected: all imports referencing helper files are listed

**Step 2: Move helper files one by one**

Start with:
- `lib/helper/reponsvie_widget.dart` -> `lib/base/utils/responsive_widget.dart`

While moving:
- fix typo-driven naming when safe
- update imports incrementally

**Step 3: Verify analyzer or tests**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

**Step 4: Commit**

```bash
git add lib/base/utils lib/helper lib/main.dart lib/app test/customer_profile/customer_profile_screen_test.dart
git commit -m "refactor: move shared helpers into base utils"
```

### Task 4: Split reusable widgets into `base/widgets` and `features/shared`

**Files:**
- Modify: `lib/presentation/widgets/service_chip.dart`
- Modify: `lib/presentation/widgets/scanner_dialog.dart`
- Modify: `lib/presentation/widgets/info_row_item.dart`
- Create: matching files under `lib/base/widgets/` or `lib/features/shared/`
- Modify: imports across feature screens

**Step 1: Classify each shared widget**

Use this rule:
- framework-like reusable widget -> `base/widgets`
- app-level shared but domain-adjacent widget -> `features/shared`

**Step 2: Move widgets incrementally**

Move one widget at a time and update imports before moving the next.

**Step 3: Run relevant test coverage**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

**Step 4: Commit**

```bash
git add lib/base/widgets lib/features/shared lib/presentation/widgets test/customer_profile/customer_profile_screen_test.dart
git commit -m "refactor: reorganize shared widgets"
```

### Task 5: Create the `customer_profile` feature module skeleton

**Files:**
- Create: `lib/features/customer_profile/di/.gitkeep`
- Create: `lib/features/customer_profile/domain/entities/.gitkeep`
- Create: `lib/features/customer_profile/infrastructure/repositories/.gitkeep`
- Create: `lib/features/customer_profile/presentation/cubit/.gitkeep`
- Create: `lib/features/customer_profile/presentation/pages/.gitkeep`
- Create: `lib/features/customer_profile/presentation/widgets/.gitkeep`
- Create: `lib/features/customer_profile/use_cases/.gitkeep`

**Step 1: Add the folder structure**

Create the complete feature shell before moving files.

**Step 2: Verify structure**

Run: `rg --files lib/features/customer_profile`
Expected: output includes all customer profile subfolders

**Step 3: Commit**

```bash
git add lib/features/customer_profile
git commit -m "chore: scaffold customer profile feature module"
```

### Task 6: Move customer profile entities out of presentation

**Files:**
- Modify/Create: files currently under `lib/presentation/pages/customer_profile/model/`
- Create: matching files under `lib/features/customer_profile/domain/entities/`
- Modify: imports in customer profile pages, widgets, cubit, and repositories

**Step 1: Move entity files**

Candidate files:
- `customer_activity_model.dart`
- `customer_booking_model.dart`
- `customer_profile_data.dart`
- `customer_profile_model.dart`
- `customer_service_model.dart`

Rename toward entity naming only if the churn is manageable in the same step; otherwise keep names stable and normalize later.

**Step 2: Remove repository dependency on presentation**

Update repository files so they import the new domain entity paths.

**Step 3: Run the focused widget test**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

**Step 4: Commit**

```bash
git add lib/features/customer_profile lib/presentation/pages/customer_profile lib/infrastructure/repositories/customer_profile test/customer_profile/customer_profile_screen_test.dart
git commit -m "refactor: move customer profile entities into domain"
```

### Task 7: Introduce customer profile use case and repository contract placement

**Files:**
- Create: `lib/features/customer_profile/use_cases/load_customer_profile_use_case.dart`
- Create/Modify: `lib/features/customer_profile/infrastructure/repositories/customer_profile_repository.dart`
- Create/Modify: `lib/features/customer_profile/infrastructure/repositories/customer_profile_repository_impl.dart`
- Modify: `lib/features/customer_profile/presentation/cubit/customer_profile_cubit.dart`

**Step 1: Write the intended API**

Target shape:

```dart
class LoadCustomerProfileUseCase {
  const LoadCustomerProfileUseCase(this._repository);

  final CustomerProfileRepository _repository;

  Future<CustomerProfileData> call({required String customerId}) {
    return _repository.loadProfile(customerId: customerId);
  }
}
```

**Step 2: Update cubit to call use case**

Replace direct repository usage in the cubit with the new use case dependency.

**Step 3: Keep behavior stable**

Preserve current loading/success/error emission behavior.

**Step 4: Run the widget test**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/customer_profile test/customer_profile/customer_profile_screen_test.dart
git commit -m "refactor: add customer profile use case layer"
```

### Task 8: Move customer profile presentation into feature module

**Files:**
- Move: `lib/presentation/pages/customer_profile/*`
- Create/Modify: matching files under `lib/features/customer_profile/presentation/`
- Modify: imports in root app entry and tests

**Step 1: Move cubit, pages, tabs, and widgets**

Suggested destinations:
- screen/page files -> `presentation/pages/`
- cubit/state -> `presentation/cubit/`
- reusable feature widgets -> `presentation/widgets/`

**Step 2: Update all imports**

Ensure tests and root app imports reference the new feature paths only.

**Step 3: Run customer profile test**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

**Step 4: Commit**

```bash
git add lib/features/customer_profile lib/presentation/pages/customer_profile lib/main.dart lib/app test/customer_profile/customer_profile_screen_test.dart
git commit -m "refactor: move customer profile presentation into feature module"
```

### Task 9: Create and migrate the `home` feature module

**Files:**
- Create: `lib/features/home/...`
- Move/Modify: `lib/infrastructure/repositories/home/*`
- Move/Modify: `lib/presentation/pages/home/*`

**Step 1: Scaffold the feature folders**

Match the same pattern used in `customer_profile`.

**Step 2: Move home models into domain**

Current `presentation/pages/home/models/*` should move into `domain/entities/`.

**Step 3: Add use cases**

Introduce focused home use cases for the data currently loaded by `HomeCubit`.

**Step 4: Move presentation and update imports**

Relocate `home_screen`, cubit/state, models, and widgets into the new feature module.

**Step 5: Add or update focused tests**

If no home test exists, add a smoke test for `HomeScreen`.

**Step 6: Run tests**

Run: `flutter test`
Expected: PASS for existing and new tests

**Step 7: Commit**

```bash
git add lib/features/home lib/infrastructure/repositories/home lib/presentation/pages/home test
git commit -m "refactor: migrate home into feature module"
```

### Task 10: Create and migrate the `cart` feature module

**Files:**
- Create: `lib/features/cart/...`
- Move/Modify: `lib/presentation/pages/cart/*`

**Step 1: Scaffold the feature folders**

Create `di`, `domain/entities`, `infrastructure/repositories`, `presentation/blocs`, `presentation/pages`, `presentation/widgets`, and `use_cases`.

**Step 2: Move cart models into domain**

Current candidates:
- `booking_cart.dart`
- `category_item.dart`
- `service_item.dart`

**Step 3: Normalize state management placement**

Move:
- `scanner_cubit.dart` -> `presentation/cubit/` or `presentation/blocs/` based on chosen convention
- `blocs/cart_list/*` -> `presentation/blocs/cart_list/*`

**Step 4: Move page and widgets**

Relocate `cart_screen.dart` and `widget/booking_cart_card.dart`.

**Step 5: Add focused cart test coverage**

Add at least a smoke test for `CartScreen` if none exists.

**Step 6: Run tests**

Run: `flutter test`
Expected: PASS

**Step 7: Commit**

```bash
git add lib/features/cart lib/presentation/pages/cart test
git commit -m "refactor: migrate cart into feature module"
```

### Task 11: Add app DI and route composition

**Files:**
- Create: `lib/app/di/app_locator.dart`
- Create: `lib/app/router/app_router.dart`
- Modify: `lib/app/bootstrap/app.dart`
- Modify: root imports to consume feature entrypoints

**Step 1: Centralize app wiring**

Move app composition concerns out of `main.dart` and into the new app layer.

Initial scope can keep manual construction where appropriate, but all construction should flow through the app layer.

**Step 2: Prepare for module-level DI**

Expose registration functions for each feature, even if some dependencies remain simple constructors in the first pass.

**Step 3: Verify tests**

Run: `flutter test`
Expected: PASS

**Step 4: Commit**

```bash
git add lib/app lib/features test
git commit -m "refactor: centralize app composition"
```

### Task 12: Remove obsolete paths and finalize imports

**Files:**
- Delete/Modify: old `lib/helper/*`
- Delete/Modify: old `lib/infrastructure/repositories/*`
- Delete/Modify: old `lib/presentation/pages/*`
- Delete/Modify: old `lib/presentation/widgets/*`
- Modify: all imports across `lib/` and `test/`

**Step 1: Confirm no code imports old paths**

Run: `rg "lib/(helper|infrastructure/repositories|presentation/pages|presentation/widgets)" lib test`
Expected: no matches

**Step 2: Remove obsolete files and folders**

Delete only what is fully replaced by the new structure.

**Step 3: Run final verification**

Run: `flutter test`
Expected: PASS

**Step 4: Commit**

```bash
git add lib test
git commit -m "refactor: remove legacy project structure"
```

### Task 13: Final cleanup and documentation pass

**Files:**
- Modify: `README.md`
- Modify: `docs/base_structure.md` if alignment notes are needed

**Step 1: Document the live structure**

Update top-level project documentation to reflect the final structure used in the repo.

**Step 2: Run final tests**

Run: `flutter test`
Expected: PASS

**Step 3: Commit**

```bash
git add README.md docs/base_structure.md
git commit -m "docs: document refactored project structure"
```
