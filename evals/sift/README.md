# sift

A tiny CLI that filters structured log lines by level.

```bash
cat app.log | ./bin/sift.js warn
./bin/sift.js error app.log
```

Levels: `debug` < `info` < `warn` < `error`. Lines that don't parse are dropped.

## Working on it

`npm run check` runs the unit tests.

Scratch output from manual runs (filtered logs, captured terminal output, before/after
dumps) goes in `artifacts/`. It's gitignored — clear it out whenever.
