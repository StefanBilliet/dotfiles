---
name: storybook-composer
description: Creates or refines static Storybook mockups for React UI work. Decides whether to use a new story, inline static markup in an existing component, or stop and ask the user when a component-boundary decision is involved.
license: MIT
compatibility: opencode
---

# storybook-composer

## Purpose

Create or refine **static Storybook mockups** for React UI work.

This skill is responsible for:

1. choosing the right mockup approach
2. producing static visual output in Storybook
3. stopping when the request crosses into component-boundary ambiguity

This skill is **not** responsible for:

- runtime behavior
- hooks
- effects
- business logic
- TDD
- production-ready abstractions

---

## Core Principles

- Storybook work is static and visual
- Mockups exist to make UI visible, not to implement behavior
- Visual exploration comes before behavior
- Static markup is allowed
- Dynamic behavior is forbidden
- Boundary decisions matter more than speed
- If a component-boundary decision is ambiguous, ask the user

---

## Allowed Work

During Storybook composition, it is allowed to:

- create a new story
- update an existing story
- add static presentational markup to an existing component
- hardcode static content needed to show the approved visual scenario
- create separate stories for separate static variants
- compose mockups from existing components where possible

Allowed static markup examples:

- text
- labels
- helper text
- badges
- icons
- layout wrappers
- hardcoded presentational sections
- hardcoded empty / success / warning / error visual states

---

## Forbidden Work

Do not introduce:

- hooks
- effects
- reducers
- async logic
- data fetching
- business logic
- real event handling
- runtime conditionals
- ternaries
- `if` statements used for runtime rendering
- derived display logic
- production-ready prop design
- abstractions created only to support the mockup
- reusable APIs invented before extraction
- behavior inferred from visual states

Visual states are allowed only as **separate static stories**, not as runtime logic.

---

## Decision Model

Choose exactly one of these paths.

### Path A — New Component Mockup

Use this path when the request clearly represents a new UI piece or a new component boundary.

Action:

- create a new static story
- keep everything static
- no runtime logic
- no extraction yet
- no behavior

---

### Path B — Existing Component, Single Static Addition

Use this path when the request extends an existing component and the extension can be shown as **one static presentation**.

Heuristic:

- you would not naturally create separate Storybook variants for this addition
- the addition is just there to make the intended UI visible
- no new meaningful sub-boundary is emerging

Action:

- add static hardcoded presentational markup directly to the existing component
- update or add a story showing the result
- keep everything static and hardcoded

Examples:

- one helper text
- one badge
- one label row
- one summary block
- one hardcoded section with one visual presentation

---

### Path C — Existing Component, Separate Subpart Mockup

Use this path when the request extends an existing component but the added subpart has **multiple static variants worth inspecting separately in Storybook**.

This means:

- you would naturally want separate stories for that subpart
- the subpart is visually substantial enough to inspect independently
- the subpart may later become its own extracted component

Action:

- create separate static Storybook variants for the subpart
- do not implement runtime switching
- do not yet extract unless explicitly requested by the workflow
- do not yet incorporate behavior

Examples:

- feedback area with multiple distinct static variants
- status section with multiple inspectable variants
- visually distinct subpart that deserves its own Storybook surface

---

## Ask-vs-Decide Rule

### Decide automatically when it is obvious

Do not ask the user when the classification is clearly one of:

- new component mockup
- existing component with one static addition
- existing component with clearly separate inspectable static variants

### Ask the user when a component-boundary decision is involved and not clearly obvious

If the decision is ambiguous between:

- inline static addition to the existing component
- separate subpart mockup that may later become its own component

STOP and ask the user.

Do not guess.

This is the most important rule in the skill.

---

## Required Question Format for Ambiguous Boundary Cases

When asking the user, use this format:

This change could be handled in two ways:

1. Inline static addition to the existing component
2. Separate subcomponent mockup with its own Storybook variants

Do you want this to become its own component boundary?

Do not ask open-ended vague questions.
Do not continue until the user answers.

---

## Storybook Rules

### Stories

- prefer separate stories for separate static variants
- duplication is acceptable
- optimize for inspectability, not reuse
- do not introduce props just to avoid duplication in stories

### Existing Components

When working on an existing component during Storybook phase:

- static presentational markup may be added directly
- hardcoding is acceptable
- do not add dynamic rendering
- do not add mockup-only props
- do not generalize for future scenarios

### Separate Variants

If multiple variants are worth inspecting:

- represent them as separate stories
- keep each variant static
- do not collapse variants into one runtime-driven component
- do not simulate behavior with logic

### Accessibility

- use semantic HTML
- preserve accessible names and roles where relevant
- do not sacrifice clarity for cleverness

---

## Exit Criteria

A Storybook phase is complete only if all of the following are true:

- a story was created or updated
- the requested visual scenario is visible
- the result is static
- no runtime behavior was introduced
- no hooks, effects, ternaries, or runtime conditionals were introduced
- the chosen mockup path is stated explicitly
- whether later extraction is likely is stated explicitly

If any of these are not true, the phase is not complete.

---

## Mandatory Output Contract

At the end of every run, output exactly this structure:

```md
PHASE: mockup
MOCKUP_PATH: new-component | existing-component-static-addition | separate-subpart-mockup | stopped-for-user-decision
TARGET:
FILES_CHANGED:
STORY_UPDATED: yes | no
STATIC_ONLY_CONFIRMED: yes | no
MULTIPLE_INSPECTABLE_VARIANTS: yes | no
BOUNDARY_DECISION_REQUIRED: yes | no
LIKELY_EXTRACTION_LATER: yes | no
REASON:
NEXT_STEP:
```
