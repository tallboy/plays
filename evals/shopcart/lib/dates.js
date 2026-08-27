const MS_PER_DAY = 24 * 60 * 60 * 1000;

// Whole days from start to end, end exclusive.
function daysBetween(startISO, endISO) {
  const start = Date.parse(startISO);
  const end = Date.parse(endISO);
  return Math.floor((end - start) / MS_PER_DAY);
}

module.exports = { daysBetween };
