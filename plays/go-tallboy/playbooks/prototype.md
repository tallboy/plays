# Prototype

**You own the design decision, not the code. The prototype is a throwaway instrument; the real build follows Feature.** For "prototype", "mock it up", "sketch this", "try this layout" — and for settling an empirical fork (which behavior, which timing, which approach) by observing it run, when you would otherwise ask the human a question a quick sketch could answer.

The one playbook where "smallest change" and the verification bar invert: speed over polish, code quality does not matter, no planning. The rigor is in picking the right design cheaply. Be bold — propose variations the user didn't ask for, throw an approach away and try another.

1. Scope the decision the prototype exists to make: which layout, which interaction, which behavior, which timing. No decision means no prototype; route to Feature.
2. Gather references when the design space is open; skip when the direction is set.
3. Build throwaway in an isolated scratch dir, separate from production source. For a visual decision: the lightest stack that renders the idea. For a behavioral or timing decision: the smallest script that exercises the question. No production framework, no tests, no abstractions.
4. When comparing alternatives, build them behind one switcher, each variant labeled so the user can name it. This is the arena skill's exploration made cheap.
5. Observe the thing you are deciding: screenshot each variant, log the timing, print the output. The observation is the test here, not an assertion.
6. Present alternatives, tradeoffs, and a recommendation. The output is the decision plus the throwaway artifact, not shippable code. Hand the chosen direction to Feature for the real build.

**Reply:** the variants explored, the evidence (screenshots or observed output), tradeoffs, your recommendation, and the scratch path. Say plainly that the prototype is throwaway.
