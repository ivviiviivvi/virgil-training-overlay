# UX & Accessibility Journal

## Learnings

### Output Format Stability
- **Date**: 2024-05-22
- **Context**: CLI output for downstream consumption.
- **Decision**: Strictly preserved the `New focus: <App Name>` format.
- **Reasoning**: Changing the output format (e.g., adding timestamps, changing prefixes) breaks existing scripts and tools that rely on this specific contract. Improvements must not alter the established interface.

### CLI Discoverability
- **Date**: 2024-10-12
- **Context**: CLI tool usage.
- **Learning**: Users expect standard flags like `-h` and `--help` to exist.
- **Action**: Always implement these flags even for simple tools to provide immediate documentation.
