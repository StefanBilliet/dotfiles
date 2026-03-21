---
name: csharp-oo-review
description: Review C# object-oriented code with SRP, cohesion, behavior placement, and dependency direction as the primary lenses.
---

## Core philosophy

Use the Single Responsibility Principle (SRP) as the primary review lens.

Assume many OO design problems are downstream effects of mixed responsibilities, weak cohesion, misplaced behavior, or poor dependency direction.

For every unit (class, interface, method, module), ask:

- What is this responsible for?
- Is that responsibility singular and cohesive?
- Does it have multiple reasons to change?
- Does its API express one concept or several?
- Are its dependencies aligned with that responsibility?
- Is the abstraction meaningful, or merely ceremonial?

Treat testability, extensibility, and maintainability as consequences of good responsibility boundaries, not separate goals in isolation.

—

## Review priorities (strict order)

1. Responsibility and cohesion
2. Behavior placement
3. Dependency direction
4. API and abstraction quality
5. Testability shaped by design
6. Pattern overuse and accidental complexity
7. Minor implementation refinements

—

## Responsibility and cohesion

Flag when:

- a class mixes orchestration, business rules, persistence, mapping, validation, or side effects
- methods in the same type do not belong to one coherent concept
- a class has multiple reasons to change
- constructor dependency count suggests mixed responsibilities
- class or method naming is broad enough to hide vague ownership

Be explicit about what distinct responsibilities are being mixed.

—

## Behavior placement

Flag when:

- domain decisions live in controllers, handlers, or infrastructure
- entities are hollow data carriers while business decisions are scattered elsewhere
- application services contain detailed domain rules that belong deeper
- behavior is placed where it is convenient rather than where it conceptually belongs

Ask: where should this decision naturally live?

—

## Dependency direction

Flag when:

- high-level policy depends on low-level details
- domain logic depends on infrastructure or framework concerns
- classes depend on details for convenience rather than conceptual need
- boundaries are crossed in a way that increases coupling

Prefer dependency direction that protects domain meaning and high-level policy from low-level implementation detail.

—

## API and abstraction quality

Flag when:

- public APIs are vague or oversized
- boolean parameters significantly alter behavior
- a type exposes multiple concepts behind one name
- interfaces exist without a meaningful boundary
- abstraction adds indirection without reducing coupling
- names like Manager, Helper, Processor, Utility, or Service hide weak ownership

Do not assume abstraction is good by default.

—

## Methods

Flag when:

- a method performs several distinct steps with different reasons to change
- a method mixes decision-making and execution detail
- the method name hides multiple operations
- the method needs too much context to do its work

Extraction alone is not sufficient unless it clarifies responsibility.

—

## Testability

Flag when:

- mixed responsibilities force broad integration-style tests
- behavior is hard to test in isolation because it is placed in the wrong unit
- seams are artificial rather than natural
- mocking burden is high because dependencies are too broad

Treat these as design signals, not just testing issues.

—

## Pattern overuse / accidental complexity

Flag when:

- layers exist without meaningful ownership
- patterns are applied mechanically
- interfaces, factories, repositories, or mappers are present without real architectural benefit
- indirection exceeds the complexity of the problem

Do not reward architecture theatre.

—

## Cosmetic decomposition

Do NOT confuse splitting code with improving design.

Flag cases where complexity is merely redistributed:

- a large class becomes several vague helper classes
- a service delegates to many thin wrappers without clarifying ownership
- methods are extracted but behavior placement remains wrong
- interfaces are introduced without a real seam

Extraction without stronger responsibility boundaries is not meaningful improvement.

—

## Output format

### Summary
Short assessment (2–5 sentences) describing overall design quality and main architectural risks.

### Findings

Group findings by severity:

#### High
Issues that materially harm maintainability, correctness, or architectural clarity.

#### Medium
Important design issues worth addressing.

#### Low
Minor refinements.

Each finding must include:

- **Title**
- **Why it matters**
- **Evidence**
- **Suggested direction**

### Testability gaps

Only design-related issues.

### Refactor opportunities

Only meaningful structural improvements.

—

## Review style

- Be direct and precise
- Use language like:
  - mixes responsibilities
  - weak cohesion
  - multiple reasons to change
  - behavior is misplaced
  - abstraction without ownership
  - indirection without benefit
- Avoid vague slogans
- Do not recommend adding abstractions by default
- Do not rewrite code unless explicitly asked