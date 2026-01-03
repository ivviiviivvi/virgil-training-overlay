# Performance Journal

## Learnings

### Event-Driven vs Polling
- **Date**: 2024-05-22
- **Context**: Monitoring frontmost application changes.
- **Change**: Switched from `Timer`-based polling (1s interval) to `NSWorkspace.didActivateApplicationNotification`.
- **Impact**: Reduced CPU usage and battery drain by only waking up when the OS notifies of a change, rather than waking up every second regardless of activity. This aligns with the "event-driven over polling" directive.

### String Sanitization Optimization
- **Date**: 2024-05-22
- **Context**: `getSanitizedAppName` execution on every application switch.
- **Change**: Replaced `components(separatedBy:).joined()` with direct `Unicode.Scalar` filtering and `reserveCapacity`.
- **Impact**: Removes allocation overhead of array creation and splitting. O(N) complexity is maintained but with significantly lower constant factors and memory pressure.
- **Constraint**: Due to Swift 5.5, control character checks must happen on `Unicode.Scalar` elements as `Character` lacks `isControl`.
