import { test } from "node:test";
import assert from "node:assert/strict";
import { chunk, splitSentences } from "../src/chunk.js";
test("splits on sentence ends", () => assert.equal(splitSentences("A one. B two! C three?").length, 3));
test("packs under the limit", () => { for (const c of chunk("x. ".repeat(400), 100)) assert.ok(c.length <= 100); });
test("never drops content", () => {
  const t = "Alpha beta. Gamma delta. Epsilon zeta.";
  assert.equal(chunk(t, 20).join(" ").replace(/\s+/g, " "), t.replace(/\s+/g, " "));
});
