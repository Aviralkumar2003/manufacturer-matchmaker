# Checkpoint 1 contract review

Status: approved by founder in this chat on 2026-10-27 under bootstrap U1. The contracts were committed separately as `ea0a8c3`, after the agent bootstrap commit `ca35e29`.

| Contract | File | Requirement and acceptance link | Open point |
|---|---|---|---|
| Public health, session state, CSRF, problem shape | `backend/src/main/resources/openapi/platform.yaml` | NFR-015; bootstrap C.4 | Whether `/healthz` should expose a separate liveness URL in addition to readiness |
| Platform tables and append-only triggers | `backend/src/main/resources/db/migration/V1__platform_shell.sql` | FR-014, FR-033, NFR-015, NFR-016 | Restricted-role grants and consent pseudonymization function depend on SP-3 and O-16 |
| Private storage boundary | `backend/src/main/java/app/matchmaker/platform/port/ObjectStore.java` | FR-005, FR-007, NFR-004 | Adapter selection and encryption-at-rest evidence depend on SP-5 |
| Outbound email boundary | `backend/src/main/java/app/matchmaker/platform/port/EmailSender.java` | FR-031, FR-036, NFR-009 | Resend delivery and webhook details depend on SP-6 |
| Injected clock | `backend/src/main/java/app/matchmaker/platform/port/Clock.java` | Deterministic expiry, jobs and time-based tests | None |
| Deploy/restore procedure outline | `docs/RUNBOOK.md` | NFR-016, CON-002 | Account-specific commands and restore evidence depend on cloud setup |

The PRD v4 has acceptance criteria for TLS/encryption (AC-NFR-4), admin error visibility (AC-NFR-15), and daily backup plus intact restore (AC-NFR-16). The bootstrap prompt adds test and operational detail. The contract files deliberately contain no production credentials or provider account identifiers.
