## 2024-05-24 - [String Sanitization Allocation]
**Learning:** Even simple string operations like `components(separatedBy:).joined()` can be expensive due to array allocation, especially in hot paths or event handlers.
**Action:** Use `rangeOfCharacter(from:)` to check for the necessity of sanitization before performing expensive split/join operations. This creates a zero-allocation fast path for the common case.
