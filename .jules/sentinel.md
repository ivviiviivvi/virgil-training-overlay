# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

### Denial of Service Prevention (Input Length)
- **Date**: 2024-05-22
- **Context**: Processing application names from the system.
- **Threat**: Unbounded string inputs could lead to memory exhaustion or processing delays (DoS).
- **Mitigation**: Truncated application names to 128 characters before processing.
