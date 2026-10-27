# Light threat model

## Assets and trust boundaries

Assets: consumer documents and briefs, consent selections, share tokens, Google sessions, manufacturer contact data, audit records, backup keys. Boundaries: browser to Caddy, Caddy to backend, backend to PostgreSQL, object storage and Resend, and emailed share links to anonymous viewers.

## Abuse cases and planned controls

| Abuse case | Control | Verification |
|---|---|---|
| Another consumer reads a document | Owner checks using the session principal; private bucket | SecurityMatrixTest, ShareLinkTest |
| Share token is guessed, leaked, reused after revoke or expiry | 32 random bytes; hash at rest; no-store response; immediate revocation | ShareLinkTest |
| An unconfirmed swipe sends data | Explicit per-request consent; transactional outbox | ConsentRecordTest, OutboxIdempotencyTest |
| Upload executes active content or exceeds limits | Signature allowlist, attachment disposition, size and count limits | UploadValidationTest |
| CSRF changes state using a session cookie | CSRF token on mutations; SameSite cookie | CsrfTest |
| A bug alters audit or consent history | Restricted role plus database trigger | AuditImmutabilityTest |
| A leaked backup exposes private data | Encrypt before upload, separate provider, key outside repo | BackupJobTest, restore rehearsal |

Revisit the sharing boundary in checkpoint 5 and record new threats as functionality appears.
