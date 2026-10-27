### 14.3 Open items (the agent must not decide these)

## Current workspace status, 2026-10-27

- `docs/PRD.md` v4 is present; the earlier missing-source blocker is resolved.
- The founder supplied `https://github.com/Aviralkumar2003/manufacturer-matchmaker`. A local Git checkout and `checkpoint/1-bootstrap` branch now exist. Remote push, PR review and history secret scan still need evidence.
- Founder will list which cloud prerequisites are ready. Do not record any of SP-1 through SP-10 as passed before account-specific checks.
- The dependency and CI changes required in checkpoint 1 need founder approval under bootstrap section 3. Prepare a specific list before requesting approval.
- The 4.1.2 release-age conflict is resolved by founder-approved exception BD-14; the advisory audit remains required.
- The founder approved the checkpoint 1 contract drafts in this chat on 2026-10-27; a separate contract commit is pending.
- Local toolchain audit on 2026-10-27: `make` was not found on PATH; `java -version` stalled in the sandbox and `JAVA_HOME` is empty. The existing Maven test passed outside the sandbox with Java 25.0.3, confirming a usable JDK for that command. A Make-compatible runner is still required for CP1's `make verify`. No full gate has been reported as passed.

| ID | Question | Who decides | Safe default until decided | Blocks |
|---|---|---|---|---|
| O-01 | Final product category list (PRD A8) | Founder | Two seeded pilot categories (cosmetics and personal care, food products), stored in an admin-managed table | CP3 |
| O-02 | Final document-type list | Founder | Seed GST certificate, FSSAI licence, ISO certificate, GMP certificate (the types named in the PRD), admin-managed | CP2 |
| O-03 | Distance radius options | Founder | 25, 50, 100, 250 km and "any", in configuration | CP4 |
| O-04 | Second backup provider (R2 or B2) and cross-border disclosure wording | Founder | Build the S3 adapter; make no upload to any non-Oracle provider until chosen; backups stay on Oracle storage in a separate bucket meanwhile | CP1 |
| O-05 | Domain name and sender address | Founder | Use placeholders in configuration only; no email sends | CP1 |
| O-06 | Admin Google account identifiers | Founder | No admin exists until configured | CP3 |
| O-07 | Resend webhook signature scheme, data region and sub-processor terms | Agent researches, founder approves | Do not enable the webhook endpoint | CP5 |
| O-08 | Supabase connection mode and restricted-role support | Agent spikes, founder approves | Stop at SP-3 and ask | CP1 |
| O-09 | Google OAuth publishing mode | Founder | Test mode with named testers only | CP2 |
| O-10 | Founder's legal advice summary for NFR-010 | Founder | Treat the DPDP trace as unreviewed | CP6 |
| O-11 | Native-speaker review of Hindi strings | Founder | Ship English fallback and review list | CP6 |
| O-12 | TypeScript major version | Agent spikes (SP-8), founder approves | Newest version supported by the lint toolchain | CP1 |
| O-13 | Java base package name | Founder | `app.matchmaker` | CP1 |
| O-14 | Oracle allowance mismatch (2 OCPU and 12 GB versus 4 and 24) | Founder | Plan for 2 OCPU and 12 GB | CP1 |
| O-15 | Whether application-level encryption of documents is needed | Founder | Only if SP-5 cannot confirm provider encryption at rest | CP1 |
| O-16 | Handling of consent records after account deletion | Founder (with legal advice) | Pseudonymize: drop consumer id and item names, keep time and manufacturer | CP2 |
| O-17 | Backup encryption tool (GnuPG or `age`) | Agent researches, founder approves | GnuPG symmetric encryption with a passphrase from the environment | CP1 |
| O-18 | Uptime monitor and alert channel | Founder | Hourly scheduled workflow requesting `/healthz` that emails the founder on failure | CP1 |

---
