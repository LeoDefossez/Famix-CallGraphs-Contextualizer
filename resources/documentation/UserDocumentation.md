# Famix CallGraphs Contextualizer

## Testing Strategy
Test organization follows approach described in testing Famix CallGraphs, a blog post about this is [availaible here](https://modularmoose.org/blog/2025-10-08-testing-your-algo-on-a-java-project/).

### Regenerate call stack trace for tests
To regenerate test artifacts (e.g., `exampleN.cs`), use the **[JavaCallStackExtractor](https://github.com/moosetechnology/JavaCallStackExtractor)**.

**Workflow:**
1.  Clone/Setup `JavaCallStackExtractor`.
2.  Adjust `config.json` based on the target example (see below).
3.  Run the extractor to overwrite the target file.

**Configuration Matrix:**

| Artifact | Configuration Notes |
| :--- | :--- |
| **Example 1** | Use the **default** `config.json` provided in the extractor repository. |
| **Example 2** | Use the **default** `config.json` provided in the extractor repository. |
| **Example 3** | Use the **default** `config.json` provided in the extractor repository. |