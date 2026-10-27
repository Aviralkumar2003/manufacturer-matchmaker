# coding-standards

### A.6 Coding standards

| Standard | Verification |
|---|---|
| Java: compile with `-Xlint:all` and `-Werror`; null-safety annotations at package level (JSpecify, built into Boot 4's null-safety approach, verify in CP1); records for DTOs; entities never serialized to clients. | `make lint` and compile gate. |
| TypeScript: `strict: true`, no `any` without a justification comment, ESLint clean, Prettier formatted. | `npm run typecheck && npm run lint`. |
| Formatter and linter are enforced in CI and in a pre-commit hook. Concrete Java tools are chosen in checkpoint 1 through the `add-dependency` workflow. | `make lint` in CI. |
| Dependency direction inward: `web -> service -> repository`; external systems (email, object storage, geocoding, clock) sit behind ports in `port/` with adapters in `adapter/`. | `ArchitectureTest` (rules expressed with plain JUnit reflection or an approved tool). |
| Configuration through validated `@ConfigurationProperties`; the app fails to start on invalid configuration. | `ConfigValidationTest`. |
| Time and randomness come from injected `Clock` and `SecureRandom` suppliers so tests are deterministic. | Tests never call `Instant.now()` directly (grep gate). |
| Day boundaries (request cap, upload window) use the `Asia/Kolkata` time zone. | `RateLimitDayBoundaryTest`. |

---

### C.2 Boot 4 structure and starters

| Rule | Why | Verification |
|---|---|---|
| Use the modular Boot 4 starters by their new names: `spring-boot-starter-webmvc`, `spring-boot-starter-security`, `spring-boot-starter-security-oauth2-client`, `spring-boot-starter-data-jpa`, `spring-boot-starter-validation`, `spring-boot-starter-actuator`, `spring-boot-starter-flyway`. Do not use the deprecated classic starters. [D:https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-4.0-Migration-Guide, retrieved 2026-10-26] | Boot 4 split large jars into focused modules and renamed several starters; Flyway needs its own starter. | `mvnw dependency:tree` contains only allowlisted starters (script check against section 10). |
| Use the Boot 4 test starters for the matching modules (for example the security test starter) and JUnit 5. | Boot 4 ships test modules per technology. | Tests compile and run. |
| Jackson 3 is the JSON library in Boot 4; use its package names and Boot's `JsonMapper` configuration. **Guidance (verify)** against the migration guide. | Package renames break old imports. | Build succeeds; `JsonContractTest`. |
| Package by feature under `app.matchmaker` (`identity`, `profile`, `documents`, `manufacturers`, `deck`, `consent`, `sharing`, `outcomes`, `admin`, `platform`). | Keeps modules small for a solo reviewer. | `ArchitectureTest`. |

### C.3 Persistence

| Rule | Verification |
|---|---|
| Flyway owns the schema. `spring.jpa.hibernate.ddl-auto=validate`; `spring.jpa.open-in-view=false`. Migrations are forward-only (BD-12) and never edited after merge. | `MigrationTest` applies all migrations to an empty PostgreSQL container (same major version as the Supabase project, confirmed in CP1) via Testcontainers and boots the app. |
| The application connects with a restricted database role (B.5); Flyway runs with the owner role supplied only in the deploy step. | `RoleSeparationTest`. |
| Entities are never returned from controllers; use records as DTOs. | `ArchitectureTest`. |
| Keep connection pool small (max 5) to respect Supabase free-plan limits. **Guidance (verify)** the connection limit and the pooler mode in CP1 spike SP-3. | Config test and the spike record. |

### C.5 Frontend

| Rule | Verification |
|---|---|
| Vite builds to `frontend/dist` with base path `/app/`; React Router (data router) for routes; TanStack Query for server state; i18next and react-i18next for strings; `motion` for drag and swipe animation. | `npm run build` succeeds. |
| TypeScript strict. Adopt TypeScript 7 only if ESLint, `typescript-eslint` and Vite plugins support it in the CP1 spike SP-8; otherwise pin the newest 5.x or 6.x that they support and log the reason. | `npm run typecheck`. |
| Deck performance (NFR-019): keep a window of the next 5 cards, with images prefetched, in client memory; a swipe commits locally first and syncs to the API in the background; roll back with a message on failure. Initial JS for `/app/` must stay under a budget of 200 kB gzipped (project policy; adjust only with a logged reason). | `npm run test:perf` measures pointer-release to next-card paint in Playwright (no network) and checks the bundle budget. |
| Landing page: hand-written static HTML and CSS in `landing/`, no framework, English at `/` and Hindi at `/hi/`, `hreflang` links, structured titles and descriptions, no third-party scripts. A small inline-free script file calls `/api/session` and redirects signed-in users to `/app/deck`. | `npm run test:landing` (Playwright) and a Lighthouse-style lab run recorded in CP6. |
| Service worker, offline mode and web push are out of scope. | None built. |
