# Common Pitfalls: Test-Driven Development

## Pitfall 1: Testing Implementation Instead of Behavior

**Symptom:** Tests break when refactoring even though behavior unchanged

**Fix:** Test what, not how. Test public interface, not internal implementation.

## Pitfall 2: Tests Too Large

**Symptom:** One test verifies multiple behaviors

**Fix:** One test, one behavior. Split into multiple focused tests.

## Pitfall 3: Shared State Between Tests

**Symptom:** Tests pass individually but fail when run together

**Fix:** Use fixtures, clean up after each test, ensure independence.

## Pitfall 4: Not Running Tests in RED Phase

**Symptom:** Test passes immediately (never saw it fail)

**Fix:** Always verify test fails before implementing feature.

## Pitfall 5: Writing Tests After Code

**Symptom:** Tests tailored to implementation, not requirements

**Fix:** Commit to RED-GREEN-REFACTOR cycle strictly.
