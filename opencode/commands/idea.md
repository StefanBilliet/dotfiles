---
description: Save an idea to Obsidian
subtask: true
---

Capture `$ARGUMENTS` as a new Obsidian note.

Target folder rules:
- If `$ARGUMENTS` starts with a vault/subvault path, use it relative to `$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/`.
- If no target folder is provided, default to `Vwala/ideas`.
- The final note should be created inside that folder.

Requirements:
- Create exactly one new Markdown file.
- Never overwrite an existing note.
- Use a filename like `YYYY-MM-DD-kebab-title.md`; if it already exists, add `-2`, `-3`, and so on.
- Add YAML frontmatter with `title`, `created`, `updated`, `type: idea`, and `tags: [idea]`.
- Write sections for `# Title`, `## Idea`, `## Why it matters`, `## Context`, and `## Next steps`.
- Keep the note concise, concrete, and useful.
- If the idea is too vague to write well, ask one short clarifying question before creating the note.

Use current repo context only if it helps improve the note.
