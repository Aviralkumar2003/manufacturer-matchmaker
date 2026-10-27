package app.matchmaker.platform.port;

import java.time.Instant;

/** Injected time source for jobs, expiry and deterministic tests. */
public interface Clock {
    Instant now();
}
