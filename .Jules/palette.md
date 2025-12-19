# Palette's Journal

## 2024-10-25 - CLI Responsiveness & Context
**Learning:** Users perceive CLI tools as "laggy" if they rely on polling (1s delay) for real-time events. Event-driven architectures (like NSWorkspace notifications) provide immediate feedback which feels "snappy". Additionally, real-time logs without timestamps lack critical context for debugging/tracking.
**Action:** Always prefer system notifications over polling for UI changes; always prefix real-time logs with `[HH:mm:ss]`.
