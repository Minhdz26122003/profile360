# Customer Payment Model Implementation Plan

> **For Antigravity:** REQUIRED WORKFLOW: Use `.agent/workflows/execute-plan.md` to execute this plan in single-flow mode.

**Goal:** Move customer payment transaction data out of `CustomPaymentTab` and into the feature's typed domain/repository flow.

**Architecture:** Create a new payment transaction entity, expose it through `CustomerProfileData`, and source mock data from `CustomerProfileRepositoryImpl`. Update the screen to pass the typed list into `CustomPaymentTab`, then refactor the tab to render typed items instead of map lookups.

**Tech Stack:** Flutter, Material, flutter_test, Equatable

---

### Task 1: Add the typed payment model to the data flow

**Files:**
- Create: `lib/features/customer_profile/domain/entities/customer_payment_transaction_model.dart`
- Modify: `lib/features/customer_profile/domain/entities/customer_profile_data.dart`
- Modify: `lib/features/customer_profile/infrastructure/repositories/customer_profile_repository_impl.dart`
- Test: `test/customer_profile/customer_profile_repository_impl_test.dart`

**Step 1: Write the failing test**

Add a repository test that calls `loadProfile()` and expects `paymentTransactions` to contain typed payment entries.

**Step 2: Run test to verify it fails**

Run: `flutter test test/customer_profile/customer_profile_repository_impl_test.dart`
Expected: FAIL because `CustomerProfileData` does not yet expose `paymentTransactions`.

**Step 3: Write minimal implementation**

Create `CustomerPaymentTransactionModel`, add `paymentTransactions` to `CustomerProfileData`, and populate the repository mock.

**Step 4: Run test to verify it passes**

Run: `flutter test test/customer_profile/customer_profile_repository_impl_test.dart`
Expected: PASS

### Task 2: Refactor the payment tab to consume typed data

**Files:**
- Modify: `lib/features/customer_profile/presentation/pages/customer_profile_screen.dart`
- Modify: `lib/features/customer_profile/presentation/pages/custom_payment_tab.dart`

**Step 1: Write the failing test**

Extend or add a widget test that pumps the profile screen and switches to the payment tab, expecting payment content to render.

**Step 2: Run test to verify it fails**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: FAIL if the payment tab constructor or wiring has not been updated.

**Step 3: Write minimal implementation**

Pass `data.paymentTransactions` into `CustomPaymentTab` and replace map indexing with typed property reads.

**Step 4: Run test to verify it passes**

Run: `flutter test test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

### Task 3: Verify the refactor compiles cleanly

**Files:**
- Modify: `lib/features/customer_profile/domain/entities/customer_payment_transaction_model.dart`
- Modify: `lib/features/customer_profile/domain/entities/customer_profile_data.dart`
- Modify: `lib/features/customer_profile/infrastructure/repositories/customer_profile_repository_impl.dart`
- Modify: `lib/features/customer_profile/presentation/pages/customer_profile_screen.dart`
- Modify: `lib/features/customer_profile/presentation/pages/custom_payment_tab.dart`

**Step 1: Run focused tests**

Run: `flutter test test/customer_profile/customer_profile_repository_impl_test.dart test/customer_profile/customer_profile_screen_test.dart`
Expected: PASS

**Step 2: Run analyzer**

Run: `flutter analyze lib/features/customer_profile`
Expected: exit code 0
