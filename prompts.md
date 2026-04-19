# Prompt Engineering Reference

## Frameworks

### RTCCE — for serious work
**Role · Task · Context · Constraints · Evidence**

```
Role: You are a senior Python engineer reviewing production code.
Task: Review this function for correctness and edge cases.
Context: This runs in a data pipeline processing ~1M rows daily.
Constraints: Keep feedback under 10 bullet points. No style nitpicks.
Evidence: [paste code]
```

### CLEAR — for teaching / explanation
**Context · Language · Examples · Ask · Review**

```
Context: I'm learning how Python's GIL affects threading.
Language: Explain as if I know Python but not concurrency.
Examples: Use a real-world analogy.
Ask: Why does async IO avoid GIL issues but CPU work doesn't?
Review: Check if my understanding at the end is correct.
```

### GCCAV — for agents
**Goal · Context · Constraints · Acceptance · Verification**

```
Goal: Refactor this module to use async/await throughout.
Context: It currently uses requests (sync). Tests use pytest-asyncio.
Constraints: Don't change the public API. Don't add new dependencies.
Acceptance: All existing tests pass. No sync HTTP calls remain.
Verification: Run pytest and show the output before finishing.
```

---

## Core Principles

1. **Name the deliverable** — Replace "summarise this" with "write a 3-bullet TL;DR followed by a risks section"
2. **Put constraints in writing** — Length, format, tone, what to exclude
3. **Ground on evidence** — Point to specific files, data, or docs
4. **Define done** — Include concrete acceptance criteria
5. **Require verification** — Ask the model to flag assumptions or missing info

---

## Pre-submission Checklist

- [ ] Is the deliverable specific and named?
- [ ] Are constraints explicit (length, format, scope)?
- [ ] Is the evidence attached or referenced?
- [ ] Is "done" defined with acceptance criteria?
- [ ] Have I asked for assumptions to be flagged?

---

## Maturity Levels

| Level | Pattern | Example |
|---|---|---|
| 1 | Plain question | "What does this function do?" |
| 2 | Task + context | "Explain this function; I'm new to async Python" |
| 3 | RTCCE / CLEAR | Full structured prompt with constraints and evidence |
| 4 | Agent workflow | GCCAV with acceptance criteria and verification step |

Start at Level 2 for most tasks. Use Level 3–4 for complex or high-stakes work.
