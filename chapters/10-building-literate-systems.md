# Chapter 10: Building Literate Systems

**One-sentence summary:** This chapter provides a practical architecture and 90-minute quickstart for building infrastructure that processes natural language intent through compiled patterns and executes accordingly.

## Opening Example

November 17, 2025, 7:30 PM. The book you're reading is now live at https://literate.domt.app. How did it get there?

Not through a web hosting control panel. Not by manually configuring Apache or nginx. Not by clicking through a GUI to set up SSL certificates and DNS routing.

Instead, through articulated intent to literate infrastructure:

**Intent expressed:** "Host the literate computing book at literate.domt.app with SSL"

**CaddyControl (literate reverse proxy) mapped intent to actions:**
- What "hosting" means (serve static content via HTTP/HTTPS)
- What domain mapping requires (DNS configuration, proxy routing)
- What SSL entails (automatic Let's Encrypt certificate)
- How to verify success (check site loads, certificate valid)

**Execution:**
- Generated Caddy configuration
- Requested SSL certificate
- Configured reverse proxy routing
- Verified deployment

**Time from intent to live website:** ~8 minutes

This is a literate system: infrastructure that reads intent, maps requirements through compiled patterns, and executes solutions.

This chapter shows you how to build one.

## Core Concept

Building a literate system means creating infrastructure that can:
1. **Accept intent** in natural language or structured formats
2. **Map requirements** by matching intent to capabilities through compiled patterns
3. **Execute solutions** using compiled knowledge and system access
4. **Verify outcomes** against success criteria
5. **Learn patterns** for future similar intents

You're not building a chatbot. You're building infrastructure that participates in its own operation through semantic understanding.

## The Literate Stack (Quick Reference)

Every literate system uses the five-layer architecture detailed in Chapter 11. Brief overview:

```
┌─────────────────────────────────────────────────────┐
│  Layer 5: Natural Language Interface                │
│  Layer 4: AI with Execution Access                  │
│  Layer 3: APIs and Protocols (SSH, HTTP, MCP)       │
│  Layer 2: Operating Systems and Services            │
│  Layer 1: Hardware and Networks                     │
└─────────────────────────────────────────────────────┘
```

**Critical requirements for literacy:**
- **Layer 1-2:** Hardware/OS must expose CLI or API access
- **Layer 3:** Standard protocols (SSH, HTTP APIs, MCP servers)
- **Layer 4:** AI has compiled knowledge + execution permission
- **Layer 5:** Intent expressed clearly (conversational or structured)

**The stack is only as literate as its weakest layer.** GUI-only systems at Layer 2 block literacy regardless of Layer 4 capability.

See Chapter 11 for detailed architecture, protocol choices, and real jer-serve topology examples.

## Reference Architecture: Network Health Monitoring

The November 17, 2025 network monitoring system demonstrates minimal literate architecture:

```
┌─────────────────────────────────────────────────────────┐
│ Human: "Monitor network health in menu bar"             │
└────────────────┬────────────────────────────────────────┘
                 │ (Natural language intent)
                 ↓
┌─────────────────────────────────────────────────────────┐
│ Claude Code (AI Layer)                                  │
│ - Maps "network health" to: CPU, temp, traffic          │
│ - Has compiled knowledge of MikroTik/OpenWRT CLI        │
│ - Generates SwiftBar monitoring script                  │
└────────────────┬────────────────────────────────────────┘
                 │ (SSH commands)
                 ↓
┌────────────────────────────┬────────────────────────────┐
│ MikroTik RB5009            │ GL-BE3600 WiFi 7           │
│ - SSH enabled              │ - SSH enabled              │
│ - RouterOS CLI             │ - OpenWRT + iwinfo         │
│ - Exports metrics          │ - Exports WiFi stats       │
└────────────────────────────┴────────────────────────────┘
```

**What makes this literate:**
- Hardware (routers) run OS with SSH enabled
- Standard protocol (SSH) provides access
- AI has compiled knowledge of both CLI syntaxes
- Human expressed intent in plain language
- Result: Generated `network-health.30s.sh` displaying real-time metrics

**Time to build:** 60 minutes (November 17 actual)

This became the foundation for all network monitoring discussed in earlier chapters.

## Access and Guardrails

Before granting AI execution access, establish safety boundaries.

### Progressive Trust Model

```
Observer (Read-only, 7 days)
  ↓ 90% accuracy
Contributor (Non-production write, 30 days)
  ↓ 95% accuracy, 0 incidents
Operator (Production with approval, 90 days)
  ↓ Sustained excellence
Architect (Infrastructure changes with review)
```

Promote based on demonstrated accuracy, not just time. Demote immediately on security violations.

### Essential Guardrails

**Command Control:**
```yaml
# Allowlist approach (preferred)
allowed_commands:
  - "/system resource print"
  - "/interface monitor-traffic"
  - "iwinfo wlan0 assoclist"

# Critical blocklist
blocked_commands:
  - "/system reboot"
  - "/system reset-configuration"
  - "rm -rf /*"
  - "iptables -F"
```

**Rate Limiting:**
- Commands per minute: 10
- Max concurrent SSH sessions: 3
- Timeout per command: 30 seconds

**Audit Trail:**
- Log all executions with timestamp, user, command
- Store in `/var/log/literate-access.log`
- Alert on unusual patterns

**→ Appendix C provides detailed access control policy templates and SSH key setup procedures.**

### SSH Access Setup (Quick Version)

```bash
# 1. Generate dedicated key
ssh-keygen -t ed25519 -f ~/.ssh/literate_infra -C "literate-ai-access"

# 2. Install on target systems
ssh-copy-id -i ~/.ssh/literate_infra.pub user@target-system

# 3. Test access
ssh -i ~/.ssh/literate_infra user@target-system "hostname && uptime"

# 4. Grant AI access to key
export SSH_KEY_PATH=~/.ssh/literate_infra
```

**Security:**
- Dedicated key per AI context (production, dev, monitoring)
- Private key permissions: 0600 (owner read/write only)
- Regular key rotation (90 days)
- Immediate revocation on compromise

## Case Study: CaddyControl

**CaddyControl** is the literate reverse proxy that deployed this book. Simplified architecture:

```
Intent → AI orchestration → HTTP API → Config generation → Caddy reload
```

**API request:**
```bash
curl -X POST https://caddycontrol.domt.app/api/routes \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"domain": "literate.domt.app", "target": "http://localhost:8080", "ssl": true}'
```

**Safety features:**
- Domain ownership verification (DNS TXT record)
- Config validation before reload
- Automatic rollback on failure
- Rate limiting (10 changes/hour)
- Full audit trail

**Result:** Website deployed in 8 minutes with complete safety guarantees.

**Why this is literate:**
- Natural language: "Host book at literate.domt.app with SSL"
- AI maps intent: Domain routing + SSL requirements → executable config
- API execution: Generates config, requests certificate
- Verification: Tests deployment success

This is infrastructure as dialogue, not just automation.

## 90-Minute Quickstart: Your First Literate System

Let's build a functional server health monitoring system.

### Prerequisites
- One Linux server/router with SSH access
- AI assistant with terminal access (Claude Code, GitHub Copilot, etc.)
- Basic understanding of SSH and bash

### Step 1: Establish SSH Access (15 minutes)

```bash
# Generate AI access key
ssh-keygen -t ed25519 -f ~/.ssh/literate_demo -C "literate-demo-$(date +%Y%m%d)"

# Install on target
ssh-copy-id -i ~/.ssh/literate_demo.pub user@target-system

# Test
ssh -i ~/.ssh/literate_demo user@target-system "hostname && uptime"
```

**Expected:** Hostname and uptime displayed without password prompt.

### Step 2: Define Intent (10 minutes)

**Create intent specification:**
```yaml
# my-literate-system.yml
intent:
  goal: "Monitor server health and alert on issues"

context:
  systems:
    - type: "linux_server"
      hostname: "target-system"
      ip: "192.168.1.10"
  metrics_needed: ["CPU usage", "Memory usage", "Disk space", "System load"]
  update_frequency: "every 60 seconds"

success_criteria:
  - "Script runs without errors"
  - "Metrics display clearly"
  - "Alerts trigger when thresholds exceeded"

thresholds:
  cpu_percent: 80
  memory_percent: 90
  disk_percent: 85
  load_average_1min: 4.0

artifacts:
  - "Monitoring script: ~/literate-demo/health-check.sh"
  - "Output log: ~/literate-demo/health.log"
```

**Express to AI:**
```
"Create a server health monitoring script based on my-literate-system.yml.
SSH to target-system, collect metrics, compare against thresholds, log results.
Run every 60 seconds."
```

### Step 3: AI Generates Solution (20 minutes)

**What AI produces** (simplified for book - full script in GitHub repo):

```bash
#!/bin/bash
# health-check.sh - Monitor server health

SSH_KEY="$HOME/.ssh/literate_demo"
TARGET="user@192.168.1.10"
LOG_FILE="$HOME/literate-demo/health.log"

# Collect metrics via SSH
METRICS=$(ssh -i "$SSH_KEY" "$TARGET" '
  cpu=$(top -bn1 | grep "Cpu(s)" | awk "{print 100 - \$8}")
  mem=$(free | grep Mem | awk "{print (\$3/\$2) * 100}")
  disk=$(df -h / | tail -1 | awk "{print \$5}" | tr -d "%")
  load=$(uptime | awk -F"load average:" "{print \$2}" | awk "{print \$1}" | tr -d ",")
  echo "CPU:$cpu MEM:$mem DISK:$disk LOAD:$load"
')

# Parse and check thresholds
# (Full parsing and alerting logic - see repo)

# Log results
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
if [ -n "$ALERTS" ]; then
  echo "$TIMESTAMP [ALERT] $ALERTS" | tee -a "$LOG_FILE"
else
  echo "$TIMESTAMP [OK] CPU:${CPU}% MEM:${MEM}% DISK:${DISK}% LOAD:${LOAD}" >> "$LOG_FILE"
fi
```

**→ Complete working script with full error handling available in book repository.**

### Step 4: Verify Solution (15 minutes)

**Manual test:**
```bash
chmod +x ~/literate-demo/health-check.sh
~/literate-demo/health-check.sh
```

**Expected output:**
```
2025-11-17 20:30:15 [OK] CPU:25.3% MEM:45.2% DISK:38% LOAD:0.82
```

**Verification checklist:**
- [ ] Script executes without errors
- [ ] All metrics present (CPU, MEM, DISK, LOAD)
- [ ] Values match manual checks (ssh to target, run `top`, `free`, `df`)
- [ ] Threshold alerting works (temporarily lower threshold to test)
- [ ] Logging works (check health.log file)

**→ Appendix B provides complete verification plan template.**

### Step 5: Automate Execution (10 minutes)

**Option A: Cron (simple)**
```bash
crontab -e
# Add: * * * * * $HOME/literate-demo/health-check.sh
```

**Option B: Systemd (robust)**
```bash
# Create service and timer files
cat > ~/.config/systemd/user/literate-health.service <<EOF
[Unit]
Description=Literate Health Monitor
[Service]
Type=oneshot
ExecStart=$HOME/literate-demo/health-check.sh
EOF

cat > ~/.config/systemd/user/literate-health.timer <<EOF
[Unit]
Description=Run health check every minute
[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
[Install]
WantedBy=timers.target
EOF

# Enable and start
systemctl --user daemon-reload
systemctl --user enable --now literate-health.timer
```

**Verify automation:**
```bash
# Wait 2 minutes, then:
tail -f ~/literate-demo/health.log
```

**Expected:** New entries every 60 seconds.

### Step 6: Iterate and Improve (20 minutes)

**Enhancement request:**
```
"Add network connectivity check to health-check.sh. Ping 8.8.8.8 and alert if fails."
```

**AI adds:**
```bash
PING_RESULT=$(ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1 && echo "OK" || echo "FAIL")
[ "$PING_RESULT" == "FAIL" ] && ALERTS="$ALERTS NETWORK "
```

**Document the pattern:**
```yaml
# pattern-library.yml
pattern_name: "Server Health Monitoring"
created: "2025-11-17"
verified: true

description: |
  SSH-based health monitoring with threshold alerting.
  Collects CPU, memory, disk, load, network connectivity.

reusable_for:
  - Linux servers, Raspberry Pi, any SSH-accessible system

artifacts:
  - health-check.sh (monitoring script)
  - systemd timer or cron configuration

lessons_learned:
  - bc command needed for floating-point comparison
  - SSH timeout prevents hanging (use -o ConnectTimeout=5)
  - Log rotation needed for long-term use (logrotate config)
```

**Congratulations! You've built your first literate system in 90 minutes.**

**What you've created:**
- Infrastructure that maps "health" intent to observable metrics
- Automated monitoring responding to natural language intent
- Reusable pattern for any SSH-accessible system
- Foundation for more complex literate interactions

## Practical Patterns

Based on November 17, 2025 and this chapter's examples:

**1. Start with read-only access**
- Observe before acting
- Build trust through accurate recommendations
- Graduate to write access after proven reliability

**2. Use the five-layer stack as design checklist**
- Is hardware/OS accessible via standard protocols?
- Does AI have compiled knowledge for this system type?
- Can intent be expressed clearly?

**3. Implement progressive trust**
- Observer (7 days) → Contributor (30 days) → Operator (90 days)
- Promote on accuracy metrics, not just time
- Demote immediately on security violations

**4. Design for verification**
- Every action should be testable
- Build verification into automation
- Log everything for audit

**5. Maintain guardrails**
- Allowlist > blocklist (explicit permission over denial)
- Rate limiting prevents accidental abuse
- Dry-run mode tests changes before applying

**6. Document patterns as you discover them**
- Each solved problem → pattern library entry
- Include: what worked, what didn't, lessons learned
- Share patterns for knowledge compilation (Chapter 8's DRY principle)

**7. Build feedback loops**
- Monitoring informs improvements
- Failures become pattern library entries
- Each iteration strengthens the system

**8. Separate intent from implementation**
- Intent specification (YAML) lives separately from code
- Implementation can change without changing intent
- Multiple implementations can satisfy same intent

**9. Verify against the capacity formula** (from Chapter 6)
```
Capacity = Intent Clarity × AI Capability
```
- If verification takes longer than manual implementation, improve articulation
- Sweet spot: 10-30% time on verification, 70-90% time saved

## Common Pitfalls

**1. Over-trusting AI output**
- **Mistake:** Run generated scripts without review
- **Reality:** Always verify before production execution
- **Fix:** Require dry-run and manual review for new patterns

**2. Under-documenting intent**
- **Mistake:** Vague requests like "make it faster"
- **Reality:** AI needs specific success criteria
- **Fix:** Use Intent Specification Template (Chapter 6)

**3. Insufficient guardrails**
- **Mistake:** Grant full sudo access immediately
- **Reality:** Trust must be earned through demonstrated accuracy
- **Fix:** Progressive trust with allowlists and rate limiting

**4. Ignoring Layer 1-2 accessibility**
- **Mistake:** Expect AI to work with GUI-only systems
- **Reality:** Literate systems need CLI/API access
- **Fix:** Ensure SSH or API enabled before attempting literacy integration

**5. Not testing failure modes**
- **Mistake:** Only test happy path
- **Reality:** Systems fail in unexpected ways
- **Fix:** Test network failures, SSH timeouts, threshold violations

**6. Confusing capability for cognition**
- **Mistake:** Expect AI to "just know" undocumented systems
- **Reality:** AI applies compiled patterns; novel systems need exploration
- **Fix:** Allow time for exploration pattern (Chapter 5) to discover capabilities

**7. Skipping verification plan**
- **Mistake:** Deploy without systematic testing
- **Reality:** Untested systems fail in production
- **Fix:** Write verification plan before deployment (Appendix B)

**8. Not maintaining pattern library**
- **Mistake:** Solve same problems repeatedly
- **Reality:** Documented patterns multiply value
- **Fix:** Add to pattern library every time you solve something non-trivial

## Summary

Building literate systems requires:

**Architecture:**
- Five-layer stack (hardware → OS → protocols → AI → natural language)
- Each layer supports the layer above
- Weakest layer determines system capability
- See Chapter 11 for detailed architecture and protocol choices

**Access:**
- SSH or API access to infrastructure
- Dedicated keys for AI access
- Progressive trust based on demonstrated accuracy
- Guardrails: allowlists, rate limits, audit logs

**Verification:**
- Systematic testing (functional, security, performance, reliability)
- Verification plan for each literate system
- Continuous monitoring in production
- See Appendix B for verification templates

**Patterns:**
- Document what works
- Share for knowledge compilation
- Iterate based on real use
- Build pattern library over time

**Real examples:**
- CaddyControl: Website deployment in 8 minutes
- Network health monitoring: 60 minutes to working system
- 90-minute quickstart: Build first literate system from scratch

**The key insight:** Literate systems aren't built by writing more code. They're built by making existing capabilities accessible through natural language comprehension.

Every system has latent literacy. This chapter showed you how to unlock it.

**→ Appendix B: Verification plan templates and testing checklists**
**→ Appendix C: Detailed access control policies and SSH configuration**
**→ Appendix D: Complete code examples and monitoring scripts**

The capacity formula from Chapter 6 applies here:
```
Before: Capacity = Skills learned × Time invested
After:  Capacity = Intent clarity × AI capability
```

By building literate systems, you shift the bottleneck from learning command syntax to articulating what you want. The 90-minute quickstart demonstrates this: you didn't need to learn SSH command syntax, bash scripting conventions, or systemd timer configuration. You expressed intent, verified results, and built working infrastructure.

Next, Chapter 11 explores the complete literate computing stack in depth, showing how the five layers enable each other and examining real infrastructure topology from jer-serve. You'll see how the monitoring system from this chapter fits into a larger literate infrastructure ecosystem.
