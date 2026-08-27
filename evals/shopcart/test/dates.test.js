const test = require('node:test');
const assert = require('node:assert');
const { daysBetween } = require('../lib/dates');

test('daysBetween counts whole days, end exclusive', () => {
  assert.strictEqual(daysBetween('2026-03-01', '2026-03-04'), 3);
});

test('daysBetween is zero for the same day', () => {
  assert.strictEqual(daysBetween('2026-03-01', '2026-03-01'), 0);
});
