## 2024-05-23 - [Polling to Event-Driven Refactor]
**Learning:** Polling usually wastes cycles. OS-level notifications are preferred for state changes like active app switching.
**Action:** Replace `Timer` polling with `NSWorkspace.didActivateApplicationNotification` observer.
