## 2024-05-23 - Event-Driven vs Polling
**Learning:** Polling for state changes (like active application) keeps the CPU active unnecessarily. Using system notifications (Event-driven) allows the process to sleep until an actual change occurs.
**Action:** Always check for system notifications or KVO (Key-Value Observing) opportunities before reaching for `Timer` or `setInterval`.
