# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.
## 2026-01-06 - Denial of Service Prevention
**Vulnerability:** Unbounded input strings (application names) could cause memory exhaustion or log flooding.
**Learning:** Even local inputs (like app names) can be spoofed or abnormally large, leading to potential DoS.
**Prevention:** Enforced a hard limit of 128 characters on application names using `.prefix(128)` before processing.
