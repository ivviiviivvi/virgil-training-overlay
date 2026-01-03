# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.
## 2024-05-23 - DoS Prevention via Input Truncation
**Vulnerability:** Unbounded string processing in `getSanitizedAppName`.
**Learning:** Even local CLI tools can be subject to DoS via memory exhaustion if they process external inputs (like application names) without length limits.
**Prevention:** Always truncate potentially unbounded inputs before processing (e.g., `.prefix(128)`).
