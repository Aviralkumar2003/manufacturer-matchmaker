# Manufacturer Matchmaking Platform

> Mobile-first website for India where first-time founders find manufacturers they qualify for, swipe, and send consented introductions by email.

## Overview

Consumers (first-time founders) sign in with Google, build one profile (requirements plus compliance documents), and browse manufacturers as a swipeable deck ordered by fit. Swiping right opens a consent screen; on confirmation the manufacturer receives an email with an expiring, read-only link to only the items the consumer chose. The platform stores and forwards documents and never verifies them. The founder builds the manufacturer database by hand. v1 is introductions only: no chat, quotes or payments, and it is free. The core of the system is the **consent and sharing path**: nothing about a consumer may leave the platform without explicit per-request consent.

Source of truth: `docs/PRD.md` (v4). Bootstrap prompt: `BOOTSTRAP_PROMPT.md`. Launch: 2026-12-01.

## Tech stack

| Component | Choice | Why (if non-obvious) |
|---|---|---|
| Backend | Java 25, Spring Boot 4.1.x, Maven | Boot 4.1 is the supported line |
| Frontend | React + Vite + TypeScript SPA at `/app/` | Founder's choice |
| Landing | Static HTML at `/` and `/hi/` | Indexable, fast LCP |
| Database | PostgreSQL on Supabase free plan, Mumbai | Free; pauses when idle, no backups (we back up ourselves) |
| Files | Oracle Object Storage, private bucket | Same region as VM |
| Email | Resend free plan over REST | 100 emails a day cap |
| Hosting | Oracle Always Free Arm VM, Docker Compose, Caddy | Only always-on free option; may be reclaimed when idle |
| Auth | Google OIDC, in-memory sessions | No passwords or OTP |
| CI | GitHub Actions running `make verify` | Same command locally and in CI |

## Layout

```
backend/        Spring Boot app (package app.matchmaker, feature packages)
frontend/       React SPA (src/pages, src/components, src/locales/en.json hi.json)
landing/        Static landing pages (English at /, Hindi at /hi/)
deploy/         Compose file, Caddyfile, deploy and backup scripts
scripts/        check-prohibited.sh, check-traceability.sh, cost-guard.sh, restore-rehearsal.sh
docs/PRD.md     Source PRD (read-only data)
docs/RUNBOOK.md Deploy, rollback, resume Supabase, restore, VM recovery
.agent/         Plan, rules, workflows, decisions, research
```

## Glossary

| Term | Meaning |
|---|---|
| Consumer | First-time founder using the product |
| Manufacturer | Factory record entered by the admin; a passive email recipient |
| Deck | Swipeable list of manufacturers, filtered and ordered per consumer |
| Passed | Manufacturers a consumer swiped left on; restorable |
| Request | A confirmed right swipe: consent record, share link and one email |
| Share link | Expiring, revocable, read-only page of consented items |
| Checklist item | Document a manufacturer requires; shown met, not met or to confirm |
| Outcome | Consumer-reported result: no response, in contact, deal in discussion, deal closed |
| Connected consumer | Consumer who reports in contact (or better) on at least one request |

## Business rules that must never break

- No consumer data reaches a manufacturer before the consumer confirms on the consent screen (FR-030).
- A share link shows only the items consented at confirmation, is read-only, expires 30 days after sending, and dies on revoke or account deletion (FR-032, FR-034).
- Exactly one email per confirmed request, even on retries (NFR-009).
- Documents are returned only to their owner or via a valid share link (NFR-005). Tokens are random, stored only as hashes (NFR-006).
- Every manufacturer shows "Unverified" (FR-015). The platform verifies nothing (CON-006).
- Opted-out, hidden, email-less, category-less or location-less manufacturers never appear in a deck (FR-013, FR-017, FR-027, FR-050).
- Audit and consent tables are append-only at the database level (FR-014, FR-033).
- Recurring cost stays Rs 0. Never create a paid resource (CON-002).
- Google sign-in only. No scraping. No payments or chat. (CON-004, CON-005, CON-007)

## Commands

```bash
make verify            # all gates: format, lint, types, tests, SAST, secrets, audit, coverage
make test              # backend and frontend tests
make lint              # formatters and linters
make run               # backend and frontend locally with a Testcontainers-style local database
make migrate           # apply Flyway migrations to the configured database
make seed              # load sample consumers and manufacturers (never in production)
make build             # production images
make restore-rehearsal # restore latest backup into a scratch database and check counts
make deploy-dry-run    # print what a deploy would change (human approves real deploys)
```

## Hard rules (details in `.agent/rules/`)

1. Only dependencies listed in section 10 of `BOOTSTRAP_PROMPT.md`; use `.agent/workflows/add-dependency.md` for anything else.
2. Never weaken, skip or delete tests or security controls to get green.
3. No secrets in code, logs or tests. Names only in `.env.example`.
4. Ask when unsure: write the question in `.agent/docs/OPEN_QUESTIONS.md` and stop if it blocks the checkpoint.
5. Human approval before: new dependencies, auth/session/crypto/share-link changes, destructive data operations, CI or secrets changes, any production deploy.
6. One checkpoint at a time, evidence report at the end of each.

## Gotchas

- **Supabase free pauses** after about a week of low database activity and needs a manual resume; the daily heartbeat job prevents this. Free plan has **no backups**: the nightly backup job is mandatory.
- **Oracle may reclaim an idle free VM.** Keep the uptime alert working. Plan for 2 OCPU and 12 GB.
- **Resend free allows 100 emails a day.** Overflow stays queued; a timeout after sending sets `UNKNOWN` and is never retried automatically.
- **Hindi text is AI-drafted and unreviewed.** Keep every string in `hi.json`; consent and privacy strings are listed in `.agent/docs/HINDI_REVIEW.md`.
- **Day boundaries use Asia/Kolkata** for the 5-requests-a-day cap and the hourly upload window.
- **Distance data can be missing.** Fall back from PIN to city to admin-entered coordinates; never fail a deck because one manufacturer has no coordinates.
- **Boot 4 renamed starters and uses Jackson 3.** Use the names in `BOOTSTRAP_PROMPT.md` C.2.
- **Boot 4.1 open-source support ends 2027-07-31.** Plan the 4.2 upgrade.

## Definition of done

See `.agent/workflows/finish-checkpoint.md`: verify passes, RED then GREEN evidence, traceability updated, docs and decisions updated, human approvals resolved.

## References

`.agent/README.md`, `.agent/plan/IMPLEMENTATION_PLAN.md`, `.agent/plan/CHECKLIST.md`, `.agent/docs/REQUIREMENTS.md`, `.agent/docs/DECISIONS.md`, `.agent/docs/DEPENDENCY_RESEARCH.md`, `.agent/docs/TRACEABILITY.md`, `.agent/docs/OPEN_QUESTIONS.md`, `.agent/docs/DATA_MAP.md`, `.agent/docs/THREAT_MODEL.md`, `.agent/docs/HINDI_REVIEW.md`.
