---
name: minimal-refactor-proposal
description: Suggests the smallest structural change that improves design without introducing speculative abstraction.
---

When proposing a refactor:

Prefer the **smallest possible improvement**.

Examples:

- introduce value object
- move method to a better location
- consolidate duplicate logic
- introduce small domain object
- extract cohesive class

Avoid:

- large architectural redesigns
- plugin systems
- frameworks
- speculative extension points

The refactor must be justified by the **current code**, not hypothetical future features.

Always ask:

Would this still be worth doing if no additional features were ever added?