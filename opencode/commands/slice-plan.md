---
description: Create a scratchpad plan of tested, committable vertical slices
---

Create a scratchpad implementation plan for the following work:

`$ARGUMENTS`

## Ground Rules

- Work in the current repository and follow all repository instructions, domain documentation, and established conventions.
- Inspect the relevant code, tests, and dependency paths before planning. Do not infer the change surface from filenames alone.
- Ask one concise question only when a missing decision genuinely blocks a safe plan. Otherwise proceed autonomously.
- This command is planning-only. Do not modify production code, tests, configuration, migrations, or documentation outside the new scratchpad.
- Do not stage or commit anything, run mutating commands, or begin implementing the plan.

## Create The Scratchpad

Create `.scratchpad/` at the repository root if needed, then create a new Markdown file named `YYYY-MM-DD-kebab-case-title.md`. Never overwrite an existing scratchpad; add a numeric suffix when necessary.

Immediately after creating the file, output its absolute `file://` URL as a clickable Markdown link so the user can open it while work continues. URL-encode spaces and other characters when needed. Always repeat this link in the final report.

The scratchpad is an operational ledger, not a speculative design document. Include:

1. **Goal**: the observable outcome and why it matters.
2. **Scope**: what is included, excluded, and any assumptions.
3. **Current State**: relevant behavior, architecture, tests, and constraints discovered in the repository.
4. **Change Surface**: concrete files, symbols, modules, contracts, migrations, configuration, and tests likely to change, with a short reason for each. Mark uncertain entries explicitly.
5. **Suggested Baseline**: the focused validation commands to run before implementation and any pre-existing failures already observed during discovery. Do not run these commands as part of this planning command.
6. **Checkpoints**: an ordered checklist of vertical slices.
7. **Final Validation**: broader tests, linting, type checking, builds, or manual checks appropriate to the repository.

## Design The Checkpoints

Each checkpoint must deliver the smallest coherent behavior slice that can be tested and committed independently. Prefer a thin end-to-end path across the necessary layers over separate checkpoints such as "database", "backend", "frontend", and "tests".

For every checkpoint record:

- **Status**: `pending`, `in progress`, `blocked`, or `complete`.
- **Outcome**: the behavior or capability completed by this slice.
- **Change area**: the specific files, symbols, and boundaries expected to change.
- **Tests first**: the test or observable verification that will prove the behavior, including meaningful edge or failure cases.
- **Validation**: exact focused commands to run before committing.
- **Commit intent**: a concise description of the single change the commit will contain.
- **Dependencies or risks**: only concrete sequencing constraints or uncertainties.

Keep foundational work inside the first slice that needs it. Create a setup-only checkpoint only when it has independently verifiable value. Split a checkpoint when it has multiple reasons to change, cannot be reviewed as one idea, or requires unrelated validation. Merge checkpoints that would leave the repository in a knowingly incomplete or untestable state.

## Finish

After writing the scratchpad, stop. Do not execute any checkpoint. Report only:

- the scratchpad path and clickable absolute `file://` URL;
- the number and names of the planned checkpoints;
- any assumptions or unresolved decisions captured in the plan.

Do not commit the scratchpad when the repository intentionally ignores `.scratchpad/`.
