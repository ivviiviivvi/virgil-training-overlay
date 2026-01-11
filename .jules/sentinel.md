# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

### DoS Prevention via Input Truncation
- **Date**: 2026-01-11
- **Context**: Processing application names from `NSWorkspace`.
- **Vulnerability**: The application processed unbounded input strings. A malicious app could provide a massive name, causing excessive resource usage (DoS).
- **Learning**: Even trusted system APIs can return unexpected data sizes.
- **Prevention**: Always truncate external inputs to reasonable limits (e.g., 128 characters) before processing.
