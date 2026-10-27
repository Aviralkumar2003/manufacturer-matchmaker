-- Checkpoint 1 platform schema. Flyway executes this as the schema owner.
-- Application-role grants are applied only after Supabase role support is confirmed in SP-3.

CREATE TABLE app_errors (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    occurred_at timestamptz NOT NULL,
    route_template varchar(200) NOT NULL,
    http_status integer NOT NULL CHECK (http_status BETWEEN 400 AND 599),
    request_id varchar(128) NOT NULL,
    exception_class varchar(200) NOT NULL
);

CREATE TABLE job_runs (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_name varchar(80) NOT NULL,
    started_at timestamptz NOT NULL,
    ended_at timestamptz,
    outcome varchar(20) NOT NULL CHECK (outcome IN ('RUNNING', 'SUCCEEDED', 'FAILED')),
    item_count integer NOT NULL DEFAULT 0 CHECK (item_count >= 0)
);

CREATE TABLE heartbeat (
    id smallint PRIMARY KEY CHECK (id = 1),
    last_written_at timestamptz NOT NULL
);

CREATE TABLE audit_log (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    -- pii: yes; actor identity used for admin accountability.
    actor_id varchar(128) NOT NULL,
    action varchar(80) NOT NULL,
    target_type varchar(80) NOT NULL,
    target_id varchar(128) NOT NULL,
    occurred_at timestamptz NOT NULL,
    change_summary varchar(500)
);

CREATE TABLE consent_record (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    -- pii: yes; to be pseudonymized on account deletion under O-16.
    consumer_id varchar(128),
    manufacturer_id varchar(128) NOT NULL,
    -- pii: yes; selected item identifiers can identify private documents.
    item_ids text NOT NULL,
    notice_version varchar(40) NOT NULL,
    consented_at timestamptz NOT NULL
);

CREATE FUNCTION reject_append_only_change() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION 'append-only table cannot be changed';
END;
$$;

CREATE TRIGGER audit_log_append_only
BEFORE UPDATE OR DELETE ON audit_log
FOR EACH ROW EXECUTE FUNCTION reject_append_only_change();

CREATE TRIGGER consent_record_append_only
BEFORE UPDATE OR DELETE ON consent_record
FOR EACH ROW EXECUTE FUNCTION reject_append_only_change();
