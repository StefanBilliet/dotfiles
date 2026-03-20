---
name: react-component-workflow
description: Orchestrates a React workflow where static UI exploration happens in Storybook first, then one approved variant is extracted and behavior is implemented via the strict-tdd-coder sub-agent.
license: MIT
compatibility: opencode
---

# react-component-workflow

## Purpose

Guide React UI work through a strict separation of concerns:

1. Static visual exploration (Storybook)
2. Extraction of one approved variant
3. Behavioral implementation via strict TDD

This skill is responsible for **workflow and delegation**, not implementation.

---

## Core Principles

- Storybook comes first for new UI work
- Storybook is strictly static and visual
- Behavior is introduced only after extraction
- Behavior is always delegated to `strict-tdd-coder`
- Do not mix visual composition and behavior
- Avoid premature abstraction
- Keep steps small and explicit

---

## Execution Model

This workflow is executed through specialized sub-agents.

### Phase 1 — Storybook

Delegate to: `storybook-composer`

Responsibilities:
- create or refine static Storybook stories
- explore layout, hierarchy, and composition
- represent visual scenarios explicitly
- compose UI from existing components where possible
- make the intended visual structure visible without implementing runtime rules

Constraints:
- do not introduce runtime behavior
- do not solve Storybook gaps by inventing future-ready component APIs
- do not generalize the component for scenarios beyond the approved mockup

---

### Phase 2 — Extraction

Performed before behavior begins.

Responsibilities:
- select one approved Storybook variant
- extract it into a React component
- keep the extracted component static

Constraints:
- extract only one variant
- no state, hooks, or effects
- no runtime behavior
- no premature props or abstractions

---

### Phase 3 — Behavior Implementation

Delegate to: `strict-tdd-coder`

Responsibilities:
- introduce runtime behavior
- implement interactions, state, and logic
- define and modify tests
- drive implementation through strict TDD

Constraints:
- do not implement behavior directly
- do not write tests directly
- do not simulate TDD steps manually
- do not bypass the TDD agent

Contract:
1. ensure extraction has occurred
2. hand over completely to `strict-tdd-coder`
3. do not resume control unless explicitly requested

---

## Routing Rules

Use `storybook-composer` when:
- creating a new UI
- exploring layout and structure
- defining visual variants
- refining Storybook stories

Use `strict-tdd-coder` when:
- behavior is required
- user interaction is introduced
- state is introduced
- conditional rendering is introduced as real runtime behavior
- logic affects runtime output

If a request mixes both:
1. delegate to `storybook-composer`
2. extract one variant
3. delegate to `strict-tdd-coder`

If unclear:

- visual structure → `storybook-composer`
- runtime behavior → `strict-tdd-coder`

---

## Phase 1 — Storybook Rules

### Goal

Make the intended UI visible without implementing behavior.

### Rules

- static rendering only
- no hooks
- no effects
- no reducers
- no async logic
- no data fetching
- no business logic
- no real event handling

### Static markup rule

During Storybook composition, existing components **may be edited** to add **direct static presentational markup** when needed to make the approved visual scenario visible.

Allowed examples:
- static text
- static labels
- static badges
- static helper text
- static layout wrappers
- hardcoded presentational markup for the approved mockup

Forbidden during Storybook composition:
- new props introduced only to drive mockup-only UI
- conditional rendering introduced only to support mockup-only UI
- derived display logic introduced only to support mockup-only UI
- premature generalization for future scenarios
- refactoring toward a reusable production-ready API

### Variants

- represent variants as separate stories
- duplication is allowed
- optimize for clarity, not reuse
- do not abstract variants into props yet

### Accessibility

- use semantic HTML
- include accessible labels and roles

### Interpretation Rule

Visual states do not imply behavior.

Examples:
- loading
- empty
- error
- disabled
- expanded / collapsed

These are visual only unless explicitly requested as behavior.

### Boundary rule

Use this distinction:

- **static presentation** is allowed in Storybook phase
- **dynamic presentation** belongs to extraction or behavior work

If the requested visual scenario cannot be represented with static markup alone, stop and state that the request has crossed into extraction or behavior work.

---

## Phase 2 — Extraction Rules

### Trigger

- a static Storybook variant is approved

### Rules

- extract only one variant
- keep component static
- no state or effects
- no premature props
- no generalization across variants

### Goal

Create the smallest possible component that matches the static mockup.

---

## General Constraints

- do not mix Storybook and behavior work
- do not skip phases
- do not jump to full implementation
- keep diffs small
- prefer incremental steps
- do not infer behavior from mockups
- do not introduce abstractions without evidence

---

## Heuristics

- duplication in Storybook is acceptable
- duplication in static mockup markup is acceptable
- duplication in components is a signal, not an immediate problem
- if unsure about phase, stop and determine phase first
- prefer explicit over clever
- prefer hardcoded static presentation over premature generalization during Storybook phase

---

## Anti-Patterns

- implementing behavior in Storybook
- adding hooks during mockup phase
- prematurely designing props
- adding props only to support Storybook-only visuals
- adding conditionals only to support Storybook-only visuals
- deriving display rules for Storybook-only visuals
- combining all variants into one component early
- bypassing the TDD agent
- large, mixed-concern changes
- treating Storybook as production code

---

## Expected Behavior

When this skill is active:

- default to Storybook-first for UI work
- delegate visual work to `storybook-composer`
- allow static presentational edits during Storybook phase
- forbid dynamic presentation during Storybook phase
- delegate behavior to `strict-tdd-coder`
- extract before implementing behavior
- proceed in phases, not in one pass

If the current phase is unclear, stop and clarify before continuing.

---

## Summary

- Storybook = static visual exploration
- Static markup may be added during Storybook phase
- Dynamic presentation is not allowed during Storybook phase
- Extraction = single variant, still static
- Behavior = handled by `strict-tdd-coder`

Delegation:

- `storybook-composer` → UI
- `strict-tdd-coder` → behavior