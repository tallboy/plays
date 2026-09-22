#!/usr/bin/env node
import { readFileSync } from "node:fs";
import { sift } from "../src/filter.js";
const [, , level = "info", file] = process.argv;
const raw = file ? readFileSync(file, "utf8") : readFileSync(0, "utf8");
const out = sift(raw.split("\n"), level);
for (const r of out) console.log(`${r.ts} ${r.level.toUpperCase()} ${r.msg}`);
console.error(`sift: ${out.length} of ${raw.split("\n").filter(Boolean).length} lines kept`);
