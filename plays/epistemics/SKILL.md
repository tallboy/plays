---
name: epistemics
description: "Confidence calibration for investigation output: five tiers from Direct to Unknown, phrasing that matches the tier, and the anti-rationalization and anti-sycophancy checks. Use when answering 'why is this built this way', 'how does X work', or any question answered from historical or fragmentary evidence."
---

# Epistemics

How to reason about confidence when evidence is historical, fragmentary, and sometimes contradictory — and how to communicate it without flattening it into false certainty. Code doesn't carry its own motivation: you can read what code does; you can't read *why it exists*. Pretending otherwise produces confident-sounding guesses that mislead the reader, who will act on them.

## Confidence tiers

Every claim in the output sits in one tier. The tier decides how the claim is phrased.

1. **Direct.** An explicit, textual citation that answers the question — something someone actually *wrote* (a PR description, an issue, a comment stating the reason). Not "the code does X so the author must have wanted X." Phrasing: confident, present tense, citation adjacent.
2. **Supported.** Several pieces of indirect evidence converge; no single source states it but the pattern makes it likely. Phrasing: confident but clearly derived — "the evidence points strongly to X: [the pieces]", each cited.
3. **Inferred.** A reasonable reading of context, with nothing explicit behind it. Phrasing: hedged — "appears", "likely", "is consistent with" — with the inference chain explicit: "Given A and B, C seems likely because D."
4. **Speculative.** A plausible hypothesis where other explanations fit equally well. Valuable, but marked: "One possibility is X, but we have no direct evidence."
5. **Unknown.** You looked and couldn't find out — a valid and important outcome. Be specific about *what* you searched: "we searched the issues for X, read the N PRs touching this file, grepped for the constant; none gave a rationale" is far more useful than "we couldn't find out."

## Phrasing discipline

- **Words that carry confidence** — "because", "the reason is", "was designed to", "fixes", "we decided" — imply Direct or Supported. A citation should sit immediately next to them.
- **Words that hedge** — "appears to", "likely", "suggests", "is consistent with", "one reading is" — signal interpretation. Use them liberally for inferences.
- **Words to avoid** — "obviously" (if it were obvious, nobody would ask), "clearly" (almost always precedes an unclear claim), "just" (dismissive, usually hiding uncertainty). Use "the evidence suggests", not "I think".

## The traps

**Rationalization.** Code that makes sense today may exist for reasons that no longer apply or were wrong at the time. Don't assume the author did the right thing and work backward to justify it; don't assume a repeated pattern was intentional when it might be copy-paste; don't turn absence of evidence into evidence of absence.

**Sycophancy.** Questions usually arrive with an embedded hypothesis ("I assume it's for performance?"). Treat it as one candidate among others and check the evidence independently. The user's guess is a prompt for investigation, not a conclusion to validate. Never cite the code as evidence for its own intent.

**Contradiction.** When two sources disagree, surface both with citations and let the reader call it. Don't pick the tidier narrative.

## Calibration check before delivering

1. Does every confident claim have a citation? If not, move it down a tier.
2. Is the phrasing calibrated to the tier? A Direct claim can use "because"; an Inferred claim cannot.
3. Am I treating the code itself as evidence for its own intent? Remove or reclassify.
4. Is there a "what we don't know" section? If no gaps are named, be suspicious — either the record was unusually complete, or something is being swept under the rug.
