# privacy

### A.4 Privacy baseline

Maintain `.agent/docs/DATA_MAP.md` (what personal data, where stored, why, retention, processors, region). Minimize collection to what the PRD lists. Processors in scope: Google (sign-in), Supabase, Oracle Cloud, Resend, the second backup provider. Any feature touching personal data updates the data map in the same change. Verification: `scripts/check-datamap.sh` fails if a new table or column holding personal data is added without a data-map entry (listed in a migration annotation comment `-- pii: yes`).

### B.1 Personal data and India's DPDP Act (trigger: NFR-010, FR-008, FR-009, NFR-011)

**Controls**
- Show the privacy notice and record consent (user id, notice version, timestamp) before account creation (FR-008). The notice states purposes, data shared with manufacturers only after per-request consent, retention, and how to delete.
- Account deletion (FR-009) removes the profile, brief, document rows and stored files, revokes all share links, and removes the consumer's rows from the audit-visible views. The consent records of FR-033 are **pseudonymized, not kept in identifiable form** (consumer id replaced by a tombstone, item names dropped) until the founder decides otherwise (open item O-16).
- Inactive-account deletion after 12 months (NFR-011) runs as a daily scheduled job; it logs counts only.
- Minimize: collect only fields in FR-004, FR-005, FR-007. No analytics trackers, no third-party scripts on any page.
- Manufacturer contact data (FR-010) has a recorded source URL and collection date and honors opt-out (FR-017) and admin removal within 2 business days (PRD G6).
- Data map and processor list per A.4. Region: Supabase Mumbai, Oracle Mumbai. The backup copy leaves India (open item O-04); it is encrypted before upload and the notice must say so.

**Verification:** `AccountDeletionTest` (rows, files, links), `InactiveAccountJobTest` (clock-controlled), `ConsentRecordTest`, `DataMapCheck`.

**Tests required:** deletion removes every table row and object key owned by the user (query all tables for the user id and assert zero); deleted user's share link returns "no longer available"; privacy-notice acceptance is mandatory.

### B.2 File uploads (trigger: FR-005, FR-007, NFR-007, NFR-008)

**Controls**
- Allow only PDF, JPG, PNG; decide the type by **file content signature**, not by name or declared content type; reject mismatches. Cap 10 MB per file, 25 files per consumer, 20 uploads per rolling hour (per consumer, counted in the database).
- Store under random object keys (`consumer-id/uuid`), never the user's file name. Keep the original name only as display metadata, sanitized.
- The bucket is private. Files are served only through authenticated API endpoints or the share-link endpoint, streamed with `Content-Disposition: attachment` and `X-Content-Type-Options: nosniff`.
- Reject PDF files with active content markers where the check is cheap (JavaScript, launch actions); record this as best effort in TRADEOFFS.md. Malware scanning is not adopted (cost); say so in the privacy notice for manufacturers: documents are unverified (CON-006).
- Enforce size limits at Caddy (`request_body max_size`) and in Spring (`spring.servlet.multipart.max-file-size`).

**Verification:** `UploadValidationTest`: 12 MB PDF rejected; DOCX rejected; renamed `.exe` as `.pdf` rejected; 26th file rejected; 21st upload within an hour refused with retry time; path-traversal names neutralized.
