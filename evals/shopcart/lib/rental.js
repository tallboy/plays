const { daysBetween } = require('./dates');

function rentalCost(startISO, endISO, ratePerDayCents) {
  const days = Math.max(1, daysBetween(startISO, endISO));
  return days * ratePerDayCents;
}

module.exports = { rentalCost };
