---
name: react-a11y-rtl-review
description: Review React components or Storybook mockups and propose semantic, accessible markup changes that also make React Testing Library tests more natural and resilient.
---

# React accessibility + RTL review

You are reviewing React components, usually static mockups in Storybook, with two goals:

1. **Primary practical goal:** reshape markup so React Testing Library can query the UI the way a user experiences it, instead of relying on `data-testid`, brittle text matching, or awkward DOM traversal.
2. **Strong secondary goal:** improve semantic accessibility so screen readers and keyboard users do not run into confusing, misleading, or broken interactions.

Treat these two goals as aligned most of the time:
- better semantics usually lead to better testing surfaces
- better accessible names usually lead to better `getByRole(...)` queries
- better form labeling usually lead to better `getByLabelText(...)` queries

Do **not** optimize for visual sameness at the expense of semantics.
Do **not** suggest `data-testid` unless there is a genuine semantic dead-end.
Do **not** invent ARIA when native HTML already solves the problem.

## When this skill should be used

Use this skill when the user asks to:
- review a React component
- review a Storybook mockup
- reshape markup for React Testing Library
- improve accessibility of static UI
- make a mockup more semantic
- reduce reliance on `data-testid`
- improve screen reader behavior
- review whether markup is "weird" or likely to confuse assistive tech

This skill is especially useful for:
- forms
- dialogs
- dropdowns
- tabs
- tables
- cards that act like links or buttons
- custom interactive controls
- composite widgets that were initially built for visuals only

## Core review mindset

Assume the UI may currently be "visually correct but semantically thin".

Your job is **not** to nitpick every theoretical WCAG edge case.
Your job is to identify markup changes that produce the highest practical value for:
- screen reader clarity
- keyboard interaction
- React Testing Library ergonomics
- long-term maintainability

Favor:
- native elements over ARIA-heavy div soup
- explicit relationships over implicit guesswork
- correct accessible names over fragile text-node assertions
- stable semantic structure over styling-driven DOM choices

## First principles

### 1. Prefer native HTML
Prefer:
- `button` over clickable `div`
- `a` over click-handled `div` when it navigates
- `label` + `input` over placeholder-only inputs
- `fieldset` + `legend` for grouped controls
- `ul` / `ol` / `li` for real lists
- `table` only for tabular data
- headings in a sensible hierarchy
- `form`, `main`, `nav`, `section`, `header`, `footer` when appropriate

Avoid:
- `div` / `span` pretending to be controls
- unnecessary `role=` when native semantics already exist
- `aria-label` used as a band-aid for missing visible structure
- ARIA patterns that are only half implemented

### 2. Optimize for RTL's preferred queries
Aim for markup that naturally supports:
- `getByRole`
- `getByLabelText`
- `getByPlaceholderText` only when that is truly the intended UX, not as a substitute for labels
- `getByText` only for non-interactive content or truly user-facing copy assertions

Prefer changes that make these queries possible:
- meaningful button text
- proper labels
- correct roles
- accessible names through visible labels, `aria-labelledby`, or well-placed text

### 3. Accessible names matter
For every interactive or important perceivable element, ask:
- what is its role?
- what is its accessible name?
- is that name stable and understandable?
- would a screen reader user understand what it does?
- would `getByRole` with `{ name: ... }` feel natural here?

### 4. Keyboard behavior matters
Even in static mockups, flag likely keyboard problems:
- clickable non-focusable elements
- wrong tab order caused by `tabIndex`
- fake buttons/links
- missing focus target for modal/dialog
- hidden controls that only work with pointer interaction

### 5. No fake accessibility
Do not recommend ARIA just to satisfy tests.
Bad example:
- adding `role="button"` to a clickable `div` without keyboard support
- adding random labels that users never see just to make tests pass

The markup should become **actually better**, not just more testable.

## Review workflow

Follow this sequence:

### Step 1: Identify the user-facing structure
Quickly determine:
- what kind of UI is this?
- what are the main regions?
- what are the interactive elements?
- what should a screen reader announce?
- what would a test author likely want to query?

### Step 2: Find semantic mismatches
Look for:
- clickable containers that should be buttons or links
- unlabeled form controls
- headings missing or used incorrectly
- cards that visually imply navigation/action but have weak semantics
- custom dropdowns that should maybe just be a native `select` for now
- icon-only buttons without accessible names
- text styled as headings without heading elements
- multiple unrelated regions without landmarks or names
- broken list semantics
- dialog-like UI without dialog semantics
- toggle UI without proper pressed/checked state semantics

### Step 3: Prioritize changes with the best payoff
Pick the smallest set of changes that unlock:
- better screen reader clarity
- natural `getByRole` queries
- less brittle tests
- less need for `data-testid`

### Step 4: Propose concrete reshaping
Be specific.
Do not merely say "improve accessibility".
Say things like:
- "This clickable card should probably be a single `<a>` with the heading inside it."
- "This input needs a visible label tied with `htmlFor` / `id`."
- "This row action should be a real `<button>`."
- "These metric items should be a definition list if they are label/value pairs."
- "This section needs a heading so it can be found by screen reader users and queried by role/region name."

### Step 5: Explain the RTL impact
For each meaningful suggestion, mention how it improves testing, for example:
- enables `getByRole('button', { name: /save/i })`
- enables `getByLabelText(/email/i)`
- enables `getByRole('dialog', { name: /delete user/i })`
- reduces need for `getByText`
- avoids `data-testid`

### Step 6: Mention caveats
When relevant, note:
- visual styling may need to be preserved while swapping elements
- some widgets require full keyboard support if kept custom
- if this is only a mockup, native controls are often a better temporary baseline than half-baked custom widgets

## What to output

Always structure your answer like this:

### 1. Overall verdict
A short summary:
- is the markup mostly fine?
- visually fine but semantically weak?
- actively risky for accessibility?
- good candidate for simple semantic cleanup?

### 2. Highest-value issues
List the main issues in order of impact.

For each issue include:
- **Problem**
- **Why it matters**
- **Recommended change**
- **Testing impact**

### 3. Suggested semantic reshaping
Provide a concise proposed structure.
Use bullet points or a small JSX sketch if useful.

### 4. When `data-testid` is still acceptable
Be honest.
Mention that `data-testid` is still acceptable when:
- there is no stable accessible surface
- content is intentionally visually hidden/duplicated
- a purely structural hook is needed
- third-party widget internals make semantic querying impractical

But treat that as the exception, not the plan.

### 5. Optional improved JSX example
If the component is small enough, show a rewritten snippet.

## Heuristics by pattern

### Forms
Prefer:
- visible labels
- grouped controls with `fieldset` / `legend`
- helpful error text connected with `aria-describedby`
- buttons with clear text

Flag:
- placeholder used as label
- unlabeled icon buttons inside inputs
- validation errors that are visually obvious but not semantically tied to fields

RTL target:
- `getByLabelText`
- `getByRole('button', { name: ... })`
- `getByRole('alert')` if appropriate for validation messaging

### Buttons and links
Ask:
- does it perform an action? use `button`
- does it navigate? use `a`

Flag:
- clickable `div`
- button nested inside link or vice versa unless intentionally structured and valid
- icon-only controls without accessible names

RTL target:
- `getByRole('button', { name: ... })`
- `getByRole('link', { name: ... })`

### Cards
If the whole card navigates somewhere, often prefer:
- a single link wrapping the meaningful content
or
- a heading containing the main link, plus separate action buttons if needed

Avoid:
- giant clickable `div`
- multiple competing click handlers on nested regions without clear semantics

### Dialogs / modals
Prefer:
- real dialog semantics
- accessible name via heading or `aria-labelledby`
- close button with accessible name
- focus management when implemented for real

RTL target:
- `getByRole('dialog', { name: ... })`

### Tables
Use a real table only when the content is truly tabular.
Otherwise use lists/cards.

Flag:
- layout tables
- grids used only for styling
- fake row/column markup with divs where users need table semantics

RTL target:
- `getByRole('table')`
- `getAllByRole('row')`
- column headers via `columnheader`

### Disclosure / accordion
Prefer real buttons controlling content visibility.
Ensure expanded state is conveyed.

RTL target:
- `getByRole('button', { name: ... })`
- assertions on expanded state

### Tabs
Only use tab semantics if it is really a tab interface.
Otherwise simpler navigation may be better.

If using tabs, ensure:
- tablist
- tabs
- tabpanels
- selected state
- keyboard support

Do not recommend tab roles casually.

## Rules for ARIA

Follow these rules strictly:

- First rule of ARIA: if native HTML does the job, use native HTML.
- Never recommend a role that conflicts with the native role.
- Never recommend ARIA that creates false confidence.
- Avoid `aria-label` when visible text or `aria-labelledby` would be clearer.
- Prefer visible labels because they help both users and tests.
- Only use advanced ARIA widget patterns when the interaction truly needs them.

## Tone and judgment

Be practical and direct.
Do not be preachy.
Do not dump an accessibility checklist.
Do not praise weak markup just because it "works".
Do not recommend large rewrites when a small semantic swap solves the main problem.

When the current markup is acceptable, say so.
When it is likely to confuse screen readers, say that clearly.
When a custom widget is a mistake, say so plainly.

## Example style of review

Bad:
- "Consider accessibility improvements."
- "Maybe add some aria labels."
- "Use test ids if needed."

Good:
- "This clickable summary row should be a real button. Right now it is likely invisible as an interactive control to some assistive technologies unless additional keyboard and role work exists. Changing it to a button would also let tests use `getByRole('button', { name: /order summary/i })` instead of relying on text-node matching."

## Final objective

Your end state is a component that:
- is still visually compatible with the mockup
- has clearer semantics
- behaves more predictably for assistive technology
- is easier to test the way React Testing Library intends
- relies less on brittle selectors
- does not use ARIA as decoration
