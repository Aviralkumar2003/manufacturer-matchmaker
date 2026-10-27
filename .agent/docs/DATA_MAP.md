# Personal data map

The checkpoint 1 schema is a draft contract and has not been applied. Before adding a personal-data column, record the field, table or object store, purpose, retention, processor, and region here. Annotate the migration with `-- pii: yes` for `scripts/check-datamap.sh`.

| Field | Store | Purpose | Retention | Processor / region |
|---|---|---|---|---|
| `audit_log.actor_id` | PostgreSQL | Admin accountability | To be set in CP3 retention policy | Supabase / Mumbai |
| `consent_record.consumer_id` | PostgreSQL | Consent evidence; pseudonymize on account deletion | O-16 decision pending | Supabase / Mumbai |
| `consent_record.item_ids` | PostgreSQL | Fixed selection of shared items | O-16 decision pending | Supabase / Mumbai |

Processors anticipated by the prompt: Google, Supabase Mumbai, Oracle Cloud Mumbai, Resend, and a second backup provider to be chosen by the founder. The location of the second copy remains open (O-04).
