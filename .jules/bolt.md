# Performance Journal

## Learnings

### Event-Driven vs Polling
- **Date**: 2024-05-22
- **Context**: Monitoring frontmost application changes.
- **Change**: Switched from `Timer`-based polling (1s interval) to `NSWorkspace.didActivateApplicationNotification`.
- **Impact**: Reduced CPU usage and battery drain by only waking up when the OS notifies of a change, rather than waking up every second regardless of activity. This aligns with the "event-driven over polling" directive.

### String Sanitization Performance
- **Date**: 2024-10-26
- **Context**: Sanitizing application names for log output.
- **Change**: Replaced `components(separatedBy: CharacterSet.controlCharacters).joined()` with a loop filtering `unicodeScalars`.
- **Impact**: Eliminates intermediate array and string allocations, reducing memory overhead and CPU usage for every focus change event. Also added truncation to 128 chars to prevent DoS.
