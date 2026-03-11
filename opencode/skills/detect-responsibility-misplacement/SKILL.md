---
name: detect-responsibility-misplacement
description: Detects behavior located far from the data or concept it belongs to.
---

Look for behavior that is detached from the data it operates on.

Common signals:

- static helper classes accumulating unrelated logic
- services manipulating raw data objects heavily
- logic spread across multiple files manipulating the same concept
- methods passing data through several layers before acting on it

Questions to ask:

Where does this behavior *belong*?

Would the design be clearer if the behavior lived closer to the concept it operates on?

Prefer:

behavior near the data it affects.

Avoid:

procedural orchestration scattered across helpers.