## 12. Implementation plan (checkpoints)

### 12.1 Executive summary

The product is a two-sided introduction service with a small admin area. The hard parts are not the swipe UI but: (1) the **consent and share-link path**, which must never leak documents; (2) a **free-tier infrastructure** that can pause or be reclaimed; and (3) a **five-week schedule** for one person. The plan therefore deploys a walking skeleton first, with backups and alerts, then builds vertical slices in order of risk: identity and documents, manufacturer supply, the deck, the consent and email path, then hardening and launch readiness.

There are **6 checkpoints**. Checkpoints 1 to 3 and 6 map to the PRD milestones M0, M1, M2 and M4. PRD milestone M3 (deck, consent, email, outcomes) is split into checkpoints 4 and 5 because it is the largest block; both are due in the same week, which is the schedule's tightest point. If it slips, apply the PRD's reserve cut order (CON-008) in this sequence and log each cut as a decision: P1 items (FR-021, FR-026, FR-039, FR-040, FR-047, FR-049), then the audit log display (FR-014, keep the storage), then Passed restore (FR-024), then Hindi on core screens only.

Key technical decisions: BD-01 to BD-13. Major risks: R1 to R10 in section 14.

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

### Checkpoint 1: Walking skeleton, first deployment, backups and spikes

**Objective:** a public HTTPS site on the Oracle VM serving the static landing placeholder, an SPA shell and a health-checked backend connected to Supabase, with CI running `make verify`, a nightly encrypted backup that has been restored once, a daily heartbeat, uptime alerts, and the ten spike results recorded.
**Requirements covered:** CON-001, CON-002, CON-009, NFR-001, NFR-004, NFR-015, NFR-016.
**Prerequisites (human must provide):** Oracle Cloud account (Always Free only, **Mumbai as the home region**, card on file); Supabase project in `ap-south-1`; Oracle Object Storage bucket and S3-compatible credentials; second backup provider account (open item O-04); domain and DNS access; Resend account with domain verification; Google Cloud OAuth client (redirect URI `https://DOMAIN/login/oauth2/code/google`); empty GitHub repository.
**Conditional controls activated:** B.3, B.5 (role split), B.6, B.8, B.9.

#### Deliverables

| Component | Path | Description |
|---|---|---|
| Backend scaffold | `backend/` | Boot 4.1 app, feature packages, `/healthz`, validated configuration, JSON logs with request ids, global error handler writing `app_errors` |
| Frontend scaffold | `frontend/` | Vite React TypeScript app at `/app/`, English and Hindi files with the i18n check |
| Landing placeholder | `landing/` | Static `/` and `/hi/` pages |
| Migration V1 | `backend/src/main/resources/db/migration/` | `app_errors`, `job_runs`, `heartbeat`, `audit_log` and `consent_record` shells with append-only trigger, restricted application role |
| Verify entry point | `Makefile`, `scripts/` | `make verify` and the scripts named in section 11 |
| CI | `.github/workflows/ci.yml` | Runs `make verify` on pull requests and pushes (agent changes to this file need human approval) |
| Deployment | `deploy/` | `compose.yml`, `Caddyfile`, `deploy.sh`, `.env.example`, Arm64 Dockerfile (non-root) |
| Jobs | `backend/.../platform/jobs/` | Heartbeat (daily), backup (nightly), job-run recording and kill switches |
| Backup tooling | `deploy/backup/`, `scripts/restore-rehearsal.sh` | Dump, encrypt, upload, restore into scratch database |
| Uptime alert | `deploy/monitoring/` | Hourly external health check by default (open item O-18) with an email alert to the founder |
| Runbook | `docs/RUNBOOK.md` | Deploy, rollback, resume Supabase, restore, rebuild after reclaim |
| Agent files | `AGENTS.md`, `.agent/` | Section 11 |
| Spike records | `.agent/docs/DECISIONS.md` | Results of SP-1 to SP-10 |

**Spikes (each must record result, evidence, and fallback):**

| ID | Question | Pass condition | Fallback if it fails |
|---|---|---|---|
| SP-1 | Can an Always Free Arm VM be created in Mumbai, and what is the current allowance? | VM running with at most the published allowance | Ask the founder (open item O-14); do not switch account type |
| SP-2 | Do Arm64 images exist for Temurin 25, Caddy and the Postgres client tools? | Images run on the VM | Build from source or pick a supported JDK 25 build; ask |
| SP-3 | Can the VM reach Supabase (direct or pooler, IPv4 or IPv6) and can a restricted role be created? | App connects with the restricted role; `AuditImmutabilityTest` passes against it | Stop and ask (O-08) |
| SP-4 | Does the daily heartbeat keep the project from pausing? | Project active after 7 days (monitored through launch) | Add a read query; escalate to the founder |
| SP-5 | Does Oracle Object Storage work through the S3-compatible API with the AWS SDK, and does official documentation state encryption at rest? | Upload, download, delete and the documented statement recorded | If encryption cannot be confirmed, stop and ask (NFR-004); default is application-level encryption of documents |
| SP-6 | Does Resend deliver from the founder's domain with SPF, DKIM and DMARC passing; what is its webhook signature scheme and data region? | Test email passes authentication checks (NFR-017) | Ask (O-07) |
| SP-7 | What Google OAuth publishing mode avoids token expiry for non-test users with only basic scopes? | Any Google account can sign in | Ask the founder |
| SP-8 | Do ESLint, `typescript-eslint` and Vite plugins support the proposed TypeScript version? | `npm run typecheck && npm run lint` clean | Pin the newest supported version and log it |
| SP-9 | Which second backup provider (R2 or B2) works with the same S3 adapter? | Encrypted object round-trip | Ask (O-04) |
| SP-10 | Are GitHub Actions minutes sufficient for `make verify` and the hourly check? | Within the free allowance for the repo type | Reduce check frequency (O-18) |

#### Contracts first (U1)

`backend/src/main/resources/openapi/platform.yaml` (health, error problem format, session); `V1` migration; `docs/RUNBOOK.md` outline; the `ObjectStore`, `EmailSender` and `Clock` port interfaces.

#### Test-first plan (U2)

| Test file | Requirement IDs | Cases (happy / boundary / negative / security) | Expected RED reason |
|---|---|---|---|
| `ConfigValidationTest` | CON-002, NFR-004 | App refuses to start with missing secrets; rejects non-HTTPS public base URL | No validation yet |
| `HealthTest` | NFR-015 | Liveness and readiness; readiness fails when the database is down; no internals in the body | Endpoint missing |
| `ErrorRecordingTest` | NFR-015 | A forced error stores a sanitized `app_errors` row and returns a problem response without a stack trace | Handler missing |
| `AuditImmutabilityTest` | NFR-015 | Restricted role cannot update or delete audit rows | Trigger and role missing |
| `BackupJobTest`, `restore-rehearsal.sh` | NFR-016 | Dump encrypted, uploaded, restored into scratch DB with matching counts; wrong key fails | Job missing |
| `JobKillSwitchTest` | NFR-016 | Disabled job does not run | Missing |
| `CostGuardTest` | NFR-001, CON-002 | Scripts referencing a non-allowlisted resource shape fail | Script missing |
| `ProhibitedPatternsTest` | CON-009 | Script finds forbidden files and APIs in a seeded bad sample | Script missing |

#### Implementation notes

Follow C.1 to C.6. Resolve the open Java tooling choices (DEP-042, DEP-043, DEP-013, DEP-005, DEP-010) through `add-dependency` and record research. The backup job calls `pg_dump` through `ProcessBuilder` with an argument list (never a shell string), streams to the encryption tool, then to the object store adapter. Heartbeat writes one row and prunes old rows. Deploy by building Arm64 images, copying `compose.yml` and the env file (created by the human), and running `docker compose up -d`; the **founder runs the first deploy**.

#### Acceptance criteria

```gherkin
Feature: Walking skeleton

  Scenario: Public skeleton is healthy
    Given the stack is deployed to the Oracle VM
    When anyone requests https://DOMAIN/healthz
    Then the response is 200 over TLS and contains no internal details
    And https://DOMAIN/ serves the landing placeholder and https://DOMAIN/app/ serves the SPA shell

  Scenario: Backup can be restored
    Given the nightly backup job has run on seeded data
    When make restore-rehearsal runs against a scratch database
    Then row counts match the source and the script exits 0

  Scenario: Append-only tables resist the application role
    Given the application connects with its restricted role
    When it tries to update or delete an audit_log row
    Then the database rejects the statement
```

#### Security and privacy considerations

Secrets only in the VM env file (mode 600). Firewall allows 80 and 443 and SSH from the founder's address only. No personal data exists yet; the data map starts empty. The Oracle account type must not change.

#### Observability

Structured logs, `app_errors`, `job_runs`, `/healthz`, internal metrics port. Uptime alert fires within 2 hours of a failed health check (hourly default).

#### Documentation updates

`README.md`, `docs/RUNBOOK.md`, `AGENTS.md`, `.agent/` files, spike results in DECISIONS.md, `TRADEOFFS.md` (in-memory sessions, malware scanning not adopted).

#### Verification

1. `make verify` -> expected: exit 0, every gate PASS, backend coverage at least 70% on changed modules.
2. `curl -fsS "$APP_URL/healthz"` -> expected: HTTP 200 over HTTPS.
3. `make restore-rehearsal` -> expected: counts match, exit 0.
4. `bash scripts/cost-guard.sh` -> expected: no non-allowlisted resource shapes.
5. Evidence report per section 13.

#### Definition of done

- [ ] Contracts reviewed and committed
- [ ] RED evidence recorded, then GREEN
- [ ] `make verify` passes for tier A plus security gates
- [ ] Traceability file updated (IDs, tests, modules)
- [ ] Docs updated; decisions logged; spikes SP-1 to SP-10 recorded
- [ ] Human approvals resolved: dependencies (DEP-005, 010, 013, 042 to 045), first production deploy, CI configuration
- [ ] Public skeleton URL live; uptime alert tested by stopping the app once

---

### Checkpoint 2: Identity, language, profile, documents, landing page

**Objective:** a visitor can read the landing page in English or Hindi, accept the privacy notice, sign in with Google, build a profile and brief, upload and manage documents, and delete their account. Outreach links can go live.
**Requirements covered:** FR-001, FR-002, FR-003, FR-004, FR-005, FR-006, FR-007, FR-008, FR-009, FR-052, NFR-002, NFR-007, NFR-008, NFR-011, NFR-012, CON-003, CON-007.
**Prerequisites:** checkpoint 1 complete; Google OAuth client configured (SP-7); privacy notice text approved by the founder.
**Conditional controls activated:** B.1, B.2, B.3, B.7.

#### Deliverables

| Component | Path | Description |
|---|---|---|
| Identity | `backend/.../identity/` | Google OIDC login, session endpoint, logout, privacy-notice consent record, admin allow-list |
| Profile | `backend/.../profile/`, `frontend/src/pages/Profile*` | Profile and brief CRUD |
| Documents | `backend/.../documents/`, `frontend/src/pages/Documents*` | Upload with content-signature checks, rate limits, list, replace, delete, owner-only download |
| Account deletion | `backend/.../profile/AccountDeletionService` | Removes rows and objects, revokes links |
| Landing | `landing/` | English and Hindi pages, free-to-use statement, sign-in button, redirect script for signed-in users |
| Strings | `frontend/src/locales/` | `en.json`, `hi.json`, `HINDI_REVIEW.md` |
| Data map | `.agent/docs/DATA_MAP.md` | First personal-data entries |

#### Contracts first (U1)

OpenAPI for `/api/session`, `/api/profile`, `/api/briefs`, `/api/documents`, `/api/account`; migrations for users, privacy consents, profiles, briefs, documents, upload events; document type table seeded per O-02.

#### Test-first plan (U2)

| Test file | Requirement IDs | Cases (happy / boundary / negative / security) | Expected RED reason |
|---|---|---|---|
| `AuthTest` | FR-001, CON-007 | Sign-in creates an account; cancelled sign-in creates none; unverified Google email rejected | Not built |
| `NoOtpOrPasswordTest` | FR-002, CON-007 | No password or OTP route exists (route listing assertion) | Not built |
| `PrivacyConsentTest` | FR-008 | No account without acceptance; acceptance stores version and time | Not built |
| `LanguageTest` (Playwright) | FR-003, NFR-012 | Switch persists across sessions; a key missing in Hindi falls back to English | Not built |
| `ProfileTest` | FR-004 | Required fields flagged; PIN code format validated | Not built |
| `UploadValidationTest` | FR-005, NFR-007, NFR-008 | 12 MB PDF rejected; DOCX rejected; renamed executable rejected; 26th file rejected; 21st upload in an hour refused with retry time | Not built |
| `DocumentLifecycleTest` | FR-006 | Replace and delete make the old object unretrievable | Not built |
| `BriefTest` | FR-007 | Quantity range, timeline, attachments; appears for consent screen use | Not built |
| `AccountDeletionTest` | FR-009, NFR-011 | Zero rows and objects remain; links dead | Not built |
| `DocumentAccessTest` | NFR-007 | Another consumer and anonymous users get denied | Not built |
| `LandingTest` | FR-052, CON-003 | Anonymous sees landing in chosen language; signed-in user redirected to deck route | Not built |
| `ResponsiveTest` | NFR-002 | No horizontal scroll at 360 px on every main screen | Not built |

#### Implementation notes

Sessions: in memory (BD-10). Detect upload type by reading the first bytes. Store objects under `consumer-id/uuid`. Count uploads from the `upload_events` table over a rolling hour in `Asia/Kolkata`. Put every UI string through i18next from the first screen. Deck route placeholder is acceptable until checkpoint 4. Draft Hindi strings, list consent and privacy strings in `HINDI_REVIEW.md`.

#### Acceptance criteria

```gherkin
Feature: Consumer onboarding

  Scenario: Sign up with privacy consent
    Given a visitor on the landing page in Hindi
    When they accept the privacy notice and complete Google sign-in
    Then an account exists, the consent and its time are stored, and they reach profile setup in Hindi

  Scenario: Oversized or wrong-type file
    Given a signed-in consumer
    When they upload a 12 MB PDF or a DOCX file
    Then the upload is rejected with a clear message and nothing is stored

  Scenario: Delete account
    Given a consumer with documents and a brief
    When they delete their account
    Then their profile, documents and briefs are removed from the database and object storage
```

#### Security and privacy considerations

Document access is owner-only. CSRF on every state change. Do not log file names or contents. The privacy notice lists processors and the Mumbai regions, and states that backups are copied outside India if O-04 selects a non-India provider.

#### Observability

Counters for sign-ins, upload rejections by reason, rate-limit hits; errors recorded per NFR-015.

#### Documentation updates

README (sign-in setup), OpenAPI, DATA_MAP.md, HINDI_REVIEW.md, TRACEABILITY.md, DECISIONS.md.

#### Verification

1. `make verify` -> expected: exit 0, security-critical packages (`identity`, `documents`) at 80% line coverage or higher.
2. `npm run e2e:a11y` -> expected: zero serious or critical axe violations on landing, sign-in and profile screens.
3. `npm run test:landing` -> expected: language redirect and signed-in redirect pass.
4. Manual: sign in with two Google accounts in production and confirm one cannot fetch the other's document URL -> expected: denied.
5. Evidence report per section 13.

#### Definition of done

- [ ] Contracts reviewed and committed
- [ ] RED evidence recorded, then GREEN
- [ ] `make verify` passes for tier A plus security gates
- [ ] Traceability file updated
- [ ] Data map and Hindi review list updated; decisions logged
- [ ] Human approvals resolved: auth configuration, privacy notice wording
- [ ] Landing page live in both languages for outreach

---

### Checkpoint 3: Admin tools and manufacturer supply

**Objective:** the founder can enter or import manufacturers with provenance and required documents, fix checklist items, hide or remove records, and see an append-only audit trail.
**Requirements covered:** FR-010, FR-011, FR-012, FR-013, FR-014, FR-050, FR-051, CON-004.
**Prerequisites:** checkpoint 2 complete; admin allow-list values (O-06); category list (O-01) and document-type list (O-02) or their safe defaults; a sample CSV from the founder.
**Conditional controls activated:** B.1 (manufacturer contact data), B.5.

#### Deliverables

| Component | Path | Description |
|---|---|---|
| Manufacturer model | `backend/.../manufacturers/` | Record, categories, certifications, checklist items, provenance fields |
| CSV import | `backend/.../manufacturers/imports/` | Validating, all-or-nothing import with per-row rejection report |
| Admin screens | `frontend/src/pages/admin/` | List, create or edit, import, hide or remove, checklist editor, audit view |
| Audit | `backend/.../admin/AuditService` | Writes to the append-only table on every admin action |
| PIN data | `backend/src/main/resources/pin/`, importer | Loads the open directory into `pin_location` with the licence note |
| Seed | `scripts/seed.sh` | Fake manufacturers for development only |

#### Contracts first (U1)

OpenAPI for `/api/admin/**`; CSV column contract documented in `docs/CSV_FORMAT.md` (name, address, contact email, categories, MOQ, certifications, required documents, source URL, date collected, optional latitude and longitude); migrations for manufacturers, checklist items, categories, document types, `pin_location`.

#### Test-first plan (U2)

| Test file | Requirement IDs | Cases | Expected RED reason |
|---|---|---|---|
| `AdminAuthorizationTest` | FR-010, FR-013 | Non-admin consumers and anonymous users get 403 on every admin route | Not built |
| `ManufacturerCrudTest` | FR-010 | All fields stored with source URL and date | Not built |
| `CsvImportTest` | FR-011, FR-051 | 3 valid and 1 invalid rows create 3 and report 1 with reason; malformed file imports nothing; "GST certificate" links to GST and "Factory licence" stays to confirm and is reported | Not built |
| `ChecklistTest` | FR-012 | Add, edit, remove items | Not built |
| `HideRemoveTest` | FR-013 | Hidden record leaves the deck query; Sent requests remain | Not built |
| `AuditLogTest` | FR-014 | Each admin action writes actor, action, time; update or delete is rejected by the database | Not built |
| `DeckEligibilityTest` | FR-050 | No category or no location excludes the record | Not built |
| `NoScraperTest` | CON-004 | No crawler dependency or HTTP fetch to non-allowlisted hosts exists (dependency and grep gates) | Not built |

#### Implementation notes

Import is transactional: validate the whole file first, then insert; an unreadable file imports nothing, a file with some bad rows imports the good rows and reports the rest (PRD AC-FR-11 and Journey 5). Normalize document names for matching against the document-type table, case-insensitively, and show unmatched names to the admin. Contact emails are validated syntactically; a record without a valid email stays stored but is excluded from decks (checkpoint 4).

#### Acceptance criteria

```gherkin
Feature: Manufacturer supply

  Scenario: Import with a bad row
    Given a CSV with 3 valid rows and 1 invalid row
    When the admin imports it
    Then 3 manufacturers are created with address and required documents
    And 1 rejected row is shown with its reason

  Scenario: Unmatched document names stay visible
    Given an imported row listing "GST certificate" and "Factory licence"
    When the import completes
    Then GST is linked to its document type and "Factory licence" is marked to confirm and shown to the admin

  Scenario: Audit trail cannot be altered
    Given an admin edited a manufacturer
    When anyone tries to change the audit row through the application role
    Then the database rejects it
```

#### Security and privacy considerations

Admin routes need the allow-list. CSV upload obeys B.2 size and type limits and is parsed with a vetted approach (no formula or macro execution; strip leading `=`, `+`, `-`, `@` in any export). Manufacturer personal contact data is minimized and removal is honored within 2 business days.

#### Observability

Import counts, rejected-row counts, audit events written, errors recorded.

#### Documentation updates

`docs/CSV_FORMAT.md`, runbook (removal and opt-out handling), DATA_MAP.md, TRACEABILITY.md.

#### Verification

1. `make verify` -> expected: exit 0; `manufacturers` and `admin` packages at 80% line coverage or higher.
2. `npm run e2e -- admin` -> expected: import with bad row and checklist edit flows pass.
3. Manual: import the founder's sample CSV in the deployed environment -> expected: counts and rejection report match the file.
4. Evidence report per section 13.

#### Definition of done

- [ ] Contracts reviewed and committed
- [ ] RED evidence recorded, then GREEN
- [ ] `make verify` passes for tier A plus security gates
- [ ] Traceability file updated
- [ ] Data map updated; decisions logged
- [ ] Human approvals resolved: admin allow-list, category and document-type lists (or defaults accepted)
- [ ] At least 30 usable manufacturers per pilot category loaded by checkpoint 6 (PRD D-20), tracked on the admin screen

---

### Checkpoint 4: Swipe deck and matching

**Objective:** a signed-in consumer sees a fast, ordered, filterable deck of eligible manufacturers, opens full profiles with checklist status, passes, restores, undoes and uses buttons; a right swipe opens a placeholder that checkpoint 5 replaces with the consent screen.
**Requirements covered:** FR-015, FR-018, FR-019, FR-020, FR-021, FR-022, FR-023, FR-024, FR-025, FR-026, FR-027, FR-045, FR-046, FR-047, FR-049, NFR-019, CON-006.
**Prerequisites:** checkpoints 2 and 3 complete; radius options confirmed (O-03) or safe default accepted; at least 30 sample manufacturers in the pilot categories.
**Conditional controls activated:** B.3, B.7.

#### Deliverables

| Component | Path | Description |
|---|---|---|
| Deck API | `backend/.../deck/` | Eligibility query, relevance scoring (weights in configuration), filters, swipe state, undo, restore |
| Distance | `backend/.../deck/DistanceService` | Haversine distance from `pin_location` with the documented fallbacks |
| Matching | `backend/.../deck/ChecklistMatcher` | Met, not met, to confirm; "meets X of Y" |
| Deck UI | `frontend/src/pages/Deck*`, `components/` | Card, swipe gesture, buttons, filters, Passed list, profile page, Unverified label |
| Performance tests | `frontend/e2e/perf/` | Pointer-release to next-card paint measurement; bundle budget check |

#### Contracts first (U1)

OpenAPI for `/api/deck`, `/api/deck/swipe`, `/api/deck/undo`, `/api/passed`, `/api/manufacturers/{id}`; scoring formula document `docs/MATCHING.md` with weights 40/30/30 as configuration (FR-045) and the rule that missing inputs are omitted and weights renormalized.

#### Test-first plan (U2)

| Test file | Requirement IDs | Cases | Expected RED reason |
|---|---|---|---|
| `DeckEligibilityTest` | FR-027, FR-050, FR-046 | Excludes no-email, no-category, no-location, hidden and opted-out records; defaults to the consumer's category | Not built |
| `RelevanceOrderTest` | FR-045 | Fixed fixtures produce a stable known order; missing MOQ or distance renormalizes weights; category match always ranks first | Not built |
| `FiltersTest` | FR-020, FR-021 | Category, location, radius, and fully-met filter combinations | Not built |
| `ChecklistMatcherTest` | FR-019, FR-022 | Met, not met, to confirm; "meets X of Y"; unknown fields omitted | Not built |
| `MoqFitTest` | FR-049 | At or above, below, unknown | Not built |
| `SwipeStateTest` | FR-023, FR-024, FR-026 | Left swipe passes silently (no email, no notification); restore returns to the deck; undo blocked after a request is sent | Not built |
| `PassReasonTest` | FR-047 | Reason optional and never delays the swipe | Not built |
| `UnverifiedLabelTest` | FR-015, CON-006 | Label on every card and profile in both languages | Not built |
| `DeckButtonsTest` | FR-025 | Buttons equal swipes (Playwright, keyboard too) | Not built |
| `SwipeLatencyTest` | NFR-019 | Next card paints within 100 ms of pointer release with the network stubbed to a slow response | Not built |
| `PinFallbackTest` | FR-020 | PIN missing falls to city, then admin coordinates, then "distance unknown" without error | Not built |

#### Implementation notes

Return the deck in pages of about 10 with the next 5 prefetched with images. Commit swipes locally and sync in the background; on failure roll back with a message. Compute distance in the database or service, not in the browser. Do not use any paid map or geocoding API (CON-002). `motion` handles gestures; ensure touch and mouse and keyboard parity and `prefers-reduced-motion`.

#### Acceptance criteria

```gherkin
Feature: Deck

  Scenario: Left swipe is silent and reversible
    Given a consumer viewing a manufacturer card
    When they swipe left
    Then the manufacturer moves to Passed, no email or notification is sent, and they can restore it

  Scenario: Deck is ordered and honest
    Given three eligible manufacturers with different checklist fit, MOQ fit and distance
    When the consumer opens the deck
    Then the order follows the configured relevance score and every card shows Unverified

  Scenario: Fast swipe
    Given a deck with five prefetched cards on a throttled network
    When the consumer releases a swipe
    Then the next card is visible within 100 ms
```

#### Security and privacy considerations

Deck endpoints return only fields needed for cards; contact emails are never sent to consumers. Swipe endpoints check ownership. Passed reasons are consumer data and are covered by deletion.

#### Observability

Deck query duration, number of eligible records per consumer, swipe sync failures.

#### Documentation updates

`docs/MATCHING.md`, OpenAPI, TRACEABILITY.md, TRADEOFFS.md (client-side prefetch).

#### Verification

1. `make verify` -> expected: exit 0; `deck` package at 80% line coverage or higher.
2. `npm run test:perf` -> expected: swipe-to-paint at or under 100 ms in the test environment; initial JS at or under the 200 kB gzipped budget.
3. `npm run e2e:a11y` -> expected: zero serious or critical violations on deck and profile.
4. Manual on a mid-range Android phone: swipe through 10 cards -> expected: no visible lag.
5. Evidence report per section 13.

#### Definition of done

- [ ] Contracts reviewed and committed
- [ ] RED evidence recorded, then GREEN
- [ ] `make verify` passes for tier A plus security gates
- [ ] Traceability file updated
- [ ] Decisions logged (relevance fallback rules, PIN coverage observed)
- [ ] Human approvals resolved: radius options (O-03)
- [ ] Scoring weights confirmed in configuration, not code

---

### Checkpoint 5: Consent, introductions, share links, outcomes

**Objective:** a consumer can confirm a request after seeing exactly what will be shared; the manufacturer receives one authenticated email with an expiring read-only link; opt-out, revoke, bounce handling, daily caps, duplicate warnings, outcomes and the 14-day prompt all work.
**Requirements covered:** FR-016, FR-017, FR-028, FR-029, FR-030, FR-031, FR-032, FR-033, FR-034, FR-035, FR-036, FR-037, FR-038, FR-039, FR-048, NFR-005, NFR-006, NFR-009, NFR-017, CON-005.
**Prerequisites:** checkpoints 1 to 4 complete; Resend domain verified with SPF, DKIM and DMARC passing (SP-6); founder-approved email wording and postal address for the provider's policy; webhook signature scheme confirmed (O-07).
**Conditional controls activated:** B.1, B.3, B.4, B.5, B.6.

#### Deliverables

| Component | Path | Description |
|---|---|---|
| Consent | `backend/.../consent/`, `frontend/src/pages/Consent*` | Consent screen content, per-item selection, idempotent confirmation, consent record |
| Share links | `backend/.../sharing/` | Token creation (hash only stored), public read-only endpoints, revoke, expiry |
| Email | `backend/.../email/` | Outbox, dispatcher, Resend adapter, templates in English (and Hindi for the consumer-facing parts), opt-out link, webhook endpoint |
| Opt-out | `backend/.../manufacturers/OptOutService`, page | Confirmation page and permanent exclusion |
| Requests | `frontend/src/pages/Requests*` | Sent requests list with status, revoke, outcome selector, 14-day prompt |
| Caps | `backend/.../consent/DailyRequestLimiter` | 5 per consumer per `Asia/Kolkata` day; duplicate-contact warning |
| Threat model update | `.agent/docs/THREAT_MODEL.md` | Share-link and email abuse cases |

#### Contracts first (U1)

State machine `docs/REQUEST_STATES.md`: `DRAFT -> CONFIRMED -> QUEUED -> SENT -> OPENED`, and `FAILED`, `REVOKED`, `UNKNOWN` branches with allowed transitions; OpenAPI for `/api/requests`, `/api/share/{token}`, `/api/share/{token}/documents/{id}`, `/api/optout/{token}`, `/api/webhooks/email`; email template contract listing every required element (B.6).

#### Test-first plan (U2)

| Test file | Requirement IDs | Cases (happy / boundary / negative / security) | Expected RED reason |
|---|---|---|---|
| `ConsentScreenTest` | FR-028, FR-029, FR-030 | Screen names the manufacturer and lists items; unchecked items are excluded; nothing is sent or shared before confirm | Not built |
| `ConsentRecordTest` | FR-033 | Record stores consumer, manufacturer, items, time; append-only at database level | Not built |
| `OutboxIdempotencyTest` | NFR-009, FR-031 | Double click or retried confirm creates one request and one email; crash after provider call sets `UNKNOWN` and is not retried | Not built |
| `ShareLinkTest` | FR-032, NFR-005, NFR-006 | Valid link shows only consented items; unconsented document id denied; 31-day-old link shows nothing; token entropy and no derivation from ids; unknown, expired and revoked look identical; only the hash is stored | Not built |
| `RevokeTest` | FR-034, FR-035 | Revoked link shows no items; status updates | Not built |
| `OpenedStatusTest` | FR-035 | First open sets "link opened" once | Not built |
| `WebhookTest` | FR-036 | Bounce marks delivery failed; bad signature rejected; duplicate event ignored | Not built |
| `OptOutTest` | FR-016, FR-017 | Every email contains a working link; confirmation page; no further email; hidden from all decks | Not built |
| `DailyLimitTest` | FR-037 | 6th request in an Asia/Kolkata day is blocked with a clear message; midnight boundary | Not built |
| `DuplicateWarningTest` | FR-038 | Second request to the same manufacturer needs confirmation | Not built |
| `OutcomeTest` | FR-048 | Record and change each outcome | Not built |
| `FollowUpPromptTest` | FR-039 | After 14 days the next app open shows the prompt once; answer stored | Not built |
| `EmailAuthTest` (manual script) | NFR-017 | Header analysis of a real test email shows SPF, DKIM and DMARC pass | Not run |
| `NoPaymentsOrChatTest` | CON-005 | No payment, chat or quote route exists | Not built |

#### Implementation notes

Confirm with a client-generated idempotency key stored with a unique constraint. Create the share token inside the same transaction as the consent record and outbox row. Resend returns provider errors; treat timeouts as `UNKNOWN`. The daily provider cap (100) can delay emails; show "queued" to the consumer and process in order. Verify webhook signatures per the provider's official documentation, not from memory. Do not include documents as email attachments; the link is the only path.

#### Acceptance criteria

```gherkin
Feature: Consented introduction

  Scenario: Confirmed request sends one email
    Given a consumer on the consent screen for a manufacturer, with two documents selected
    When they confirm twice in quick succession
    Then exactly one request, one consent record and one email exist
    And the email link shows only the two selected documents

  Scenario: Link stops working
    Given a sent request
    When the consumer revokes it, or the account is deleted, or 30 days pass
    Then the share link shows no items

  Scenario: Opt-out
    Given a manufacturer who clicks the opt-out link and confirms
    Then no further email is sent and the manufacturer appears in no deck
```

#### Security and privacy considerations

This is the highest-risk checkpoint. Apply B.4 and B.6 in full. Never log tokens; never include tokens in analytics or error records. Update the threat model with abuse cases: link forwarding, enumeration, replay, email spoofing of the sender, using the platform to spam a manufacturer (daily cap, duplicate warning, opt-out).

#### Observability

Email event table, outbox depth, `UNKNOWN` count, webhook failures, daily cap utilization; all visible to the admin.

#### Documentation updates

`docs/REQUEST_STATES.md`, runbook (resend an `UNKNOWN` email, handle complaints), THREAT_MODEL.md, DATA_MAP.md, TRACEABILITY.md.

#### Verification

1. `make verify` -> expected: exit 0; `consent`, `sharing`, `email` packages at 80% line coverage or higher.
2. `npm run e2e -- consent` -> expected: end-to-end confirm, email capture (test provider stub), link view, revoke.
3. Manual with a real mailbox: send one request -> expected: one email, SPF, DKIM, DMARC pass, link works, opt-out works.
4. Manual: forward the link to a different browser session -> expected: still read-only and limited to consented items.
5. Evidence report per section 13.

#### Definition of done

- [ ] Contracts reviewed and committed
- [ ] RED evidence recorded, then GREEN
- [ ] `make verify` passes for tier A plus security gates
- [ ] Traceability file updated
- [ ] Threat model updated; decisions logged
- [ ] Human approvals resolved: email wording and policy fields, any auth or share-link change, first real send
- [ ] Hindi consent and email strings added to the review list

---

### Checkpoint 6: Dashboard, hardening, privacy, launch readiness

**Objective:** the product is ready for launch on 2026-12-01: admin metrics, privacy duties traced, deletion jobs, accessibility and performance verified, backup restore rehearsed with full data, usability test completed, and the recovery runbook rehearsed.
**Requirements covered:** FR-040, NFR-003, NFR-010, NFR-011, NFR-013, NFR-014, NFR-016, NFR-018, CON-001, CON-002, CON-003, CON-008.
**Prerequisites:** checkpoints 1 to 5 complete; five first-time users recruited for the moderated test (human); the founder's summary of legal advice (open item O-10); real manufacturers loaded.
**Conditional controls activated:** B.1, B.6, B.7, B.8, B.9.

#### Deliverables

| Component | Path | Description |
|---|---|---|
| Admin dashboard | `backend/.../admin/`, `frontend/src/pages/admin/Dashboard*` | Counts of users, requests, delivery failures, opt-outs, reported responses, connected consumers (FR-040); error and email event views (NFR-015) |
| Retention jobs | `backend/.../platform/jobs/` | 12-month inactive deletion, expired-link sweep (NFR-011) |
| DPDP trace | `docs/DPDP_TRACE.md` | Each duty mapped to a requirement, test or open item (NFR-010) |
| Performance evidence | `docs/PERFORMANCE.md` | Lab results for LCP, INP and CLS on a throttled mobile profile for landing and deck |
| Browser matrix | `docs/BROWSERS.md` | Manual results on the NFR-014 matrix |
| Usability test | `docs/USABILITY_TEST.md` | Five sessions, task completion, issues |
| Recovery rehearsal | `docs/RUNBOOK.md` | Rebuild on a fresh VM from backup, with times recorded |
| Upgrade note | `.agent/docs/DECISIONS.md` | Plan and date for Boot 4.2 before 2027-07-31 |
| Release notes | `CHANGELOG.md` | Launch version |

#### Contracts first (U1)

Metric definitions for FR-040 in `docs/METRICS.md` (including the definition of a connected consumer from PRD G2); DPDP trace table skeleton.

#### Test-first plan (U2)

| Test file | Requirement IDs | Cases | Expected RED reason |
|---|---|---|---|
| `DashboardMetricsTest` | FR-040 | Counts match fixtures, including opt-outs and connected consumers | Not built |
| `InactiveAccountJobTest` | NFR-011 | Account inactive for 12 months is deleted with files and links; 11 months is kept; clock injected | Not built |
| `ErrorAndEmailViewsTest` | NFR-015 | Admin sees recorded errors and outcomes; non-admin does not | Not built |
| `RestoreRehearsal` (script) | NFR-016 | Full-data restore matches counts and a sampled document | Not run |
| `A11yFullFlowTest` | NFR-013 | Axe clean on sign-in, profile, upload, deck, consent, requests | Failing until fixed |
| `CostAssertions` (script) | NFR-001, CON-002 | No paid resource shapes; runbook charge checklist signed | Not run |
| `LanguageCoverageTest` | CON-003 | Every key exists in Hindi; no other locale files exist | Not run |

#### Implementation notes

Measure NFR-003 in a lab run (Chrome with mobile throttling) for the landing page and the deck, and record the values; field measurement at p75 starts after launch and is tracked in the first post-launch review. Complete the usability test with five unaided first-time users; record misses. Rehearse the Oracle-reclaim recovery: fresh VM, restore, deploy, DNS; record the time. Draft the DPDP trace from the founder's legal summary and mark every unmatched duty as an open item, not as done. Apply the PRD cut order (CON-008) if time is short.

#### Acceptance criteria

```gherkin
Feature: Launch readiness

  Scenario: Backup restore with real data
    Given the nightly backup of the production-like environment
    When make restore-rehearsal runs
    Then counts and a sampled document match and the time taken is recorded

  Scenario: Unaided task completion
    Given five first-time users
    When each attempts sign-in, profile, a swipe and a confirmed request without help
    Then at least four complete it and the misses are logged

  Scenario: Inactive accounts are removed
    Given an account inactive for 12 months
    When the daily job runs
    Then the account, its documents and its share links are gone
```

#### Security and privacy considerations

Final security pass: run `make verify`, review `SecurityMatrixTest` coverage for every route, confirm no secrets in the repository history (secret scan across history), confirm the firewall list, confirm the notice matches the data map and processors, and confirm the backup copy's location is disclosed.

#### Observability

Dashboard shows queue depth, failures, `UNKNOWN` emails, last backup time, last heartbeat time, database size against the 400 MB alert.

#### Documentation updates

README, RUNBOOK, DPDP_TRACE.md, PERFORMANCE.md, BROWSERS.md, USABILITY_TEST.md, TRADEOFFS.md final, CHANGELOG, TRACEABILITY.md complete.

#### Verification

1. `make verify` -> expected: exit 0 with all gates PASS.
2. `bash scripts/check-traceability.sh` -> expected: every P0 and P1 requirement has at least one test reference.
3. `make restore-rehearsal` -> expected: counts match, exit 0.
4. `bash scripts/cost-guard.sh` -> expected: no paid shapes; monthly charge checklist signed.
5. Manual: usability test and browser matrix -> expected: results recorded in the docs above.
6. Evidence report per section 13.

#### Definition of done

- [ ] Contracts reviewed and committed
- [ ] RED evidence recorded, then GREEN
- [ ] `make verify` passes for tier A plus security gates
- [ ] Traceability complete; every P2 item confirmed unbuilt
- [ ] DPDP trace complete with open items listed; decisions logged
- [ ] Human approvals resolved: launch go decision, final deploy, privacy notice final
- [ ] At least 30 usable manufacturers in each pilot category loaded (PRD D-20)
- [ ] Launch on 2026-12-01 or a logged reason and new date (CON-001)

---
