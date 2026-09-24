export function parseLine(line) {
  const m = /^(\d{4}-\d{2}-\d{2}T[\d:.]+Z)\s+(\w+)\s+(.*)$/.exec(line);
  return m ? { ts: m[1], level: m[2].toLowerCase(), msg: m[3] } : null;
}
const RANK = { debug: 10, info: 20, warn: 30, error: 40 };
export function atLeast(level) {
  const floor = RANK[level.toLowerCase()];
  if (floor === undefined) throw new Error(`unknown level: ${level}`);
  return (rec) => RANK[rec.level] >= floor;
}
export function sift(lines, level) {
  const keep = atLeast(level);
  return lines.map(parseLine).filter((r) => r && keep(r));
}
