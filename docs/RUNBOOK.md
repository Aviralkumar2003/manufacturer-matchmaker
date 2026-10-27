# Operations runbook

Status: checkpoint 1 outline. No production deployment or restore has been run.

## Deploy and rollback

1. Confirm Oracle account type is Always Free, home region Mumbai, and resource shapes pass `scripts/cost-guard.sh`.
2. Review `make deploy-dry-run`, image versions, environment variable names and DNS. Obtain founder approval for the actual deploy.
3. Deploy the immutable application image through Compose; check `/healthz` and the landing and SPA routes over HTTPS.
4. On failure, restore the previous image reference; do not reverse a merged Flyway migration. Fix forward or restore from a tested backup.

## Paused Supabase project

Check the provider console for pause state and resume manually. Verify restricted-role connectivity and `/healthz` after resume. Record the duration and any failed jobs.

## Nightly backup and restore

The backup must contain the PostgreSQL dump and private document manifest, be encrypted before upload, and retain 14 daily copies. Check the job record and alert on failure. Restore only into a scratch database during rehearsal, compare table row counts and a document sample, and record results. A destructive production restore requires founder approval.

## Reclaimed Oracle VM

Use the Always Free account in Mumbai to recreate the approved VM shape. Reapply firewall rules (80/443 inbound; SSH from founder IP only), fetch the pinned images, load secrets from outside the repository, point DNS, and verify HTTPS, `/healthz`, application access and backup reachability.

## Monthly zero-cost check

- [ ] Oracle resources and charges reviewed by founder.
- [ ] Supabase, Resend and backup-provider plans still free.
- [ ] Database size below 400 MB alert and provider cap.
- [ ] Backup restore evidence recent and uptime alert delivered to founder.
