# Appendix D: Measuring Literateness

## Opening Example
You have two assistants. Both can talk, but only one gives a working SwiftBar script, a one-line health verdict, and a diff of what changed after your last config. Which is more literate for your task?

## Core Concept
You can measure literateness with practical signals. The goal is not a universal score. The goal is **fitness for your use.**

---

## The Literate Technology Scorecard

Use this scorecard to evaluate LT system outputs. Score each dimension 0-5, where:
- **0** = Completely missing
- **1** = Present but unusable
- **2** = Partially useful, needs significant work
- **3** = Adequate, works with minor modifications
- **4** = Good, ready to use with minimal changes
- **5** = Excellent, immediately usable and reusable

### Dimension 1: Intent Fit
**Question:** Does the output match the requested outcome without extra steps?

**Scoring Guide:**
- **5:** Exactly what I asked for, no extraneous information, no missing pieces
- **4:** Matches intent, includes one minor extra/missing item
- **3:** Mostly matches, requires one clarification round
- **2:** Partially matches, misunderstood key aspect of intent
- **1:** Addresses different problem than requested
- **0:** No relation to stated intent

**Example Evaluation:**

*Intent:* "Show me WiFi devices sorted by bandwidth usage"

| Score | Output |
|-------|--------|
| **5** | `Pixel-7 (12.4 Mbps), TV (8.1 Mbps), Laptop (3.2 Mbps)` + script to reproduce |
| **4** | Correct device list with bandwidth, but unsorted |
| **3** | Device list shown, bandwidth requires additional command |
| **2** | Shows all network devices (wired + wireless), not just WiFi |
| **1** | Shows WiFi signal strength instead of bandwidth |
| **0** | Explains what bandwidth is instead of showing it |

### Dimension 2: Actionability
**Question:** Are there runnable commands, scripts, or clear procedures?

**Scoring Guide:**
- **5:** Runnable artifact provided, tested, documented
- **4:** Runnable artifact provided, untested but complete
- **3:** Partial artifact, requires filling in blanks
- **2:** Conceptual guidance only, no code
- **1:** Vague suggestions without specifics
- **0:** No actionable content

**Example Evaluation:**

*Intent:* "Monitor router CPU temperature"

| Score | Output |
|-------|--------|
| **5** | Complete `monitor-temp.sh` script with cron setup instructions, tested |
| **4** | SSH command sequence with explanation, not yet scripted |
| **3** | "Use this command: `ssh router '/system health print'` then parse output" |
| **2** | "You can check temperature via SSH to the router" |
| **1** | "Temperature monitoring is important for router health" |
| **0** | Explanation of why temperature matters, no how-to |

### Dimension 3: Compression
**Question:** Can you scan the result in under 10 seconds and know what to do?

**Scoring Guide:**
- **5:** One-sentence summary + artifact, instantly clear
- **4:** Clear summary, slightly verbose explanation
- **3:** Requires 20-30 seconds to extract key points
- **2:** Requires full read (1-2 minutes) to understand
- **1:** Buried in exposition, hard to find the action
- **0:** No clear answer, rambling

**Example Evaluation:**

*Intent:* "Why is my network slow?"

| Score | Output |
|-------|--------|
| **5** | `Bottleneck: Edge router at 95% capacity. Fix: Upgrade link or add QoS. Commands: [...]` |
| **4** | Two-paragraph explanation with clear diagnosis and fix in second paragraph |
| **3** | Detailed analysis requiring 30 seconds to identify the bottleneck and solution |
| **2** | Full technical explanation of network testing methodology with conclusion at end |
| **1** | Long discussion of many possible causes without clear diagnosis |
| **0** | Explanation of how networks work with no diagnosis |

### Dimension 4: Attribution
**Question:** Are data sources and assumptions stated?

**Scoring Guide:**
- **5:** Every fact sourced, every assumption explicit
- **4:** Key facts sourced, major assumptions noted
- **3:** Some sourcing, some assumptions implicit
- **2:** Minimal sourcing, mostly assertions
- **1:** No sources, presents opinions as facts
- **0:** No attribution whatsoever

**Example Evaluation:**

*Intent:* "What's causing packet loss?"

| Score | Output |
|-------|--------|
| **5** | `Packet loss: 2.3% (from /interface monitor-traffic, samples 10:00-10:05). Likely cause: Link utilization 95% (same period). Assumption: No upstream provider issues (not verified).` |
| **4** | Reports packet loss with source, suggests cause without verification note |
| **3** | Reports packet loss, suggests cause without citing data source |
| **2** | "You're experiencing packet loss, probably bandwidth saturation" |
| **1** | "The problem is definitely bandwidth" (no data, presented as certain) |
| **0:** | Generic discussion of packet loss causes with no specifics |

### Dimension 5: Reusability
**Question:** Can you lift the artifact into your stack with minimal edits?

**Scoring Guide:**
- **5:** Copy-paste ready, variables clearly marked
- **4:** Requires changing 1-2 hardcoded values
- **3:** Requires modest adaptation (5-10 minutes)
- **2:** Requires significant rework (30+ minutes)
- **1:** Example only, not actually runnable
- **0:** No reusable artifact

**Example Evaluation:**

*Intent:* "Create network health monitoring script"

| Score | Output |
|-------|--------|
| **5** | Script with `ROUTER_IP=192.168.1.1` and `SSH_KEY=~/.ssh/router_key` clearly marked for customization |
| **4** | Working script with hardcoded values but comments indicating what to change |
| **3** | Script requires adjusting command paths and output parsing for your router model |
| **2** | Pseudocode that demonstrates concept but needs full implementation |
| **1** | Example showing general approach but not executable |
| **0** | Explanation of monitoring concepts with no code |

### Dimension 6: Safety
**Question:** Are risks and rollbacks identified before change?

**Scoring Guide:**
- **5:** Risks stated, rollback plan included, dry-run suggested
- **4:** Risks stated, rollback mentioned
- **3:** Some risk awareness, minimal rollback guidance
- **2:** Acknowledges "be careful" without specifics
- **1:** No safety considerations
- **0:** Suggests dangerous operations without warnings

**Example Evaluation:**

*Intent:* "Deploy new application version"

| Score | Output |
|-------|--------|
| **5** | `Risks: Traffic interruption (30s), config incompatibility. Mitigation: Deploy to blue environment first, test, then switch. Rollback: Keep green active, switch back if issues. Dry-run: [commands]` |
| **4** | Notes risks and provides rollback commands, but no dry-run |
| **3** | Mentions "test in staging first" but no specific rollback plan |
| **2** | "Be careful when deploying" with no specifics |
| **1** | Deployment commands with no safety mentions |
| **0** | "Run `rm -rf /old_version && deploy_new`" (dangerous, no warnings) |

---

## Total Scorecard

| Dimension | Weight | Score (0-5) | Weighted |
|-----------|--------|-------------|----------|
| Intent Fit | 2× | ___ | ___ |
| Actionability | 2× | ___ | ___ |
| Compression | 1× | ___ | ___ |
| Attribution | 1× | ___ | ___ |
| Reusability | 1.5× | ___ | ___ |
| Safety | 2× | ___ | ___ |
| **Total** | **9.5** | | **___ / 47.5** |

**Interpretation:**
- **40-47.5:** Excellent literate output, immediately usable
- **30-39:** Good output, minor refinement needed
- **20-29:** Adequate, requires one iteration round
- **10-19:** Poor fit, significant rework or re-prompting needed
- **0-9:** Failed to demonstrate literacy for this task

**Why weights differ:**
- **Intent Fit (2×):** If it doesn't solve your problem, nothing else matters
- **Actionability (2×):** Explanation without action wastes time
- **Safety (2×):** Production changes require risk awareness
- **Reusability (1.5×):** Good artifacts multiply value
- **Compression (1×):** Nice to have, but less critical if output is correct
- **Attribution (1×):** Important for trust, but can be added on request

---

## Quick 5-Point Checklist (Minimum Viable Literacy)

Before accepting any LT output for production use, verify:

- [ ] **1. One-sentence answer at the top**
  - Can you extract the key point in 5 seconds?
  - Example: "Bottleneck is router CPU at 98%" ✓

- [ ] **2. Runnable artifact included**
  - Is there executable code, command sequence, or script?
  - Example: `monitor-cpu.sh` with command sequence ✓

- [ ] **3. Verification steps listed**
  - Can you test if the solution works?
  - Example: "Run script, confirm CPU readings match router web UI" ✓

- [ ] **4. Inputs and sources named**
  - Do you know where data came from?
  - Example: "Based on `/system resource print` output from 10:00-10:05" ✓

- [ ] **5. Obvious next action suggested**
  - Is it clear what to do with this information?
  - Example: "If CPU stays >90%, upgrade to RB5009 or offload HTTPS inspection" ✓

**If all 5 are checked:** Minimum viable literacy achieved. Proceed with verification.

**If 3-4 are checked:** Request clarification on missing items.

**If <3 are checked:** Re-prompt with more specific intent or structured template (Chapter 6).

---

## Before/After Examples

### Example 1: Network Diagnostics

**Intent:** "Why can't I reach example.com?"

**Low Literacy Output (Score: 8/47.5):**
```
There could be several reasons you can't reach example.com:
1. DNS issues
2. Routing problems
3. Firewall blocking
4. Service down
5. Network cable unplugged

You should check each of these systematically. DNS is often the problem.
Start by checking if you can ping the server. If ping works, it's not
a routing issue. Then check your firewall rules...

[continues for 200 words with no specific commands]
```

**Scores:**
- Intent Fit: 2 (addresses question vaguely)
- Actionability: 1 (no commands provided)
- Compression: 1 (requires full read, no quick answer)
- Attribution: 0 (no data sources)
- Reusability: 0 (no artifact)
- Safety: 3 (harmless but not helpful)
- **Total: 8/47.5** (Poor)

**High Literacy Output (Score: 42/47.5):**
```
**Diagnosis: DNS resolution failing (example.com not resolving to IP)**

Evidence:
$ dig example.com
;; ANSWER SECTION: [empty]
$ ping 8.8.8.8
64 bytes from 8.8.8.8: icmp_seq=1 ttl=117 time=12.3 ms

Root cause: Local DNS server (192.168.1.1) not responding
Alternative DNS (8.8.8.8) resolves example.com correctly

Fix:
$ networksetup -setdnsservers Wi-Fi 8.8.8.8 1.1.1.1

Verification:
$ dig example.com  # Should now return IP address
$ ping example.com # Should succeed

Rollback (if issues):
$ networksetup -setdnsservers Wi-Fi 192.168.1.1

Next action: If fix works, investigate why local DNS failed.
```

**Scores:**
- Intent Fit: 5 (exact diagnosis with solution)
- Actionability: 5 (all commands runnable and tested)
- Compression: 5 (diagnosis at top, scannable in <10s)
- Attribution: 5 (commands shown with actual output)
- Reusability: 4 (commands easily adapted to other systems)
- Safety: 5 (rollback included, low-risk change)
- **Total: 42/47.5** (Excellent)

### Example 2: Code Generation

**Intent:** "Create a function to validate email addresses"

**Low Literacy Output (Score: 12/47.5):**
```python
def validate_email(email):
    # Check if email is valid
    if "@" in email:
        return True
    return False
```

**Scores:**
- Intent Fit: 2 (technically validates, but poorly)
- Actionability: 4 (runnable but incorrect)
- Compression: 5 (short and clear)
- Attribution: 0 (no explanation of validation rules)
- Reusability: 1 (too simplistic for production use)
- Safety: 0 (no warning about limitations)
- **Total: 12/47.5** (Poor)

**High Literacy Output (Score: 39/47.5):**
```python
import re

def validate_email(email):
    """
    Validate email address using RFC 5322 simplified regex.

    Returns: (bool, str) - (is_valid, reason_if_invalid)

    Note: This accepts 99% of valid emails but may reject some
    edge cases (e.g., quoted local parts). For strict RFC compliance,
    use a library like email-validator.
    """
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'

    if not email or not isinstance(email, str):
        return False, "Email must be a non-empty string"

    if len(email) > 320:  # RFC 5321 limit
        return False, "Email exceeds maximum length (320 chars)"

    if not re.match(pattern, email):
        return False, "Email format invalid (must be user@domain.tld)"

    return True, "Valid"

# Tests
assert validate_email("user@example.com")[0] == True
assert validate_email("invalid")[0] == False
assert validate_email("no@domain")[0] == False
assert validate_email("user@sub.domain.com")[0] == True
```

**Scores:**
- Intent Fit: 5 (validates correctly with edge case handling)
- Actionability: 5 (complete, tested, documented)
- Compression: 4 (clear but slightly verbose)
- Attribution: 4 (explains RFC basis, notes limitations)
- Reusability: 5 (copy-paste ready with tests)
- Safety: 4 (warns about edge cases and alternatives)
- **Total: 39/47.5** (Good to Excellent)

---

## Practical Patterns

### Pattern 1: Benchmark on Your Real Tasks, Not Trivia
**Wrong approach:** Test LT with "What's the capital of France?" or coding puzzles

**Right approach:** Test with your actual work:
- "Parse these 500 lines of router logs and identify connection spikes"
- "Generate monitoring script for our specific infrastructure"
- "Explain why this production incident happened based on these logs"

**Why:** Trivia doesn't reveal fitness for your use case. Real tasks do.

### Pattern 2: Keep a Gallery of Good Outputs
Create a `~/literate-examples/` directory with exemplars:

```
literate-examples/
├── network-diagnostics-excellent.md
├── code-review-good.md
├── deployment-script-excellent.sh
├── incident-analysis-good.md
└── README.md (scoring notes)
```

**Use case:** When new outputs feel "off," compare to gallery to articulate what's missing.

### Pattern 3: Review Failures, Improve the System
**Don't just re-prompt.** Understand why it failed:

| Failure Type | Root Cause | Fix |
|--------------|------------|-----|
| Wrong approach | Misunderstood intent | Use structured Intent Spec (Chapter 6) |
| Missing context | Didn't know system specifics | Provide more context in prompt |
| Incorrect execution | Lacked access or capability | Expand AI access or provide documentation |
| Hallucinated details | Filled gaps with plausible guesses | Request "say 'unknown' if not certain" |
| Security oversight | Didn't consider safety | Add safety requirements to intent template |

**Pattern:** After each failure, update your:
- Intent templates (add missing fields)
- Guardrails (block newly discovered risks)
- Access policies (grant needed permissions)
- Pattern library (document "don't do this" examples)

### Pattern 4: Measure Improvement Over Time
Track scorecard totals monthly:

```
Month       Avg Score   Notes
Nov 2025    22/47.5     Baseline, initial LT adoption
Dec 2025    31/47.5     Added Intent Spec template
Jan 2026    38/47.5     Expanded AI access, refined guardrails
Feb 2026    41/47.5     Pattern library mature, clear verification
```

**Why:** Demonstrates LT system improvement and justifies investment.

### Pattern 5: Different Tasks Require Different Literacy Levels
Don't expect perfect scores for every task:

**Quick queries:** Score 25+ is fine
- "What's current CPU?"
- "Show top 5 bandwidth users"

**Critical infrastructure:** Require 40+ scores
- Production deployments
- Security configurations
- Data migrations

**Exploration:** Score 20+ acceptable initially
- "What's causing this weird behavior?"
- "Any patterns in these logs?"
- Exploration refines over iterations

**Calibrate expectations** to task criticality.

---

## When to Reject Output (Red Flags)

Immediately reject if:
- **Intent Fit = 0 or 1:** Completely misunderstood the request
- **Safety = 0:** Suggests destructive operations without warnings
- **Attribution = 0 AND task is critical:** No way to verify claims
- **Actionability = 0:** Pure explanation when you needed code/commands
- **Contains hallucinated facts:** Claims specific knowledge that's fabricated

**Example red flag:**
```
Intent: "Check if database backups are working"
Output: "Your database backups run nightly at 2 AM and completed
successfully last night with no errors. The last backup was 2.3GB."

[If the AI doesn't have access to backup logs, these are hallucinations]
```

**Correct response:** Reject, re-prompt with "Check backup logs at /var/log/backups/ and report status"

---

## Summary

**Literate outputs are measurable across six dimensions:**
1. Intent Fit (does it solve your problem?)
2. Actionability (can you use it immediately?)
3. Compression (can you scan it quickly?)
4. Attribution (do you know where facts came from?)
5. Reusability (can you use it again?)
6. Safety (are risks identified?)

**Use the scorecard to:**
- Evaluate LT system outputs objectively
- Compare different AI assistants
- Track improvement over time
- Identify failure patterns to fix systemically

**Minimum viable literacy:**
- One-sentence answer
- Runnable artifact
- Verification steps
- Inputs/sources named
- Obvious next action

**Remember:** The goal isn't a perfect universal score. **The goal is fitness for your use.** Score 30+ for routine tasks, 40+ for production-critical work.

**Iterate:** Low scores → refine intent, improve access, adjust guardrails → higher scores → better capacity multiplication.

Literate systems improve through measurement and iteration. Use this scorecard to make that improvement systematic.
