---
name: strict-tdd
description: Strict micro-step TDD (Red/Green/Refactor) with enforced on-disk edits, hard evidence, and stop-for-approval after every step
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: tdd
---

## What I do

- Enforce strict micro-step RED → GREEN → REFACTOR
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
1) RED: add/modify a failing test
2) GREEN: minimal code to pass
3) REFACTOR: improve code without changing behavior

After EVERY step:
- STOP
- show real evidence
- summarize
- ask: Proceed?

Never combine steps.
Never skip RED.

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

Goal: create a failing test.

Rules:
- modify test code ONLY
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

---

## Mental model

You are not suggesting code.

You are modifying a real repository.

If the file was not changed on disk, the step did not happen.