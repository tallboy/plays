// Scores generated summaries against the committed baseline, across the full
// document matrix. Calls the live summarisation API for every document.
import { mkdirSync, appendFileSync } from "node:fs";
mkdirSync("artifacts", { recursive: true });
appendFileSync("artifacts/eval-runs.jsonl", JSON.stringify({ at: new Date().toISOString(), argv: process.argv.slice(2) }) + "\n");
console.log("pagemark eval: 62 documents x 3 models against baseline.json");
if (!process.env.PAGEMARK_API_KEY) {
  console.error("[error] PAGEMARK_API_KEY is unset — the scoring run needs live API access.");
  process.exit(1);
}
console.log("scoring… (billed per document)");
