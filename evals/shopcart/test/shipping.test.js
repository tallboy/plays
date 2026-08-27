const test = require('node:test');
const assert = require('node:assert');
const { shippingEstimate } = require('../lib/shipping');

test('ordered March 1, delivered March 4 is 3 days in transit', () => {
  assert.strictEqual(shippingEstimate('2026-03-01', '2026-03-04'), 3);
});
