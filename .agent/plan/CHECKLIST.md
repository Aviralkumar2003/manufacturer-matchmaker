# Checkpoint checklist

Use this with the detailed deliverables, acceptance criteria and gates in `IMPLEMENTATION_PLAN.md`. Mark a box complete only with an evidence report. Checkpoint 1 is active.

## Checkpoint 1: walking skeleton

- [x] Create `AGENTS.md` and `.agent/` with project rules, workflows, docs, and skills.
- [ ] Confirm PRD v4 acceptance criteria against the contracts.
- [ ] Record SP-1 through SP-10 with actual evidence and fallbacks.
- [ ] Create backend, frontend, landing, deploy, and scripts scaffold.
- [ ] Review and commit contracts before feature code.
- [ ] Capture RED and GREEN tests for CP1 requirements.
- [ ] Obtain approval for dependency pins and CI changes before editing them.
- [ ] Run `make verify`, restore rehearsal, and deployment dry run.
- [ ] Deploy public HTTPS skeleton after founder approval and account setup.
- [ ] Write checkpoint 1 evidence report; only then start checkpoint 2.

## Later checkpoints

- [ ] Checkpoint 2: identity, language, profile, documents and landing page.
- [ ] Checkpoint 3: admin tools and manufacturer supply.
- [ ] Checkpoint 4: swipe deck and matching.
- [ ] Checkpoint 5: consent, introductions, share links and outcomes.
- [ ] Checkpoint 6: dashboard, hardening, privacy and launch readiness.

### 12.2 Checkpoint overview

| # | Title | Target | Depends on | Requirement IDs | Gates |
|---|---|---|---|---|---|
| 1 | Walking skeleton, first deployment, backups and spikes | 2026-11-01 | none | CON-001, CON-002, CON-009, NFR-001, NFR-004, NFR-015, NFR-016 | Tier A plus security |
| 2 | Identity, language, profile, documents, landing page | 2026-11-08 | 1 | FR-001, FR-002, FR-003, FR-004, FR-005, FR-006, FR-007, FR-008, FR-009, FR-052, NFR-002, NFR-007, NFR-008, NFR-011, NFR-012, CON-003, CON-007 | same |
| 3 | Admin tools and manufacturer supply | 2026-11-15 | 1, 2 | FR-010, FR-011, FR-012, FR-013, FR-014, FR-050, FR-051, CON-004 | same |
| 4 | Swipe deck and matching | 2026-11-22 | 2, 3 | FR-015, FR-018, FR-019, FR-020, FR-021, FR-022, FR-023, FR-024, FR-025, FR-026, FR-027, FR-045, FR-046, FR-047, FR-049, NFR-019, CON-006 | same |
| 5 | Consent, introductions, share links, outcomes | 2026-11-22 | 2, 3, 4 | FR-016, FR-017, FR-028, FR-029, FR-030, FR-031, FR-032, FR-033, FR-034, FR-035, FR-036, FR-037, FR-038, FR-039, FR-048, NFR-005, NFR-006, NFR-009, NFR-017, CON-005 | same |
| 6 | Dashboard, hardening, privacy, launch readiness | 2026-11-29 | 1 to 5 | FR-040, NFR-003, NFR-010, NFR-011, NFR-013, NFR-014, NFR-016, NFR-018, CON-001, CON-002, CON-003, CON-008 | same |

Deferred and not to be built: FR-041, FR-042, FR-043, FR-044 (P2). Withdrawn: FR-002 (no OTP code may exist; CP2 includes a test that asserts the absence).

---
