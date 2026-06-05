# Customer Payment Model Design

**Goal:** Refactor the payment tab to use a typed domain model and repository-provided data, matching the architecture already used by the other customer profile tabs.

**Approach:** Introduce a `CustomerPaymentTransactionModel` entity in `domain/entities`, add a `paymentTransactions` field to `CustomerProfileData`, populate it in `CustomerProfileRepositoryImpl`, and update `CustomPaymentTab` plus `CustomerProfileScreen` to consume the typed list instead of `Map<String, dynamic>`.

**Key Decisions:**
- Keep the payment tab UI behavior the same for now; only replace the backing data structure.
- Store the payment mock list in the repository, not inside the widget.
- Keep filtering local in the payment tab, but make it filter typed models by `status`.

**Validation:**
- Add a repository test that expects `loadProfile()` to return non-empty `paymentTransactions`.
- Run the focused repository test after the refactor.
