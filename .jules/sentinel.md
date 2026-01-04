# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

### Denial of Service via Unbounded Input
- **Date**: 2024-05-22
- **Context**: Processing application names from `NSWorkspace`.
- **Threat**: Extremely long application names (if spoofed or malformed) could cause excessive memory allocation or processing time, leading to Denial of Service (DoS).
- **Mitigation**: Truncated application names to 128 characters using `.prefix(128)` before processing or sanitization.
