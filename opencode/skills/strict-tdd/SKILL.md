---
name: strict-tdd
description: Strict micro-step TDD (Red/Green/Refactor) with enforced on-disk edits, hard evidence, one failing test at a time, and stop-for-approval after every step
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: tdd
---

## What I do

- Enforce strict micro-step RED → GREEN → REFACTOR
- Require exactly one failing test at a time
- Require a hard stop and explicit user approval after every step
- Require real on-disk changes (not simulated)
- Require evidence tied to actual edits
- Prevent fake completion and narrative-only steps

---

## When to use me

Use ONLY when changing runtime behavior:
- production code
- tests
- runtime-affecting config

Do NOT use for:
- documentation
- analysis
- formatting
- planning

If unsure, ask.

---

## Core contract (non-negotiable)

All behavioral changes follow:

RED → GREEN → REFACTOR

A step is exactly ONE of:
1) RED: add/modify exactly one failing test for exactly one behavior
2) GREEN: minimal code to pass that test
3) REFACTOR: improve code without changing behavior

After EVERY step:
- STOP
- show real evidence
- summarize
- ask: Proceed?

Never combine steps.
Never skip RED.
Never continue automatically.

---

## 🚨 CRITICAL: One test at a time

During RED, you may add or modify exactly ONE test only.

That test must cover exactly ONE behavior.

Do NOT in RED:
- add multiple tests
- add parameterized cases
- add happy path plus edge cases together
- add multiple assertions for different behaviors
- add future-facing assertions
- edit unrelated tests

If a test would require multiple conceptual code changes to pass, it is too large and must be split.

If multiple tests are possible, choose the smallest one first.

During GREEN, only make the minimum change needed to pass the current failing test.

Do NOT in GREEN:
- proactively satisfy future tests
- add extra behavior
- refactor
- expand scope because it seems cleaner

If more than one test moved forward, the step was too large.

---

## Test naming and structure

Use GIVEN...WHEN...THEN...
Only add GIVEN when GIVEN is a real domain precondition.

A GIVEN must describe meaningful prior domain state that affects the test outcome.
Do not use GIVEN for:
- SUT construction
- input object creation
- fixture setup
- generic boilerplate needed to run the test

If the setup only exists so the test can execute, it is arrange/setup, not GIVEN.

If there is no real domain precondition, name the test WHEN...THEN... only.

Tests must follow arrange-act-assert flow, but do not add arrange/act/assert comments.
Keep each test to at most 3 logical paragraphs.
Use this shape when possible:
- paragraph 1: setup / GIVEN
- paragraph 2: action / WHEN
- paragraph 3: assertions / THEN

This structure does NOT justify broader scope.
A test must still cover exactly ONE behavior.

---

## 🚨 CRITICAL: Tool execution requirement

Printing code is NOT a valid change.

A step is ONLY valid if:
- a file was actually modified on disk using the edit/write mechanism

If you did not modify a file on disk, you MUST output exactly:

FAILED_TO_EDIT

Do NOT:
- simulate edits
- describe intended changes
- present code as if it was applied

---

## 🚨 CRITICAL: No fake state

You may ONLY claim files changed if:
- the edit/write tool succeeded in this turn

Otherwise:

FAILED_TO_EDIT

Never claim success without an actual edit.

---

## 🚨 CRITICAL: Evidence must reflect real state

After a successful edit, you MUST provide evidence tied to the actual change.

Allowed evidence:
- diff of the file
- exact modified block from the file

This must reflect what is now on disk.

---

## Micro-step discipline

### RED

Goal: create exactly one failing test.

Rules:
- modify test code ONLY
- add or modify exactly one test
- failure must be meaningful
- do not touch production code

Execution requirements:
1) Perform file edit FIRST
2) If edit fails → FAILED_TO_EDIT

Output:

Applied on disk:
<exact file path(s)>

Edit evidence:
<diff or exact modified test block>

Command:
<test command>

Expected result:
fail

Then STOP and ask: Proceed?

---

### GREEN

Goal: minimal implementation to pass test.

Rules:
- smallest possible change
- only what is needed for the current failing test
- no refactoring
- no extras

Execution requirements:
1) Perform file edit FIRST
2) If edit fails → FAILED_TO_EDIT

Output:

Applied on disk:
<exact file path(s)>

Edit evidence:
<diff or modified code>

Command:
<test command>

Expected result:
pass

Then STOP and ask: Proceed?

---

### REFACTOR

Goal: improve code without changing behavior.

Before applying:

You MUST state:
- what will change
- why it improves code
- files affected
- public API impact

If:
- multiple files
- structural changes
- public API touched

STOP and ask BEFORE editing.

After approval and edit:

Applied on disk:
<files>

Edit evidence:
<diff>

Command:
<test command>

Expected result:
pass

Then STOP and ask: Proceed?

---

## Public API / contract changes (strict)

If affecting:
- public methods
- constructors
- serialized formats
- external contracts

You MUST:
1) Explain change
2) Explain impact
3) State breaking or not
4) STOP for approval BEFORE editing

---

## Guardrails

- no unrelated refactors
- no new dependencies
- no restructuring
- no scope expansion

If multiple approaches exist:
propose and STOP

---

## Step summary (ONLY after successful edit)

Phase: RED | GREEN | REFACTOR  
Files changed:
<actual files>

What changed:
<brief factual description>

---

## Output order (STRICT)

1. Applied on disk
2. Edit evidence
3. Command
4. Expected result
5. Step summary
6. Proceed?

---

## Important constraints

- No edit → FAILED_TO_EDIT
- No fake summaries
- No code-only answers
- No skipped steps
- No multiple tests in one RED step
- No multiple behaviors in one test

---

## Mental model

You are not suggesting code.

You are modifying a real repository.

If the file was not changed on disk, the step did not happen.

If more than one test moved forward, the step was too large.