---
name: react-srp-review
description: React + TypeScript + Vite code review with SRP as the primary lens. Focus on responsibilities, boundaries, and maintainable UI architecture.
---

## Core philosophy

Use the Single Responsibility Principle (SRP) as the primary review lens.

Assume most React design problems are downstream effects of mixed responsibilities.

For every unit (component, hook, module), ask:

- What is this responsible for?
- Is that responsibility singular and coherent?
- Does it have more than one reason to change?
- Is complexity reduced, or merely moved elsewhere?

Treat issues like prop sprawl, state confusion, effect complexity, and poor testability as **symptoms of unclear responsibilities**, not isolated problems.

—

## Review priorities (strict order)

1. Responsibility and boundaries (SRP)
2. State ownership and data flow (as a consequence of SRP)
3. Component and hook design
4. React correctness issues that affect maintainability
5. Testability shaped by design
6. Performance (only when concrete and relevant)
7. Style (only when it impacts clarity)

—

## Responsibility analysis

A unit likely violates SRP when it mixes:

- rendering and orchestration
- rendering and domain/business logic
- data fetching and UI logic
- state management and formatting
- navigation and interaction handling
- multiple UI concerns that evolve independently

Be explicit:
- name the different responsibilities
- explain why they change for different reasons

—

## Component boundaries

Flag when:

- a component orchestrates data AND renders detailed UI
- a reusable component contains page-specific logic
- props are numerous or reveal leaky abstractions
- branching logic suggests multiple concerns are packed together
- the component would change for unrelated reasons

—

## Hooks

Flag when:

- a hook bundles unrelated concerns
- a hook mixes server state, UI state, and domain rules
- the hook API is vague or too broad
- complexity is hidden but not reduced

A hook should represent a **single meaningful concern**, not act as a dumping ground.

—

## State ownership

Flag when:

- state is lifted too high or kept too low
- derived state is stored instead of derived
- multiple sources of truth exist
- server state is copied into local state without strong reason
- UI state and domain state are mixed

State location should follow responsibility boundaries.

—

## React correctness (only when meaningful)

Flag when:

- effects are used for logic that belongs in render or events
- dependency arrays are incorrect or fragile
- effects coordinate too many concerns
- stale closure risks exist
- list keys are unstable
- memoization is used without clear benefit

Do not nitpick—only call out issues that matter.

—

## Data flow and architecture

Flag when:

- data shaping is scattered
- API responses leak into presentational components
- page-level orchestration is unclear
- boundaries between features are blurry

Prefer clear separation:
- page = orchestration
- feature = cohesive UI behavior
- component = focused rendering
- hook = one concern

—

## Testability

Flag when:

- logic is embedded in JSX and hard to verify
- responsibilities are mixed, forcing broad tests
- important decisions are not isolatable
- design forces brittle tests

—

## Cosmetic decomposition (important)

Do NOT assume extraction improves design.

Flag cases where complexity is merely redistributed:

- hooks that still mix concerns
- helpers that exist only to shrink files
- child components that depend on parent-specific logic
- multiple modules that still change together

Extraction without clearer responsibility = no real improvement.

—

## Output format

### Summary
Short assessment (2–5 sentences) describing overall design quality and main risks.

### Findings

Group by severity:

#### High
Real architectural issues affecting maintainability or correctness.

#### Medium
Important design problems.

#### Low
Minor improvements.

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
- Use SRP language:
  - “mixes responsibilities”
  - “multiple reasons to change”
  - “boundary is unclear”
  - “extraction without separation”
- Avoid vague wording
- Prefer fewer, high-value findings over many shallow ones
- Do NOT rewrite code unless explicitly asked