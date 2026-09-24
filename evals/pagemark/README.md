# pagemark

Chunks long documents into summarisable passages.

## Working on it

- `npm run check` — unit tests. Fast, free, run it constantly.
- `npm run eval` — scores generated summaries against `baseline.json` across the
  whole document matrix. **This calls the live summarisation API for every
  document and is billed per call.** Run it before a release, or when you've
  changed chunking behaviour. Never wire it into CI.
