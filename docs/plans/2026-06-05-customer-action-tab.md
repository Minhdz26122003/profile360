# Customer Action Tab Implementation Plan

> **For Antigravity:** REQUIRED WORKFLOW: Use `.agent/workflows/execute-plan.md` to execute this plan in single-flow mode.

**Goal:** Create the customer profile `Tương tác` tab as a screenshot-like interaction timeline using existing activity data.

**Architecture:** Pass `CustomerProfileData.activities` from `customer_profile_screen.dart` into `CustomActionTab`, then let the tab manage a local selected filter and render filtered timeline cards. Use small private UI helpers in the tab file for pills, timeline dots, status chips, and activity-specific row content.

**Tech Stack:** Flutter, Material, flutter_bloc

---

### Task 1: Wire the tab to real activity data

**Files:**
- Modify: `lib/features/customer_profile/presentation/pages/customer_profile_screen.dart`
- Modify: `lib/features/customer_profile/presentation/pages/custom_action_tab.dart`

**Step 1: Write the failing test**

Add a widget test that expects the interaction tab to render at least one activity title after loading.

**Step 2: Run test to verify it fails**

Run: `flutter test test/customer_profile/customer_action_tab_test.dart`
Expected: FAIL because `CustomActionTab` is still a placeholder.

**Step 3: Write minimal implementation**

Pass `data.activities` into `CustomActionTab` and update the tab constructor accordingly.

**Step 4: Run test to verify it passes**

Run: `flutter test test/customer_profile/customer_action_tab_test.dart`
Expected: PASS

### Task 2: Build the timeline UI and local filters

**Files:**
- Modify: `lib/features/customer_profile/presentation/pages/custom_action_tab.dart`

**Step 1: Write the failing test**

Extend the test to expect filter pills and at least one rendered timeline card.

**Step 2: Run test to verify it fails**

Run: `flutter test test/customer_profile/customer_action_tab_test.dart`
Expected: FAIL because the placeholder has no timeline UI.

**Step 3: Write minimal implementation**

Replace the placeholder with:
- top filter pills
- filtered local list
- left-side timeline rail
- compact cards with metadata, title, rows, status chip, and optional service block

**Step 4: Run test to verify it passes**

Run: `flutter test test/customer_profile/customer_action_tab_test.dart`
Expected: PASS

### Task 3: Final visual cleanup and verification

**Files:**
- Modify: `lib/features/customer_profile/presentation/pages/custom_action_tab.dart`
- Modify: `lib/features/customer_profile/presentation/pages/customer_profile_screen.dart`

**Step 1: Run focused verification**

Run: `flutter analyze lib/features/customer_profile/presentation/pages/custom_action_tab.dart lib/features/customer_profile/presentation/pages/customer_profile_screen.dart`
Expected: exit code 0
