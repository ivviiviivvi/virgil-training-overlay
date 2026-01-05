# Performance Journal

## Learnings

### Event-Driven vs Polling
- **Date**: 2024-05-22
- **Context**: Monitoring frontmost application changes.
- **Change**: Switched from `Timer`-based polling (1s interval) to `NSWorkspace.didActivateApplicationNotification`.
- **Impact**: Reduced CPU usage and battery drain by only waking up when the OS notifies of a change, rather than waking up every second regardless of activity. This aligns with the "event-driven over polling" directive.

### String Construction from Scalars
- **Date**: 2024-05-24
- **Context**: Sanitizing application names for logging.
- **Change**: Replaced `components(separatedBy:).joined()` with direct `Unicode.Scalar` iteration and `reserveCapacity`.
- **Impact**: Changed from O(n) allocation (creating multiple substrings) to O(1) allocation (single string buffer). Also prevents DoS via truncation.
