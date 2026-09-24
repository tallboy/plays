export function splitSentences(text) {
  return text.split(/(?<=[.!?])\s+/).map((s) => s.trim()).filter(Boolean);
}
export function chunk(text, maxChars = 480) {
  const out = [];
  let cur = "";
  for (const s of splitSentences(text)) {
    if (cur && cur.length + s.length + 1 > maxChars) { out.push(cur); cur = s; }
    else { cur = cur ? `${cur} ${s}` : s; }
  }
  if (cur) out.push(cur);
  return out;
}
