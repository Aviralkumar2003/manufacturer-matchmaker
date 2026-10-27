---
name: privacy-consent
description: Implement or review privacy notices, account deletion, per-request manufacturer sharing, and personal-data retention. Use when a feature collects, shares, retains, or deletes personal data.
---

# Privacy and consent

Read `.agent/rules/privacy.md`, `.agent/docs/DATA_MAP.md`, and the relevant PRD criteria. Collect only the listed profile, brief and document fields. Show the notice and record its version and time before account creation. A right swipe opens a manufacturer-specific sharing review; nothing leaves the platform until explicit confirmation. Freeze the exact selected items in an append-only consent record.

Account deletion removes profile, brief, document rows and objects, invalidates all share links, and pseudonymizes consent records according to O-16's safe default until the founder decides otherwise. Keep the processor and region map current; the second backup provider and cross-border wording remain O-04. Avoid analytics or third-party scripts.

Verify forbidden cases: no email before confirmation; unselected documents never appear through a share link; revoked or deleted-account links reveal nothing; deletion leaves no owned object keys. Changes to consent or share-link logic require founder approval under bootstrap section 3.
