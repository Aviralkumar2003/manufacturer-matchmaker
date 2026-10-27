# logging-observability

### A.2 Logging

| Rule | Why | Verification |
|---|---|---|
| Structured JSON logs to stdout. Every line carries a request id (`X-Request-Id`, generated if absent). | Traceability, twelve-factor logging. | `LoggingTest` asserts JSON shape and request id presence. |
| Never log document contents, tokens, session ids, full email bodies, or Google ID tokens. Log user ids, not names or emails. Mask contact emails as `a***@domain`. | Privacy (NFR-010). | `LogRedactionTest` writes sentinel secrets and personal values and asserts they never appear in captured output. |
| Encode user-controlled values before logging. | Log injection. | Unit test with newline and control characters. |
| Admin audit events (FR-014) and consent records (FR-033) are database records, separate from diagnostic logs. | Different retention and integrity needs. | Covered by B.5 tests. |

### A.3 Observability

| Rule | Why | Verification |
|---|---|---|
| Liveness and readiness health endpoints; readiness includes a database check. Only these health groups are reachable from the internet. | Deploy checks, uptime alerts. | `curl -fsS "$APP_URL/healthz"` returns 200 and a body with no internals. |
| Record sanitized application errors (id, time, route template, status, request id, exception class) in table `app_errors`, and email outcomes in `email_events`; both visible on the admin screen. | NFR-015. | `ErrorRecordingTest`, `EmailEventTest`. |
| Expose request rate, error rate and duration metrics internally via Micrometer on the internal management port. | Operability. | Metrics endpoint reachable only from the Docker network (test in deploy dry run). |
