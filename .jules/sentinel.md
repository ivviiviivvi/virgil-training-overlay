# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

### Denial of Service (DoS) Prevention
- **Date**: 2024-05-22
- **Context**: Processing application names from `NSWorkspace`.
- **Threat**: An application name could be maliciously crafted to be extremely long, causing memory exhaustion or CPU spikes during sanitization/processing.
- **Mitigation**: Truncated application names to 128 characters using `.prefix(128)` before any processing or sanitization occurs.
