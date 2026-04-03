---
name: component-extractor
description: Extracts one approved static Storybook mockup into the smallest possible static React component before any behavior is introduced.
license: MIT
compatibility: opencode
---

# component-extractor

## Purpose

Extract one approved static Storybook mockup into a React component.

This skill exists to preserve a clean phase boundary between:

1. static visual exploration
2. static component extraction
3. behavioral implementation

This skill is responsible only for creating the smallest possible static component boundary.

This skill is **not** responsible for:

- runtime behavior
- hooks
- effects
- TDD
- state
- business logic
- premature generalization

---

## Core Principles

- extract only after a static mockup exists
- extract only one approved variant
- keep the extracted component static
- create the smallest possible component boundary
- do not generalize early
- do not introduce behavior
- do not design future-ready props
- preserve the visual structure from the mockup

---

## Allowed Work

It is allowed to:

- create a new React component from approved static mockup markup
- move static JSX from a story or existing component into the extracted component
- wire the story to render the extracted component
- wire the parent component to render the extracted component
- keep hardcoded static content if it belongs to the approved variant
- perform minimal renaming needed to make the extracted component coherent

---

## Forbidden Work

Do not introduce:

- hooks
- effects
- reducers
- async logic
- data fetching
- business logic
- runtime event handling
- ternaries
- `if` statements used for runtime rendering
- state
- behavior
- reusable APIs invented for hypothetical future cases
- props added only to support future variants
- multi-variant generalization
- behavior inferred from visual states

Do not extract multiple variants.
Do not implement runtime switching.
Do not “improve” the component beyond the approved static variant.

---

## Preconditions

Only proceed if all of the following are true:

- a static Storybook mockup already exists
- one specific variant has been selected for extraction
- the extracted result is intended to remain static in this phase

If these conditions are not met, stop and say so.

---

## Extraction Rules

### Single Variant Rule

Extract exactly one approved static variant.

- do not combine multiple variants
- do not unify multiple stories into one configurable component
- do not add props to support variants not yet extracted

### Minimal Boundary Rule

Create the smallest sensible component boundary.

- extract only the part that has clearly become its own UI boundary
- do not over-extract tiny incidental markup
- do not leave a visually substantial new boundary buried inline

### Static Rule

The extracted component must remain static.

- no behavior
- no hooks
- no state
- no runtime rendering logic

### Hardcoding Rule

Hardcoded static content is acceptable in this phase.

Prefer hardcoded static presentation over premature prop design.

### Story Preservation Rule

After extraction, the story must still render the approved visual result.

If the parent component is part of the extraction path, it may be updated to render the extracted component, but still statically.

---

## Decision Rules

### Proceed automatically when extraction target is clear

Do not ask the user when:

- one approved static variant is clearly identified
- the boundary to extract is obvious
- the extracted component can remain static

### Stop and ask when extraction boundary is ambiguous

If it is unclear:

- exactly what should be extracted
- whether the new markup is substantial enough to deserve a component
- whether the selected variant is actually approved
- whether extraction would require introducing premature props or logic

STOP and ask the user.

Do not guess.

---

## Required Question Format for Ambiguous Extraction Cases

When asking the user, use this format:

I need to extract a static component boundary, but the target is unclear.

Please confirm:
1. which specific static variant should be extracted
2. what exact UI boundary should become the new component

Do not continue until the user answers.

---

## Exit Criteria

An extraction phase is complete only if all of the following are true:

- exactly one approved static variant was extracted
- a new component boundary now exists
- the extracted component is static
- no hooks, effects, state, ternaries, or runtime conditionals were introduced
- the story still renders the approved visual result
- no premature generalized API was introduced

If any of these are not true, the extraction phase is not complete.

---

## Mandatory Output Contract

At the end of every run, output exactly this structure:

```md
PHASE: extraction
EXTRACTION_RESULT: extracted | stopped-for-user-decision | preconditions-not-met
EXTRACTED_COMPONENT:
SOURCE_VARIANT:
FILES_CHANGED:
STATIC_ONLY_CONFIRMED: yes | no
PARENT_UPDATED: yes | no
STORY_PRESERVED: yes | no
PREMATURE_ABSTRACTION_INTRODUCED: yes | no
REASON:
NEXT_STEP:
```
