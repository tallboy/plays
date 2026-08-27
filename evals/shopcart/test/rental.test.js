const test = require('node:test');
const assert = require('node:assert');
const { rentalCost } = require('../lib/rental');

test('same-day rental bills one day', () => {
  assert.strictEqual(rentalCost('2026-03-10', '2026-03-10', 500), 500);
});
