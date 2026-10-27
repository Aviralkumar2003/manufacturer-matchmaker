# Verify

Run `make verify` from the repository root. Record the exact command, exit code, and relevant output for each gate in the checkpoint evidence report. A gate is PASS only when its command ran successfully in this session. If a tool or service is unavailable, record NOT RUN with the reason; do not substitute an assertion.

The gate list and thresholds are in `docs/BOOTSTRAP_PROMPT.md` section 13. Diagnose a failure from the tool output, repair the product code, and rerun the affected gate. Run the full entry point before closing a checkpoint. Never lower a threshold or skip a test to get green.
