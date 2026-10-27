---
name: checkpoint-delivery
description: Run one numbered project checkpoint with contract, RED/GREEN, verification, traceability, and an evidence report. Use when implementing or closing a checkpoint from the bootstrap prompt.
---

# Checkpoint delivery

Read `AGENTS.md`, the current checkpoint in `.agent/plan/IMPLEMENTATION_PLAN.md`, and `.agent/plan/CHECKLIST.md`. Confirm prerequisites and open items. Work only on that checkpoint; use safe defaults only where section 14 permits them and record the decision when made.

For each requirement, write its contract and acceptance tests before feature code. Capture a meaningful RED result, implement, and capture GREEN. Update traceability and decisions in the same change. Run `make verify` and the checkpoint checks; record exact outputs using `.agent/workflows/finish-checkpoint.md`.

If a gate fails, follow `.agent/workflows/handle-failure.md`. Never claim an unrun gate passed. Do not start another checkpoint until the current one passes and its evidence report exists.
