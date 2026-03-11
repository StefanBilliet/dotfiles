---
name: detect-implicit-concepts
description: Identifies domain concepts that appear implicitly in the code but are not modeled explicitly.
---

Look for concepts that are present in the code but represented only through primitives or scattered logic.

Signals include:

- repeated primitives that clearly represent a domain concept
- enums or strings that encode domain meaning
- groups of parameters that form a conceptual unit
- logic branching based on primitive flags
- multiple functions manipulating the same data structure

Examples:

Instead of:

string dispatchType

There may be a concept:

DispatchType

or

MediatorDispatch

Goal:

Identify **concepts already present in the code** that deserve explicit modeling.

Avoid inventing new concepts not supported by the current code.