# Performance Journal

## Learnings

### Event-Driven vs Polling
- **Date**: 2024-05-22
- **Context**: Monitoring frontmost application changes.
- **Change**: Switched from `Timer`-based polling (1s interval) to `NSWorkspace.didActivateApplicationNotification`.
- **Impact**: Reduced CPU usage and battery drain by only waking up when the OS notifies of a change, rather than waking up every second regardless of activity. This aligns with the "event-driven over polling" directive.

### String Sanitization Performance
- **Date**: 2024-05-24
- **Context**: Removing control characters from application names.
- **Change**: Replaced `components(separatedBy:).joined()` with manual `unicodeScalars` iteration and pre-reserved string buffer.
- **Impact**: Reduces allocation overhead and memory pressure on every application switch. Prevents unnecessary array creation.
