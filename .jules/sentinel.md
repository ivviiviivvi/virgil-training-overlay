# Security Journal

## Learnings

### Log Injection Prevention
- **Date**: 2024-05-22
- **Context**: Outputting application names to stdout.
- **Threat**: An application could have control characters in its name, potentially messing with the terminal or downstream log processors (Log Injection).
- **Mitigation**: Sanitized the `NSWorkspace` output by filtering out `CharacterSet.controlCharacters` from the application name before printing.

### DoS Prevention via Input Truncation
- **Date**: 2024-05-23
- **Context**: Processing potentially unbounded application name strings from the OS.
- **Threat**: A malicious or malformed application name could be extremely long, leading to excessive memory allocation or CPU usage during processing (Denial of Service).
- **Mitigation**: Truncated application names to 128 characters before further processing or sanitization.
