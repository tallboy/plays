---
name: unslop
description: "Cut AI tells from a piece of writing — PR descriptions, issue bodies, docs, commit messages, README copy — and put a human voice back in. Use for 'unslop this', or on any prose surface a person will read."
---

# Unslop

Edit text to remove AI patterns and put a human voice back in. Preserve meaning and match the intended tone. Do not "improve" the argument, only the prose.

Best applied at generation time, not as cleanup: write the prose clean as you draft it, because the cleanup-afterward pass tends to fail. When editing an existing text: scan for the patterns below, rewrite, then self-audit ("what still makes this obviously AI-generated?"), then name the two or three patterns you cut.

**Add voice back.** Removing patterns is half the job; sterile, voiceless writing is just as obvious as slop. Have opinions — react to facts instead of neutrally listing pros and cons. Vary rhythm. Acknowledge complexity ("fast, but the cache invalidation will bite us" beats "fast"). Use "I" when it fits. Be specific: not "this is concerning" but the exact endpoint and what it does twice.

## Patterns

Two are matters of the author's taste, not hard rules: **13 (em dashes)** and **26 (abstract metaphor nouns)**. Flag those, don't silently enforce them, and follow the surrounding document's habits.

### Content

1. **Puffery.** "pivotal moment", "testament to", "evolving landscape", "setting the stage for". Cut it, state what happened.
2. **Name-dropping.** Listing tools or outlets without context. Pick one, say what it did.
3. **Superficial -ing phrases.** "highlighting...", "ensuring...", "showcasing...", "fostering...". Delete or expand with a real source.
4. **Promotional language.** "vibrant", "groundbreaking", "renowned", "stunning", "seamless". Use neutral descriptions.
5. **Vague attributions.** "Experts believe", "Industry reports suggest". Name the source or delete.
6. **Formulaic challenges.** "Despite challenges... continues to thrive." Replace with specific facts.

### Language

7. **AI vocabulary.** Additionally, crucial, delve, enhance, fostering, garner, interplay, intricate, landscape (abstract), pivotal, showcase, tapestry, testament, underscore, vibrant. Replace with plain words.
8. **Fancy ways to say "is".** "serves as", "stands as", "boasts", "features". Just say "is" or "has".
9. **"Not just X, but Y."** State the point directly.
10. **Rule of three.** Forcing ideas into groups of three. Use the natural number.
11. **Synonym cycling.** Four names for the same thing in one paragraph. Pick one, repeat it.
12. **False ranges.** "from X to Y" where X and Y are not on a meaningful scale. List the topics directly.

### Style

13. **Em dash overuse.** *(Author's taste — flag, don't enforce.)* If the writing leans on them, offer periods or commas; match the document's habits.
14. **Colon overuse.** Fine before a list or example; not as a mid-sentence connector. Rewrite so the point stands on its own.
15. **Boldface overuse.** Don't bold every proper noun or acronym.
16. **Inline-header lists.** The tell is a bold label and colon that restates the line: "**Performance:** Performance improved...". Convert to prose. A bold lead-in ending in a period, naming the item, followed by genuinely new detail is fine.
17. **Title Case Headings.** Use sentence case.
18. **Decorative emojis.** Remove from headings and bullets. (Status markers that carry meaning are not decoration.)
19. **Curly quotes.** Replace with straight quotes.

### Communication artifacts

20. **Chatbot phrases.** "I hope this helps!", "Let me know if...", "Certainly!", "Found the smoking gun!" Remove.
21. **Cutoff disclaimers.** "While specific details are limited..." Find the source or remove.
22. **Sycophantic tone.** "Great question! You're absolutely right!" Respond directly.

### Filler

23. **Filler phrases.** "In order to" → "To". "Due to the fact that" → "Because". "It is important to note that" → delete.
24. **Excessive hedging.** "could potentially possibly be argued that it might" → "may".
25. **Generic conclusions.** "The future looks bright." State specific plans or facts.

### Jargon

26. **Abstract metaphor nouns.** *(Author's taste — flag, don't enforce.)* Substrate, wedge, vector, nexus, primitive (as noun), harness (as metaphor), bedrock, paradigm, north star, flywheel. Each usually has a plainer concrete word. Suggest it, but leave a term alone when it's the project's actual vocabulary.

### Plain speech

27. **Say what it does, not how it feels.** "prices you can trust" names a feeling; the fix names the mechanism or a number. Ask what the sentence tells the reader to do or know, then write that. If you can't restate it as a concrete instruction, fact, or number, cut it. And if the sentence could appear unchanged in another project's docs, it says nothing about this one — cut it.
28. **Shorten or split dense sentences.** If the reader backtracks to parse it, break it in two. One idea per sentence.
29. **Active voice.** Catch "is/are/was/were + past participle" and name the actor. Passive is fine only when the actor is unknown or genuinely doesn't matter.
30. **Cut adverbs, or use a stronger verb.** "runs quickly" → "is fast" or the number. "significantly improves" → the measured delta.
31. **Prefer the plain word.** "utilize" → "use", "leverage" → "use", "facilitate" → "help", "numerous" → "many", "in the event that" → "if".
