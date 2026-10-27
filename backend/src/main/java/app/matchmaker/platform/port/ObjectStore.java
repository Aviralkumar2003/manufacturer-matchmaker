package app.matchmaker.platform.port;

import java.io.InputStream;

/** Private object storage boundary. Implementations must never expose public object URLs. */
public interface ObjectStore {
    void put(String objectKey, InputStream content, long contentLength, String contentType);

    InputStream get(String objectKey);

    void delete(String objectKey);
}
