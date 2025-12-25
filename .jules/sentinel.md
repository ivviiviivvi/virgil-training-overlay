# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

### DoS Prevention via Input Truncation
- **Date**: 2025-12-25
- **Context**: Processing application names from NSWorkspace.
- **Threat**: Denial of Service (DoS) due to potentially unbounded string lengths and inefficient sanitization (high allocation).
- **Mitigation**: Truncated application names to 128 characters and replaced `components(separatedBy:)` with scalar iteration to reduce memory overhead and CPU usage.
