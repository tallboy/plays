const { daysBetween } = require('./dates');

function shippingEstimate(orderISO, deliveryISO) {
  return daysBetween(orderISO, deliveryISO);
}

module.exports = { shippingEstimate };
