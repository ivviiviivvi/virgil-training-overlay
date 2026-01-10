# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

## 2026-01-10 - DoS Prevention via Input Truncation
**Vulnerability:** The application processed unbounded input strings from `localizedName`. A malicious application could exploit this by providing an extremely long name, potentially causing excessive memory usage or CPU consumption during sanitization (Denial of Service).
**Learning:** Even "trusted" system APIs like `NSWorkspace` can return unexpected or malicious data from other running applications.
**Prevention:** Always truncate external inputs to reasonable limits (e.g., 128 characters) before processing or sanitization to bound resource usage.
