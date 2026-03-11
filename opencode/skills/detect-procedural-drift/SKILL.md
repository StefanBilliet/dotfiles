---
name: detect-procedural-drift
description: Detects procedural code patterns emerging inside object-oriented systems.
---

Watch for code that behaves like procedural scripting instead of cohesive objects.

Signals:

- private static helper methods growing in number
- long functions orchestrating multiple unrelated steps
- data passed between several functions before meaningful behavior occurs
- temporary variables carrying domain meaning instead of objects

Procedural drift often appears as:

"utility method accumulation"

Example pattern:

Helper.DoStepA()
Helper.DoStepB()
Helper.DoStepC()

Instead of a cohesive object that owns the behavior.

Flag when procedural structure weakens cohesion.