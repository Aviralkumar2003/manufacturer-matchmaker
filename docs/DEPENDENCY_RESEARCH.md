# Dependency Research - Manufacturer Matchmaking Platform

Researched 2026-10-26 for `BOOTSTRAP_PROMPT.md` section 10. Evidence labels: **Verified** = read from an official registry or vendor page this session; **Secondary** = read from a third-party article (confirm before relying); **Unverified** = not checked (the agent must verify through `add-dependency` before use).

Version rule: pin the newest release at least 14 days old when scaffolding; never below the verified floor.

## 1. Platform and services

| ID | Candidate | Chosen | Evidence | Findings | Risks and mitigations | Status |
|---|---|---|---|---|---|---|
| DEP-001 | Java 21 or 25 | **Java 25 (Temurin 25.0.4+)** | Temurin release notice (Aug 2026); endoflife.date | 25 is the current LTS; Boot 4.1 supports Java 17 to 26 | Arm64 images unverified (SP-2) | Verified |
| DEP-002 | Boot 3.5, 4.0, 4.1 | **Boot 4.1.x (4.1.2, 2026-10-22)** | endoflife.date (secondary aggregator); Boot 4.0 migration wiki | 4.1 open-source support to 2027-07-31; 3.5 support ended 2026-06-30; 4.0 ends 2026-12-31 | Short window after launch; plan 4.2 upgrade. Release dates differ between sources (June 10 vs June 30); confirm on spring.io | Verified (dates secondary) |
| DEP-007 | Supabase, Neon, on-VM Postgres | **Supabase free, Mumbai** (founder; on-VM recommended and declined) | supabase.com/pricing; secondary articles | 500 MB database, pauses after a week of low activity, no automatic backups on free plan; Mumbai region reported | Pause, no backups, size cap. Heartbeat, nightly backup, 400 MB alert. Connection mode unverified (SP-3) | Verified (pricing page), Secondary (region) |
| DEP-008 | Oracle Always Free, Cloud Run, Render, Koyeb, Fly.io | **Oracle Always Free Arm VM and Object Storage, Mumbai** | Oracle docs (conflicting versions); secondary articles | Only always-on free option found; home region fixed at signup; idle reclamation exists (threshold reported as 15% or 20%); allowance shown as 4 OCPU/24 GB in one doc and reported as 2 OCPU/12 GB since June 2026; card required | Reclaim and allowance risk accepted (BD-04). Alert plus runbook. Plan for 2 OCPU/12 GB | Verified (docs conflict; O-14) |
| DEP-006 | Resend, Brevo, SES | **Resend free** | resend.com acceptable use; secondary article for plan figures | 3,000 emails a month, 100 a day, one domain, webhooks (secondary). Policy bans mass non-personalized unsolicited email and asks for sender address, company name and reason for contact | Daily cap; policy compliance; webhook signature scheme and data region unverified (O-07). No SDK: REST via `RestClient` | Verified (policy), Secondary (limits) |
| DEP-011 | Cloudflare R2, Backblaze B2 | **Open (O-04)** | secondary articles | R2: 10 GB, 1M writes, 10M reads a month, no egress fees (secondary); B2: 10 GB | Backup leaves India; encrypted before upload | Secondary |
| DEP-012 | Paid geocoding, open PIN directory | **All India Pincode Directory** | data.gov.in; OKFN discussion | Open government data licence; includes coordinates for many entries | Coverage per PIN unverified; fallbacks defined | Verified (existence), Unverified (coverage) |
| DEP-009 | Google OIDC | **Google OIDC via Spring Security** | Founder, PRD D-9 | Standard OIDC; basic scopes only | OAuth publishing mode (SP-7, O-09) | Proposed |
| DEP-010 | Caddy, nginx | **Caddy** | none this session | Automatic TLS and simple config | Version and Arm64 image unverified (SP-2) | Unverified |

## 2. Frontend packages (npm registry, 2026-10-26)

| ID | Package | Version | Published | License | Notes |
|---|---|---|---|---|---|
| DEP-020 | react, react-dom | 19.3.1 | 2026-10-14 | MIT | Under 14 days old at research time: apply the 14-day rule |
| DEP-021 | vite; @vitejs/plugin-react | 8.3.5; 6.1.2 | 2026-10-21; 2026-10-05 | MIT | |
| DEP-022 | typescript | 7.0.2 | 2026-07-08 | Apache-2.0 | Toolchain compatibility unverified (SP-8) |
| DEP-023 | react-router | 8.5.0 | 2026-10-19 | MIT | |
| DEP-024 | @tanstack/react-query | 5.105.0 | 2026-10-26 | MIT | Under 14 days old; apply the 14-day rule |
| DEP-025 | i18next; react-i18next | 26.5.11; 17.1.9 | 2026-10-25 | MIT | |
| DEP-026 | motion (chosen); @use-gesture/react (rejected) | 14.6.0; 0.x last released 2024-03-21 | 2026-10-22 | MIT | `motion` repository `motiondivision/motion`, no install-time scripts; `@use-gesture/react` not released for more than 12 months |
| DEP-027 | vitest | 5.0.5 | 2026-10-15 | MIT | |
| DEP-028 | @playwright/test | 1.64.1 | 2026-10-14 | Apache-2.0 | |
| DEP-029 | @axe-core/playwright | 4.14.0 | 2026-10-15 | MPL-2.0 | Dev-only; not shipped |
| DEP-030 | eslint; prettier | 10.13.0; 3.9.10 | 2026-10-16; 2026-10-10 | MIT | |

## 3. Backend libraries and tooling (to be verified through `add-dependency`)

| ID | Item | Evidence | Status |
|---|---|---|---|
| DEP-003 | Flyway via the Boot 4 `spring-boot-starter-flyway` | Boot 4.0 migration wiki | Verified (starter name); version managed by Boot |
| DEP-004 | PostgreSQL JDBC | Managed by Boot BOM | Proposed |
| DEP-005 | AWS SDK for Java v2 (S3 and URL-connection client) | none | Unverified (GitHub API rate-limited) |
| DEP-013 | GnuPG or age for backup encryption | none | Unverified |
| DEP-040 | JUnit 5, Boot test starters, Testcontainers 2.x | Boot 4 migration notes mention Testcontainers 2.x | Secondary |
| DEP-041 | JaCoCo | none | Unverified |
| DEP-042 | Java formatter and linter | none | Open |
| DEP-043 | Semgrep CE or SpotBugs with Find Security Bugs | none | Open |
| DEP-044 | gitleaks | none | Unverified |
| DEP-045 | OSV-Scanner | none | Unverified |

## 4. Rejected options

| Option | Reason |
|---|---|
| Render, Koyeb, Cloud Run free tiers | Sleep or scale to zero; cold starts of a JVM app would hurt first visits and the LCP target |
| Fly.io | Free allowances ended in 2024 (secondary source) |
| Pay-As-You-Go Oracle account | Conflicts with AC-NFR-001 |
| Neon free | Scales to zero after 5 minutes; cannot be disabled (secondary) |
| Brevo free | Branding footer on free-plan emails |
| `@use-gesture/react` | No release since 2024-03 |
| Paid maps or geocoding | Violates zero cost |

## 5. Open verification list (agent must complete before relying on these)

1. Oracle allowance, idle threshold and Mumbai availability from current official pages (SP-1, O-14).
2. Supabase region, connection mode and role support (SP-3).
3. Supabase heartbeat behaviour (SP-4).
4. Oracle Object Storage S3 compatibility and encryption-at-rest statement (SP-5).
5. Resend webhook signature scheme, data region and complaint thresholds (SP-6, O-07).
6. Versions, licenses, maintenance and advisories for all Unverified rows above.
7. Spring Boot release dates and support end dates on spring.io.
