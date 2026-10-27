---
name: secure-spring
description: Implement or review Spring Boot routes, sessions, uploads, consent, and share links for this platform. Use when a backend change touches identity, authorization, private documents, or outbound email.
---

# Secure Spring

Read `.agent/rules/security.md`, `.agent/rules/privacy.md`, and bootstrap C.4 before changing the boundary. Default-deny `/api/`; use the authenticated session principal, never a caller-supplied owner id. Keep sessions server-side and CSRF enabled on state changes.

For documents, validate content signatures and limits, use random object keys and a private bucket, and return only owner-authorized or valid-share content as attachments. For share links, generate 32 random bytes, store only a hash, freeze the consented item set at confirmation, and check expiry and revocation on every read. Unknown, expired and revoked responses must match. The email outbox must prevent duplicate sends; ambiguous provider outcomes become `UNKNOWN`.

Add negative tests for forbidden access and leakage. Changes to auth, session, crypto, or sharing need founder approval under the bootstrap prompt before modifying implementation.
