# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

## 2026-01-09 - Input Truncation for DoS Prevention
**Vulnerability:** Unbounded input length for application names could lead to excessive resource consumption (DoS).
**Learning:** Truncation is not just a performance optimization but a critical security control for availability.
**Prevention:** Enforce strict length limits (e.g., 128 chars) on all untrusted inputs before processing.
