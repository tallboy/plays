import { test } from "node:test";
import assert from "node:assert/strict";
import { parseLine, sift } from "../src/filter.js";
const LINES = [
  "2026-01-04T10:00:00.000Z DEBUG cache warm",
  "2026-01-04T10:00:01.000Z INFO request ok",
  "2026-01-04T10:00:02.000Z ERROR upstream refused",
  "garbage",
];
test("parseLine returns null on junk", () => assert.equal(parseLine("garbage"), null));
test("sift keeps info and above", () => assert.deepEqual(sift(LINES, "info").map(r => r.level), ["info", "error"]));
test("sift keeps only error at error", () => assert.deepEqual(sift(LINES, "error").map(r => r.level), ["error"]));
test("unknown level throws", () => assert.throws(() => sift(LINES, "loud")));
