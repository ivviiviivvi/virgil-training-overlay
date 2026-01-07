# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

## 2024-05-24 - Input Truncation for DoS Prevention
**Vulnerability:** Unbounded input length for application names could lead to Denial of Service (DoS) if a malicious application sets an extremely long name, consuming excessive memory or CPU during processing/logging.
**Learning:** Always truncate external inputs to a reasonable maximum length (e.g., 128 characters) before processing.
**Prevention:** Applied `.prefix(128)` to the application name before sanitization.
