---
name: strict-tdd
description: Strict micro-step TDD (Red/Green/Refactor) with stop-for-approval after every step
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: tdd
---

## What I do

- Enforce strict micro-step **RED → GREEN → REFACTOR**
- Require a hard stop and explicit user approval after **every** step
- Standardize tests with **GIVEN / WHEN / THEN** naming
- Enforce a clean test body layout (max 3 paragraphs) and `sut`/`_sut` naming
- Prevent silent refactors and silent public API/contract changes

## When to use me

Use this skill ONLY when changing runtime behavior:
- adding/modifying production code
- adding/modifying tests
- changing config that affects runtime behavior

Do NOT force this loop for:
- documentation changes
- analysis/refinement
- formatting-only changes
- planning/ADRs (unless explicitly asked)

If it’s unclear whether a change affects runtime behavior, ask first.

---

## Core contract (non-negotiable)

All behavioral changes follow strict:

**RED → GREEN → REFACTOR**

A “step” is exactly ONE of:
1) **RED**: add/adjust a test so it fails for the correct reason
2) **GREEN**: minimal code to make tests pass
3) **REFACTOR**: cleanup while tests remain green

After EVERY step:
- STOP
- summarize changes (files + short explanation)
- show the exact test command (or what was run)
- state the expected result
- ask: **Proceed?**

Never combine phases.
Never implement before a failing test exists (unless explicitly approved by the user).

---

## Test style rules

### GIVEN / WHEN / THEN (test naming)

- Prefer **GIVEN / WHEN / THEN** structure in test names.
- Use **GIVEN** only when a meaningful precondition exists.
- Otherwise use **WHEN / THEN**.
- GIVEN / WHEN / THEN must be uppercase in test names.

### Test body layout: max three paragraphs (no comment blocks)

Each test body must have at most three logical paragraphs, separated by blank lines only:

1) Setup (only if needed)
2) Act (the invocation of the system under test)
3) Assert (only assertions)

Rules:
- No comment markers like `// GIVEN` / `// WHEN` / `// THEN`
- Do not mix setup, act, and assert in the same paragraph
- The act paragraph must contain only the invocation of the system under test

### System Under Test naming

If the system under test is assigned to a variable/const:
- Always name it `sut`
- Or `_sut` if language conventions require a leading underscore
- Never use alternative names like `service`, `instance`, `target`, etc.

---

## Micro-step discipline

### RED
- Ensure the test fails for the intended reason.
- If it fails due to wiring/typos/compile errors, fix the test until the failure is meaningful.
- Do not change production code yet.

### GREEN
- Implement the smallest change that makes the failing test pass.
- No speculative abstractions.
- No premature optimizations.
- No unrelated cleanups.

### REFACTOR
- Preserve behavior completely; keep tests green.
- Refactor must reduce duplication, improve naming, or improve cohesion.
- Do not introduce new abstractions unless clearly justified.
- If behavior needs to change, start a new RED step.

#### Refactor declaration requirement
Before modifying code during REFACTOR, explicitly state:
- what you plan to refactor
- why it improves the code
- which files are affected
- whether public surface/contracts are involved

If the refactor:
- affects multiple files, or
- significantly changes structure, or
- touches public surface area

Then STOP and ask for approval before applying it.

---

## Public API / contract changes (strict)

If a change affects any:
- public classes/methods
- exported symbols
- constructor signatures
- serialized structures
- external contracts / integration boundaries

Then:
1) explicitly state:
   - what changed
   - why it changed
   - whether it is breaking
   - who/what could be affected
2) STOP and ask for approval BEFORE applying the change (even if a test appears to require it)

Do not silently modify public contracts in RED, GREEN, or REFACTOR.

If a test seems to require changing a public API, first question whether the test expresses the right behavior and propose alternatives before changing the contract.

---

## Guardrails

- Do not refactor unrelated code.
- Do not introduce new dependencies without approval.
- Do not reorganize modules/folders without approval.
- Do not broaden scope beyond the current micro-behavior.
- If multiple strategies exist, propose options and STOP.

---

## Required output after every step

### Step summary
Phase: RED | GREEN | REFACTOR  
Files changed:  
What changed:

### Test run
Command:  
Expected result:

Proceed?