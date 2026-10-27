---
name: safe-migrations
description: Design and verify Flyway migrations, database roles, audit immutability, and personal-data mapping. Use when changing PostgreSQL schema or data retention.
---

# Safe migrations

Write forward-only migrations; never edit a merged migration. PostgreSQL is the target and Hibernate validates rather than creates schema. Use an owner role for migration and a restricted application role. Audit and consent rows require insert/select-only application permissions plus a trigger rejecting update and delete, subject to the approved pseudonymization function.

For every personal-data column, add `-- pii: yes` in the migration and an entry to `.agent/docs/DATA_MAP.md` with purpose, retention, processor and region. Add a migration test from an empty PostgreSQL database and test forbidden writes using the application role. Rehearse restore before any destructive schema action; that action needs founder approval.

Adapted from ECC's migration safety theme to the bootstrap's role split and data-map gates.
