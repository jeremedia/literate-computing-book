# Chapter 14: Measuring Literateness

## Opening Example
You have two assistants. Both can talk, but only one gives a working SwiftBar script, a one-line health verdict, and a diff of what changed after your last config. Which is more literate for your task?

## Core Concept
You can measure literateness with practical signals. The goal is not a universal score. The goal is fitness for your use.

## Signals and Simple Rubrics
- **Intent Fit.** Does the output match the requested outcome without extra steps?
- **Actionability.** Are there runnable commands, scripts, or clear procedures?
- **Compression.** Can you scan the result in under 10 seconds and know what to do?
- **Attribution.** Are data sources and assumptions stated?
- **Reusability.** Can you lift the artifact into your stack with minimal edits?
- **Safety.** Are risks and rollbacks identified before change?

### A Quick 5-point Checklist
1. One-sentence answer at the top.
2. Runnable artifact included.
3. Verification steps listed.
4. Inputs and sources named.
5. Obvious next action suggested.

## Practical Patterns
- Benchmark assistants on your real tasks, not trivia.
- Keep a gallery of good outputs to set the bar for new ones.
- Review failures. Improve prompts, guardrails, or access as needed.

## Summary
- Literateness is observable.
- Measure what matters for your workflow: fit, action, compression, attribution, reuse, safety.
