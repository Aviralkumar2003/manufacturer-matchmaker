---
name: test-first-evidence
description: Turn PRD acceptance criteria into meaningful RED/GREEN tests and checkpoint gate evidence. Use when implementing a requirement or writing a verification report.
---

# Test first with evidence

Map the requirement ID to each PRD acceptance assertion, including negative, boundary and security cases. Write the test first and run it. Preserve the command, expected failing reason and output excerpt. A test that already passes before implementation needs a stronger assertion.

Implement the smallest behavior that makes the test pass; run the same test and then `make verify`. Assertions must inspect state, HTTP status, stored rows and access decisions, not merely exercise lines. Review assertions in security-critical packages. Update `.agent/docs/TRACEABILITY.md` with actual test names and modules only after the tests exist.

Coverage is a floor from bootstrap section 13. Report every unrun or failed gate truthfully. After three failed repair attempts on the same gate, follow `.agent/workflows/handle-failure.md`.
