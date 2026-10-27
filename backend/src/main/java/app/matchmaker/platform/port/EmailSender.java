package app.matchmaker.platform.port;

/** Provider boundary for a single confirmed, outbox-controlled introduction. */
public interface EmailSender {
    DeliveryResult send(String idempotencyKey, String recipient, String subject, String body);

    enum DeliveryResult { SENT, FAILED, UNKNOWN }
}
