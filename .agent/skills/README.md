# Project skills

These focused procedures live inside `.agent/` to keep the repository provider neutral. Load a skill when its description matches the task. `AGENTS.md` and the bootstrap prompt retain authority; skills do not authorize deployments, dependency changes, or security changes.

The skills adapt useful patterns from [ECC contract-first](https://github.com/affaan-m/ECC/blob/main/skills/contract-first/SKILL.md), [database-migrations](https://github.com/affaan-m/ECC/blob/main/skills/database-migrations/SKILL.md), [accessibility](https://github.com/affaan-m/ECC/blob/main/skills/accessibility/SKILL.md), and [delivery-gate](https://github.com/affaan-m/ECC/tree/main/skills/delivery-gate). They are project-specific procedures, not verbatim copies. ECC's autonomous loops, payment, scraping, vendor-specific configuration, and unvetted hooks are out of scope under the bootstrap prompt.

| Skill | Use for |
|---|---|
| `checkpoint-delivery` | Starting or closing one numbered checkpoint |
| `contract-first` | HTTP, schema, or state-transition changes |
| `test-first-evidence` | RED/GREEN tests and quality-gate evidence |
| `secure-spring` | Backend security and document-sharing paths |
| `safe-migrations` | Flyway schema, roles, audit immutability, and data maps |
| `privacy-consent` | Privacy notice, deletion, per-request consent, and retention |
| `accessible-frontend` | React flows, English/Hindi text, and accessibility |
| `free-tier-operations` | Deployment, backups, restore, cost limits, and alerts |
