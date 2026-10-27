---
name: free-tier-operations
description: Prepare or verify Oracle Always Free deployment, Supabase resilience, encrypted backups, health alerts, and zero-cost safeguards. Use for checkpoint 1 infrastructure or later operational changes.
---

# Free-tier operations

Use only the confirmed stack in `AGENTS.md`. Plan for one Oracle Always Free Arm VM in Mumbai, a Supabase free PostgreSQL project in Mumbai, private Oracle Object Storage, Resend free, and Caddy. Make configuration through environment variables; example files list names without values. A deploy dry run must enumerate resources, ports, image tags, env names and expected changes for founder review.

The nightly database dump is encrypted before off-site transfer. Keep 14 copies and test restore into a scratch database with row counts and a document sample. Record job outcomes and maintain a daily database heartbeat and external uptime check. Do not upload to a second provider until O-04 is decided. Production deployment, paid resources, destructive restore, CI changes and secrets changes require founder approval under the bootstrap prompt.

Follow `.agent/workflows/verify.md` and `docs/RUNBOOK.md` for evidence. Do not claim cloud spikes passed from documentation alone; each spike requires an actual account-specific result where the prompt calls for one.
