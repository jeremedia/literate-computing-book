# Chapter 13: Capability vs Cognition

## Opening Example
You ask for “a topology sketch with the RB5009, the WiFi 7 AP, and the WAN uplink, plus the three most likely causes of packet loss right now.” The system responds with a diagram and a short ranked list, then proposes commands to confirm or rule out each hypothesis.

## Core Concept
Literate Technology exhibits sophisticated language capability. It does not possess human cognition. This distinction keeps you sane and your systems safe.

## What Capability Looks Like
- **Mapping intent to action.** From a short description, propose queries, commands, or scripts that advance your goal.
- **Synthesis.** Combine logs, counters, and configuration into a concise narrative and next steps.
- **Refinement.** Integrate your feedback to tighten scope, add metrics, or change presentation.

## What Cognition Would Be (and Why It Is Not Required)
Cognition implies beliefs, motivations, and subjective experience. LT has none of these. It produces language and artifacts that fit observed patterns and constraints. This is enough to multiply your capacity if you supply goals, guardrails, and checks.

## Practical Boundaries
- **Verification.** Require commands and outputs that you can check.
- **Attribution.** Track where facts came from and record the decision path.
- **Least privilege.** Grant only the access needed for the task.
- **Rollback.** Insist on revert plans for any change.

## Common Pitfalls
- Asking LT to decide goals. That is your job.
- Confusing fluency with authority. A crisp explanation can still be wrong.
- Letting exploration wander without checkpoints.

## Summary
- Capability is enough. You provide the purpose.
- Treat LT as a high-bandwidth language instrument with execution hooks.
- Keep clear lines between suggestion, verification, and change.
