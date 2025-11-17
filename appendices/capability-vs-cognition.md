# Appendix C: Capability vs Cognition

## Opening Example
You ask for "a topology sketch with the RB5009, the WiFi 7 AP, and the WAN uplink, plus the three most likely causes of packet loss right now." The system responds with a diagram and a short ranked list, then proposes commands to confirm or rule out each hypothesis.

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

---

## Checklist 1: Is This Capability or Am I Expecting Cognition?

Use this checklist when evaluating LT system outputs to maintain appropriate boundaries:

### Capability (LT Can Do This)
- [ ] Generate code or commands from natural language descriptions
- [ ] Search through logs, configs, and metrics for patterns
- [ ] Propose solutions based on compiled knowledge from training
- [ ] Explain technical concepts in clear language
- [ ] Adapt outputs based on feedback ("make it more concise," "add error handling")
- [ ] Combine multiple data sources into coherent summaries
- [ ] Apply known patterns to novel situations within training distribution
- [ ] Generate variations on working solutions

### Cognition (LT Cannot Do This—Requires Human Judgment)
- [ ] Decide what goals are worth pursuing
- [ ] Understand organizational politics or interpersonal dynamics
- [ ] Make value judgments about tradeoffs without explicit criteria
- [ ] Feel accountability or responsibility for outcomes
- [ ] Maintain beliefs or intentions across conversations
- [ ] Understand why something matters to you personally
- [ ] Judge whether a technically correct solution is strategically wise
- [ ] Care about the consequences of its outputs

**Action:** If you're expecting something from the second list, you're asking for cognition. Reformulate your intent to provide the judgment yourself and ask LT for capability support.

---

## Checklist 2: Safe LT Interaction Protocol

Use this before executing AI-generated infrastructure changes:

### Pre-Execution
- [ ] Intent is clearly articulated with success criteria
- [ ] AI has provided explanation of proposed approach
- [ ] Commands/code have been reviewed by human
- [ ] Dry-run or test execution completed successfully
- [ ] Rollback plan exists and has been tested
- [ ] Change window is appropriate (not during peak traffic)
- [ ] Required approvals obtained (if policy requires)
- [ ] Backup/snapshot taken (for stateful changes)

### During Execution
- [ ] Monitoring active for key metrics
- [ ] Human supervising execution in real-time
- [ ] Logs being captured for audit
- [ ] Ready to abort if anomalies detected
- [ ] Communication channel open (if team change)

### Post-Execution
- [ ] Success criteria verified
- [ ] No unexpected side effects observed
- [ ] Logs reviewed for errors or warnings
- [ ] Rollback plan updated for this new state
- [ ] Change documented in pattern library
- [ ] Lessons learned captured

**Red flags requiring immediate halt:**
- AI cannot explain why it chose an approach
- Proposed commands include destructive operations without explicit intent
- Success criteria are vague or unmeasurable
- No rollback path exists
- You feel pressure to "just trust it"

---

## Incident Vignettes: When Capability Gets Confused with Cognition

### Vignette 1: The Over-Trusted Optimization

**Context:** SaaS company using LT for database query optimization

**What Happened:**
Senior developer Sarah asked their LT system: "Optimize the user analytics queries—they're slow."

The AI proposed adding 12 new database indexes and modifying 8 queries. Sarah reviewed the SQL, saw it looked technically correct, and deployed to production without load testing.

**Result:**
- Write performance degraded 40% (index maintenance overhead)
- Storage costs increased $1,200/month (index size)
- Some queries actually got slower (wrong index chosen by query planner)
- Rollback took 3 hours during business hours

**What Went Wrong:**
Sarah expected the AI to understand business context: analytics queries run in background, user-facing writes are higher priority. The AI optimized for read speed (the literal request) without understanding the implied tradeoff hierarchy.

**The Capability vs Cognition Error:**
- **Capability:** Generate technically valid index statements
- **Cognition (missing):** Understand that faster analytics aren't worth slower user experience
- **Human judgment required:** "Optimize analytics queries **without degrading write performance or significantly increasing costs**"

**Lesson:** LT optimizes for stated criteria. If you don't state all important criteria, it won't magically know them.

### Vignette 2: The Confident Hallucination

**Context:** Network engineer troubleshooting intermittent connectivity

**What Happened:**
Marcus asked LT: "Why are we seeing 5-minute connection drops every day at 2 AM?"

The AI responded confidently: "This is likely due to BGP route flapping caused by your ISP's maintenance window. The pattern matches known issues with [ISP name] in your region. Here's how to confirm..."

Marcus spent 6 hours investigating BGP routes, calling the ISP, and analyzing routing tables. The ISP confirmed no maintenance at 2 AM.

Frustrated, Marcus checked basic things he'd skipped: there was a cron job doing database backups at 2 AM that saturated network bandwidth.

**Result:**
- 6 hours wasted on ISP wild goose chase
- Real issue not fixed for another day
- Lost trust in LT system

**What Went Wrong:**
The AI generated a plausible-sounding explanation that matched patterns in its training (ISP maintenance does cause connectivity issues). It didn't "know" it was wrong—it doesn't know anything. It produced fluent language that fit the pattern.

**The Capability vs Cognition Error:**
- **Capability:** Generate plausible explanations based on training patterns
- **Cognition (missing):** Actually know what's true vs fabricated, feel uncertainty
- **Human judgment required:** "Give me a ranked list of possible causes with diagnostic tests for each, starting with the simplest"

**Lesson:** Fluency ≠ accuracy. Require evidence, not just explanations.

### Vignette 3: The Security Shortcut

**Context:** Startup deploying web application with LT assistance

**What Happened:**
DevOps engineer Tom asked: "Set up our production deployment pipeline with GitHub Actions."

The AI generated a complete workflow YAML. Tom reviewed it—looked good, all the steps were there. He committed it and it worked perfectly. Deployments went from 45 minutes manual to 8 minutes automated.

Three months later, security audit discovered: the workflow had secrets echoed in logs, overly broad IAM permissions, and no approval gate for production deployments. Anyone with repo access could deploy anything to production.

**Result:**
- Failed SOC2 audit
- Had to pause production deployments for 2 weeks while fixing security issues
- Customer trust damaged when audit failure was disclosed

**What Went Wrong:**
Tom asked for functionality ("set up deployment"). The AI delivered functionality. Security, compliance, and approval workflows weren't in the original intent, so they weren't in the solution.

**The Capability vs Cognition Error:**
- **Capability:** Generate working deployment pipeline from description
- **Cognition (missing):** Understand implied security requirements, anticipate compliance needs
- **Human judgment required:** "Set up production deployment pipeline with: secrets management, least-privilege IAM, manual approval gate, and audit logging"

**Lesson:** LT solves the problem you state, not the problem you meant. Be explicit about non-functional requirements.

---

## Common Pitfalls (Expanded)

### Pitfall 1: Asking LT to Decide Goals
**Mistake:** "What should we monitor on our servers?"

**Why it's wrong:** This is a strategic question requiring business context, risk tolerance, and budget constraints that LT doesn't have.

**Fix:** "We need to detect server issues before users notice. Suggest monitoring metrics for a Django web application serving 10k requests/hour, given we have 3 engineers on-call and $200/month monitoring budget."

### Pitfall 2: Confusing Fluency with Authority
**Mistake:** Accepting confident explanations without verification

**Example:** AI says "This error is caused by kernel memory fragmentation" in authoritative tone. You assume it's correct without checking.

**Why it's wrong:** LT produces language that sounds authoritative because that's what authoritative explanations look like in training data. Tone doesn't equal accuracy.

**Fix:** Always require evidence: "Show me the kernel memory stats that indicate fragmentation" or "What diagnostic commands would confirm this hypothesis?"

### Pitfall 3: Letting Exploration Wander Without Checkpoints
**Mistake:** "Figure out why the application is slow" with no constraints

**What happens:** AI explores for 20 minutes, tries 15 different diagnostic approaches, generates 100 lines of logs, and still hasn't found the issue.

**Why it's wrong:** Unconstrained exploration can consume resources without progress. LT doesn't feel time pressure or resource costs.

**Fix:** Set checkpoints: "Try these diagnostics in order. After each, report what you found. If nothing conclusive after 3 attempts, escalate to me."

### Pitfall 4: Skipping Verification Because "AI is Usually Right"
**Mistake:** Building trust to the point of blind execution

**Example:** After 50 successful AI-generated scripts, you stop reviewing them carefully. #51 has a subtle bug that corrupts data.

**Why it's wrong:** 98% accuracy is excellent for recommendations. It's unacceptable for production changes. The 2% will bite you.

**Fix:** Maintain verification rigor regardless of track record. Use automation to make verification fast, not to skip it.

### Pitfall 5: Treating LT Outputs as Original Ideas
**Mistake:** "The AI came up with this innovative architecture"

**Reality:** The AI recombined patterns from training data. It's sophisticated pattern matching, not creative insight.

**Why it matters:** You still need human creativity for genuinely novel problems. LT excels at applying known patterns, not creating new paradigms.

**Fix:** Use LT to generate options based on known patterns, apply human judgment to select and adapt them for your specific context.

---

## The Right Mental Model

Think of Literate Technology as:

### What It Is
**A high-bandwidth language interface to compiled human knowledge with execution capability**

- "High-bandwidth": Can process and generate large amounts of text quickly
- "Language interface": Operates through natural language understanding and generation
- "Compiled human knowledge": Trained on billions of examples of human expertise
- "Execution capability": Can run commands, generate code, interact with systems

### What It Is Not
- A conscious entity with intentions
- A source of truth (it's a source of patterns)
- Responsible for outcomes (you are)
- Capable of strategic judgment without your criteria
- Able to understand context it wasn't given

### The Useful Metaphor
**LT is like a highly skilled junior engineer who:**
- Knows all the textbook answers
- Can quickly draft working code
- Follows patterns from training exactly
- Never gets tired or annoyed
- Has no ego about their solutions

**But:**
- Doesn't know your specific business context
- Can't tell you what's strategically important
- Will confidently give wrong answers if they sound right
- Needs supervision on anything important
- Isn't accountable for outcomes

**Your role:** Senior engineer who provides context, sets priorities, verifies work, and takes responsibility.

---

## When to Trust, When to Verify, When to Override

### High Trust (Still Verify, But Can Be Quick)
- Generating boilerplate code
- Explaining well-established concepts
- Formatting or restructuring data
- Creating variations on working solutions
- Searching through logs or metrics

**Verification:** Spot-check for obvious errors, test with sample data

### Medium Trust (Careful Verification Required)
- Proposing architectural approaches
- Generating deployment scripts
- Suggesting optimizations
- Troubleshooting guides
- Security configurations

**Verification:** Full review, test in staging, compare against best practices

### Low Trust (Verify Extensively, Often Override)
- Strategic business decisions
- Security/compliance judgments
- Anything involving "should we" rather than "how do we"
- Tradeoffs between competing values
- Politically sensitive changes

**Verification:** Use LT for options generation, not decision making. Apply heavy human judgment.

### No Trust (Never Delegate)
- Deciding what matters to the business
- Judging people or performance
- Making ethical decisions
- Determining acceptable risks
- Setting organizational priorities

**Approach:** These require cognition. Don't ask LT; it will generate plausible-sounding outputs that are meaningless.

---

## Summary

**Capability vs Cognition in Practice:**

| **Capability (LT Has This)** | **Cognition (Humans Have This)** |
|------------------------------|-----------------------------------|
| Generate code from description | Decide what's worth building |
| Explain technical concepts | Understand why it matters to you |
| Find patterns in data | Judge if patterns are meaningful |
| Propose solutions | Choose between competing values |
| Apply compiled knowledge | Create genuinely novel approaches |
| Produce fluent explanations | Know what's true vs plausible |
| Execute commands | Take responsibility for outcomes |
| Adapt based on feedback | Care about consequences |

**The key insight:** Capability is enough to multiply your capacity if you provide the cognition—goals, judgment, verification, and accountability.

**Treat LT as:** A powerful tool with sophisticated language capability, not a thinking being with judgment.

**Keep clear lines between:**
- **Suggestion** (what LT proposes)
- **Verification** (what you test)
- **Decision** (what you choose)
- **Execution** (what LT or you performs)
- **Accountability** (always yours)

**Use the checklists** in this appendix to maintain healthy boundaries and safe practices.

When in doubt: **Capability answers "how." Cognition decides "whether." Never confuse the two.**
