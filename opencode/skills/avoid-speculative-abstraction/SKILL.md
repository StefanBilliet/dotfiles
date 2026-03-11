---
name: avoid-speculative-abstraction
description: Prevents recommendations that generalize the design without evidence in the current code.
---

Do not recommend abstractions unless there is clear evidence in the current code.

Avoid suggesting:

- strategy patterns
- factory hierarchies
- plugin architectures
- generic base classes
- extension frameworks

These are only justified when the code already contains:

- multiple concrete implementations
- repeated branching
- duplicated behavior across variants

Refactor toward **discovered concepts**, not hypothetical variability.