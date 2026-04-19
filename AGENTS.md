# Development Conventions

> For dotfiles-specific knowledge (adding tools, architecture, stow), see [SKILL.md](./SKILL.md).

## Philosophy

- **Simplicity is king** — the simplest solution that works is the best solution
- **Self-documenting code** — if it needs comments, refactor it
- **Functional over OOP** — pure functions, composition, immutability
- **Commit early, commit often** — small, focused, verified commits

---

## Task Approach

- Enter plan mode for non-trivial tasks — don't jump straight into code
- **No shortcuts. No laziness. No surface solutions.**
- Always ask: *how might this change affect the whole?*
- Don't reinvent the wheel — search for existing solutions first

---

## Cross-Language Principles

### Code Design
- Prefer pure functions; isolate side effects
- No magic numbers — use named constants
- Avoid hidden state and mutable globals

### Error Handling
- Treat errors as structured data, not control flow
- Add context when propagating errors
- Never swallow errors silently

### Testing
- Unit tests for pure logic, integration tests for I/O boundaries
- Assert behaviour, not implementation details
- Follow **AAA**: Arrange, Act, Assert

### Git
```
type: short description
```

| Type | Use |
|---|---|
| `feat:` | New feature |
| `fix:` | Bug fix |
| `docs:` | Documentation |
| `chore:` | Maintenance |
| `refactor:` | Restructure without behaviour change |
| `test:` | Tests |

---

## Python

### Tools

| Tool | Purpose |
|---|---|
| `uv` | Package and project manager |
| `ruff` | Linter and formatter |
| `pytest` | Testing |

### Workflow

```bash
uv init myproject && cd myproject
uv add requests
uv add --dev pytest
uv run python script.py
uv run pytest
```

### Before Commit

```bash
uv run ruff format .
uv run ruff check --fix .
uv run pytest
```

### Style

- Type annotations always, Python 3.12+ (`list[T]`, `X | None`)
- Use `pydantic` or `dataclass` for structured data
- Use `httpx` (async) over `requests` (sync) for HTTP
- Absolute imports, no circular dependencies
- Environment variables via `.env` or config files — never hardcoded

### Checklist

- [ ] Using `uv`, `ruff`, `pytest`
- [ ] All functions have type annotations
- [ ] Structured data uses `pydantic` or `dataclass`
- [ ] No secrets hardcoded

---

## Bash

### Style

```bash
#!/bin/bash
set -euo pipefail

main() {
    local name="${1:-World}"
    echo "Hello, $name!"
}

main "$@"
```

- Always `set -euo pipefail`
- Quote variables: `"$var"`
- Use `[[ ]]` over `[ ]`
- No inline comments

---

## Quick Reference

| Lang | Format | Lint | Test |
|---|---|---|---|
| Python | `ruff format .` | `ruff check --fix .` | `pytest` |
| Bash | `shfmt -w` | `shellcheck` | `bash -n` |

**The Loop:** Change → Verify → Commit → Repeat
