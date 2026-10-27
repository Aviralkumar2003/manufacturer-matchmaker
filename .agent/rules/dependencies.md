# dependencies

| U9 | Only approved dependencies (section 10). Exact versions, lockfiles committed (`package-lock.json`; Maven versions pinned through the Boot parent and explicit properties). Dependency audit in CI. | Typosquatting and unvetted packages. [R:SR-13] | `make verify` runs the audit gate; `add-dependency` workflow record exists for anything new. | Skill U9 |

## 10. Approved dependencies

**Only the dependencies below may be imported or installed.** Anything else requires the `add-dependency` workflow (`.agent/workflows/add-dependency.md`) and human approval. The full evidence is in `.agent/docs/DEPENDENCY_RESEARCH.md`.

**Version rule (project policy):** pin the newest release that is at least 14 days old when you scaffold, never below the "verified latest" floor where one is shown, and re-run advisory checks before each pin. A newly published release can carry malicious code before it is caught. "Verified" means read from the official registry or release page on 2026-10-26.

### 10.1 Runtime and build

| ID | Package or service | Version (verified 2026-10-26) | Purpose (requirement IDs) | License | Cost | Alternatives rejected | Exit / lock-in | Status |
|---|---|---|---|---|---|---|---|---|
| DEP-001 | Eclipse Temurin JDK/JRE | 25.0.4 (or later 25.0.x) | Runtime for all backend requirements | GPLv2 with Classpath Exception | Free | Java 21; other JDK builds | Any OpenJDK 25 build | Confirmed |
| DEP-002 | Spring Boot (parent and starters listed in C.2) | 4.1.2 verified latest on 2026-10-22 | Backend: FR-001 to FR-052, NFR-004 to NFR-009 | Apache-2.0 | Free | Boot 3.5 (support ended 2026-06-30) | Standard Spring APIs | Confirmed |
| DEP-003 | Flyway (through `spring-boot-starter-flyway`) | Managed by Boot BOM | Schema migrations (BD-12) | Apache-2.0 (community edition) | Free | Liquibase | SQL files are portable | Confirmed |
| DEP-004 | PostgreSQL JDBC driver | Managed by Boot BOM | Database access | BSD-2-Clause | Free | none | Standard JDBC | Confirmed |
| DEP-005 | AWS SDK for Java v2, S3 module and URL-connection HTTP client only | Resolve at CP1 from the official release page; **Unverified** | Object storage via the S3-compatible API of Oracle Object Storage and the backup provider (FR-005, FR-007, NFR-004, NFR-016) | Apache-2.0 | Free | Oracle's own Java SDK (larger tree) | `ObjectStore` port with one adapter | Proposed (version unverified; spike SP-5) |
| DEP-006 | Resend (service, REST over `RestClient`; no SDK) | n/a | Manufacturer emails, bounce webhooks (FR-031, FR-036, NFR-009, NFR-017) | Service terms | Free plan | Brevo (footer branding on free emails) | `EmailSender` port; swap adapter | Confirmed |
| DEP-007 | Supabase (managed PostgreSQL only; no Auth, Storage or Edge Functions) | n/a | Primary database (BD-05) | Service terms | Free plan | On-VM Postgres; Neon | Standard PostgreSQL dump and restore | Confirmed |
| DEP-008 | Oracle Cloud Always Free: Arm VM, Object Storage | n/a | Hosting and documents (BD-04, BD-06) | Service terms | Free | Sleeping container hosts | Docker image runs anywhere; S3 API for storage | Confirmed |
| DEP-009 | Google Identity (OpenID Connect) | n/a | Sign-in (FR-001) | Service terms | Free | Email/password, OTP (declined) | Standard OIDC | Confirmed |
| DEP-010 | Caddy | Resolve official release at CP1; **Unverified** | TLS, routing, static files (BD-11) | Apache-2.0 | Free | nginx | Config is small and portable | Proposed (version unverified) |
| DEP-011 | Second backup provider (Cloudflare R2 or Backblaze B2) | n/a | Off-site encrypted backups (NFR-016) | Service terms | Free tier | none | S3 API | Open (O-04) |
| DEP-012 | All India Pincode Directory dataset | Latest published file | Distance (FR-020, FR-045) | GODL-India open licence | Free | Paid geocoding API | Table in own database | Confirmed (coverage unverified) |
| DEP-013 | GnuPG or `age` for backup encryption | Choose at CP1 through add-dependency; **Unverified** | Backup confidentiality (NFR-016) | GPL-3.0 (GnuPG) / BSD-3 (age), to verify | Free | none | Replaceable | Open (O-17) |

### 10.2 Frontend (npm; versions read from the registry on 2026-10-26)

| ID | Package | Latest verified | Published | License | Purpose | Status |
|---|---|---|---|---|---|---|
| DEP-020 | `react`, `react-dom` | 19.3.1 | 2026-10-14 | MIT | UI | Confirmed |
| DEP-021 | `vite`, `@vitejs/plugin-react` | 8.3.5; 6.1.2 | 2026-10-21; 2026-10-05 | MIT | Build | Confirmed |
| DEP-022 | `typescript` | 7.0.2 | 2026-07-08 | Apache-2.0 | Types (compatibility check SP-8) | Proposed |
| DEP-023 | `react-router` | 8.5.0 | 2026-10-19 | MIT | Routing | Confirmed |
| DEP-024 | `@tanstack/react-query` | 5.105.0 | 2026-10-26 | MIT | Server state | Confirmed |
| DEP-025 | `i18next`, `react-i18next` | 26.5.11; 17.1.9 | 2026-10-25 | MIT | English and Hindi strings (FR-003, NFR-012) | Confirmed |
| DEP-026 | `motion` | 14.6.0 | 2026-10-22 | MIT | Swipe and drag animation (FR-018, NFR-019). `@use-gesture/react` rejected: last release 2024-03-21. | Confirmed |
| DEP-027 | `vitest` | 5.0.5 | 2026-10-15 | MIT | Unit tests | Confirmed |
| DEP-028 | `@playwright/test` | 1.64.1 | 2026-10-14 | Apache-2.0 | End-to-end and performance tests | Confirmed |
| DEP-029 | `@axe-core/playwright` | 4.14.0 | 2026-10-15 | MPL-2.0 (dev-only, file-level copyleft; not shipped) | Accessibility gate (NFR-013) | Confirmed |
| DEP-030 | `eslint`, `prettier` | 10.13.0; 3.9.10 | 2026-10-16; 2026-10-10 | MIT | Lint and format | Confirmed |

The package names above exist on the npm registry with no install-time lifecycle scripts for `motion` and `@use-gesture/react` (checked); install with `npm ci --ignore-scripts` and review any script before allowing it.

### 10.3 Development, quality and security tooling

Categories are approved. **The concrete Java tools below must go through `add-dependency` in checkpoint 1** because their versions and maintenance were not verified (GitHub rate limits blocked the check on 2026-10-26).

| ID | Category | Candidate | Gate it serves | Status |
|---|---|---|---|---|
| DEP-040 | Java test stack | JUnit 5 and Spring Boot test starters (managed by Boot), Testcontainers 2.x (managed by Boot; Boot 4 migration notes point to Testcontainers 2.x) | Tests with a real PostgreSQL container | Proposed |
| DEP-041 | Java coverage | JaCoCo (Maven plugin) | Coverage floors | Proposed (version unverified) |
| DEP-042 | Java format and lint | A formatter plugin and a linter plugin chosen in CP1 | `make lint` | Open |
| DEP-043 | Static analysis (SAST) | Semgrep Community Edition, or SpotBugs with Find Security Bugs | Zero high or medium findings | Open (choose in CP1) |
| DEP-044 | Secret scanning | gitleaks | Pre-commit and CI | Proposed (version unverified) |
| DEP-045 | Dependency audit | OSV-Scanner for Maven and npm; `npm audit` | Zero unmitigated high or critical | Proposed (version unverified) |

---
