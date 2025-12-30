# Performance Journal

## Learnings

### Event-Driven vs Polling
- **Date**: 2024-05-22
- **Context**: Monitoring frontmost application changes.
- **Change**: Switched from `Timer`-based polling (1s interval) to `NSWorkspace.didActivateApplicationNotification`.
- **Impact**: Reduced CPU usage and battery drain by only waking up when the OS notifies of a change, rather than waking up every second regardless of activity. This aligns with the "event-driven over polling" directive.

### String Sanitization Overhead
- **Date**: 2025-12-30
- **Context**: Sanitizing application names for log injection prevention.
- **Learning**: Using `components(separatedBy:).joined()` for removing characters creates unnecessary intermediate arrays and substrings, causing allocation overhead.
- **Action**: Use `unicodeScalars` iteration with `reserveCapacity` and `append(Character(scalar))` for O(n) filtering with minimal allocation.
