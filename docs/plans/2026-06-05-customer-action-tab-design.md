# Customer Action Tab Design

**Goal:** Build the `Tương tác` tab to visually match the provided timeline mock as closely as possible while reusing the existing `CustomerProfileLoaded.data.activities` list.

**Approach:** Render a light, compact interaction timeline with filter chips at the top and stacked cards below. Each card maps an activity type to a visual style, summary rows, colored status chip, and optional extra lines such as services or total amount to mirror the mock.

**Key Decisions:**
- Use `CustomerActivityModel` as the primary source instead of a disconnected mock-only widget.
- Keep filter state local inside `CustomActionTab`.
- Use a `Wrap`/horizontal chip row for `Tất cả`, `Booking`, `Phiếu khám`, `Thanh toán`.
- Show a vertical timeline rail with colored dots and lightweight cards.
- Add small UI-only helpers for relative time, status colors, and card-specific labels.

**Validation:**
- The tab should scroll cleanly inside the existing `TabBarView`.
- The layout should visually resemble the screenshot: compact pills, left timeline, white cards, colored headings, and muted metadata.
