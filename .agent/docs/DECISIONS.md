### 4.2 Bootstrap decision register

## New decision, 2026-10-27

| ID | Decision | Rationale | Approved by | Status |
|---|---|---|---|---|
| BD-14 | Permit the existing Spring Boot 4.1.2 pin as an exception to the 14-day release-age rule for checkpoint 1. | Section 10 requires a minimum of 4.1.2 while the same section's 14-day rule would otherwise forbid it until 2026-11-05. | Founder, in this chat on 2026-10-27 | Approved; advisory audit still required before build verification |

| ID | Decision | Alternatives declined | Rationale | Source | Status |
|---|---|---|---|---|---|
| BD-01 | Java 25 LTS, Spring Boot 4.1.x, Maven | Java 21; Gradle; Boot 3.5 (open-source support ended 2026-06-30) | Boot 4.1 is the supported line; Java 25 is the current LTS | Founder; [D:https://endoflife.date/spring-boot, retrieved 2026-10-26] | Confirmed |
| BD-02 | React + Vite + TypeScript SPA under `/app/`; landing page as separate static HTML | Server-rendered Thymeleaf with htmx (skill recommendation) | Founder preference. Cost: two build artifacts, CSRF handling, larger first load. Static landing page preserves indexability and LCP. | Founder | Confirmed |
| BD-03 | Tier A plus tier-B security gates | Pure tier A; tier C | Public site with real documents | Founder, skill rule | Confirmed |
| BD-04 | Oracle Always Free VM, Always Free account only | Pay-As-You-Go at $0 usage; sleeping container hosts | Keeps AC-NFR-001 literally true. Accepts that Oracle may reclaim idle instances, and that allowances have changed before. | Founder; [D:https://docs.oracle.com/en-us/iaas/Content/FreeTier/resourceref.htm, retrieved 2026-10-26] | Confirmed |
| BD-05 | Supabase free Postgres, Mumbai. App performs its own backups and a daily heartbeat write. | Postgres in Docker on the VM (recommended); Neon free | Founder choice. Accepts: pause after one week of low activity, 500 MB cap, no automatic backups. | Founder; [D:https://supabase.com/pricing, retrieved 2026-10-26] | Confirmed |
| BD-06 | Oracle Object Storage for documents; encrypted backups to a second provider | Cloudflare R2 or Backblaze B2 as primary | Same region as the VM; off-site copy survives loss of the Oracle tenancy | Founder | Confirmed |
| BD-07 | Resend free plan via REST (`RestClient`), no vendor SDK | Brevo; SDK usage | One fewer dependency; port keeps provider swappable | Founder; [D:https://resend.com/legal/acceptable-use, retrieved 2026-10-26] | Confirmed |
| BD-08 | PIN-code coordinates from the open All India Pincode Directory | Paid maps or geocoding API | Zero cost; open licence | Founder; [D:https://discuss.okfn.org/t/entry-for-postcodes-in/5423, retrieved 2026-10-26] | Confirmed |
| BD-09 | Hindi strings AI-drafted with no human review, in one file, plus a reviewer checklist of consent, privacy and error strings | Human translator | Founder choice. Risk: wrong Hindi on consent screens could weaken consent (FR-028). | Founder | Confirmed |
| BD-10 | Server-side sessions held in memory; users sign in again after a deploy | Spring Session JDBC (unresearched dependency) | Single instance; fewer moving parts | Skill default | Confirmed |
| BD-11 | Same-origin routing through Caddy: `/` landing, `/app/` SPA, `/api/` backend | Separate origins with CORS | Removes CORS and simplifies cookies | Skill default | Confirmed |
| BD-12 | Flyway forward-only migrations; rollback means fix-forward or restore from backup | Undo migrations | Undo availability in the community edition is unverified | Skill default | Confirmed |
| BD-13 | Agent guidance only in `AGENTS.md` and `.agent/` (no vendor-specific files) | A vendor-named context file as in the founder's example | Provider-neutral; switching tools means pointing at `AGENTS.md` | Skill rule | Confirmed |

**Superseded or declined:** the skill's recommendation of server-rendered pages (BD-02), and on-VM Postgres (BD-05). Both were declined by the founder with the trade-offs explained. Do not reintroduce them.

PRD decisions D-1 to D-22 are binding and are cited by ID in the register below.

---
