—
name: residuality-review
description: Analyze a user story or code change for residuality (change isolation, blast radius, volatility handling) before or during implementation.
triggers:
  - before implementing a user story
  - when reviewing a design or PR
  - when user expresses doubt about structure or future changes
—

# Residuality Review Skill

## Purpose

Help evaluate and improve how well a design minimizes the impact of future changes.

This skill focuses on:
- Identifying volatility
- Isolating change
- Minimizing blast radius
- Avoiding unnecessary abstraction

Do NOT jump into coding. This is a thinking and structuring step.

—

## Step 1 — Restate the Story

Summarize the user story or feature in simple terms.

Then answer:
- What is the core responsibility?
- What is clearly NOT part of this responsibility?

—

## Step 2 — Identify Volatility

List parts that are likely to change over time.

Think in terms of:
- Business rules (pricing, validation, workflows)
- External dependencies (APIs, configs)
- Policy decisions (feature flags, rules engines)

Output:

- Stable parts:
- Potentially volatile parts:

Be explicit. If unsure, state uncertainty.

—

## Step 3 — Define the Change Axis

Pick the **primary axis of change**.

Only one if possible.

Explain:
- Why this is the dominant source of change
- What kind of changes are expected

—

## Step 4 — Evaluate Current Design (or propose one)

Describe how the system currently handles this concern, OR propose a minimal design.

Then answer:

- Where does the volatile logic live?
- Is it duplicated anywhere?
- Does it leak into unrelated components (controllers, aggregates, UI, etc.)?

—

## Step 5 — Blast Radius Test

Ask:

“If the change axis evolves tomorrow, what needs to change?”

List affected components explicitly.

Classify:

- ✅ Good: isolated to one module/component
- ⚠️ Moderate: touches a few related components
- ❌ Poor: spreads across layers or unrelated areas

—

## Step 6 — Suggest Improvements

Only suggest improvements if blast radius is not good.

Guidelines:
- Prefer isolation over abstraction
- Prefer explicit boundaries over clever reuse
- Avoid speculative generalization

Examples of acceptable suggestions:
- Extract policy/service
- Introduce a seam (interface, function boundary)
- Move logic out of inappropriate layer

—

## Step 7 — Sanity Check (Anti Over-Engineering)

Before finalizing, challenge the solution:

- Is this likely to change enough to justify this design?
- Am I introducing abstraction without evidence?
- What is the simplest version that still isolates change?

If over-engineering is detected, say so explicitly.

—

## Output Format

Use this structure:

### Summary
<short restatement>

### Volatility Analysis
- Stable:
- Volatile:

### Change Axis
<description>

### Current / Proposed Design
<analysis>

### Blast Radius
<explicit list + classification>

### Recommendation
<clear, minimal suggestion or “current design is sufficient”>

### Confidence
<high / medium / low + why>