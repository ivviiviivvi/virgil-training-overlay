# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

### DoS Prevention via Input Truncation
- **Date**: 2024-05-24
- **Context**: Processing application names from NSWorkspace.
- **Threat**: Extremely long application names could cause denial of service or performance degradation.
- **Mitigation**: Truncated application names to 128 characters before processing.
