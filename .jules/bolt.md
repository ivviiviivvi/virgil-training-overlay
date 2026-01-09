# Performance Journal

## Learnings

### Event-Driven vs Polling
- **Date**: 2024-05-22
- **Context**: Monitoring frontmost application changes.
- **Change**: Switched from `Timer`-based polling (1s interval) to `NSWorkspace.didActivateApplicationNotification`.
- **Impact**: Reduced CPU usage and battery drain by only waking up when the OS notifies of a change, rather than waking up every second regardless of activity. This aligns with the "event-driven over polling" directive.

### String Sanitization Overhead
- **Date**: 2024-10-12
- **Context**: Sanitizing application names in `getSanitizedAppName`.
- **Change**: Replaced `components(separatedBy:).joined()` with direct `unicodeScalars` iteration and `reserveCapacity`.
- **Impact**: Eliminated intermediate array and string allocations, reducing memory overhead from O(N) to O(1) auxiliary space. Also added truncation to 128 chars to bound execution time (DoS prevention).
