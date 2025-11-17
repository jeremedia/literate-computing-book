# Appendix E: Guardrail Configuration Templates

This appendix provides detailed configuration templates, command allowlists, and YAML examples for implementing the guardrails discussed in Chapter 5: The Exploration Pattern.

## Access Control Implementation

### Creating Dedicated Exploration Users

**Linux/Unix Systems**:
```bash
# Create exploration user with read-only access
useradd -m ltexplore -s /bin/bash

# Grant specific command permissions via sudoers
echo "ltexplore ALL=(ALL) NOPASSWD: /usr/bin/iwinfo, /usr/sbin/ip" >> /etc/sudoers.d/ltexplore
chmod 440 /etc/sudoers.d/ltexplore
```

**SSH Key Setup**:
```bash
# Generate dedicated SSH key for exploration
ssh-keygen -t ed25519 -f /etc/lt/exploration_key -C "LT exploration key"

# Install on target systems
ssh-copy-id -i /etc/lt/exploration_key.pub ltexplore@target-system
```

### Command Allowlists and Blocklists

**Allowed Commands** (safe for exploration):
```yaml
read_operations:
  - ls
  - cat
  - grep
  - find
  - ps
  - top
  - htop
  - netstat
  - ss
  - df
  - du
  - free
  - uptime

monitoring_tools:
  - iwinfo
  - ip addr
  - ip route
  - systemctl status
  - journalctl
  - docker ps
  - docker stats
  - kubectl get
  - kubectl describe
  - kubectl top

network_inspection:
  - ping
  - traceroute
  - dig
  - nslookup
  - curl (GET only)
  - wget (read-only)
```

**Blocked Commands** (dangerous operations):
```yaml
destructive:
  - rm
  - dd
  - mkfs
  - fdisk
  - parted
  - shred
  - truncate

network_disruption:
  - iptables -F
  - iptables -D
  - ip link set * down
  - ifdown
  - systemctl stop networking

service_control:
  - systemctl stop
  - systemctl disable
  - systemctl restart (without approval)
  - service * stop
  - kill -9 (system processes)

privilege_escalation:
  - su
  - sudo -s
  - sudo -i
  - chmod +s
  - chown root
```

### Path Restrictions

**Readable Paths**:
```bash
/etc            # System configuration
/var/log        # Log files
/proc           # Process information
/sys            # System information
/tmp            # Temporary files (limited)
/opt            # Optional applications (read-only)
```

**Restricted Paths**:
```bash
/root           # Root home directory
/home/*/.ssh    # SSH keys
/var/secrets    # Secrets storage
/etc/shadow     # Password hashes
/etc/ssl/private # SSL private keys
/boot           # Boot partition
```

## Rate Limiting Configuration

### Command Rate Limits

```yaml
rate_limits:
  commands_per_minute: 10
  commands_per_hour: 300
  commands_per_day: 2000

  burst_allowance: 5  # Can burst up to 5 commands at once
  cooldown_after: 50  # Cool down after 50 total commands in session
  cooldown_duration: 60  # Seconds to wait during cooldown

  alerts:
    threshold: 8  # Alert if >8 commands per minute
    notify: security-team@example.com
```

### Timeout Enforcement

```yaml
timeouts:
  default: 30s
  read_operations: 15s
  monitoring_commands: 45s
  long_running_max: 5m

  kill_signal: SIGTERM
  force_kill_after: 10s  # SIGKILL if SIGTERM doesn't work
```

### Resource Quotas

```yaml
resource_limits:
  cpu:
    max_percent: 25  # Max 25% of one core
    cgroup: ltexplore

  memory:
    max_per_process: 500M
    max_total: 1G

  disk:
    read_only: true
    max_read_iops: 1000
    max_read_bandwidth: 100M

  network:
    max_bandwidth: 10M  # For monitoring operations
```

## Transparency and Audit Configuration

### Transcript Logging Format

```yaml
logging:
  enabled: true
  destination: /var/log/lt-exploration.log
  rotation: daily
  retention: 90d

  log_format: json

  fields:
    - timestamp
    - user_id
    - session_id
    - user_question
    - system_intent_interpretation
    - ssh_target
    - command_executed
    - command_output
    - command_exit_code
    - duration_ms
    - resources_used
```

**Example Log Entry**:
```json
{
  "timestamp": "2025-11-17T15:23:45.123Z",
  "user_id": "jeremy",
  "session_id": "sess_abc123",
  "user_question": "Which port is GL-BE3600 on?",
  "intent": "find_port_mapping",
  "ssh_target": "admin@192.168.1.1",
  "command": "/interface bridge host print",
  "output_summary": "15 entries, MAC 94:83:C4:XX:XX:XX found",
  "exit_code": 0,
  "duration_ms": 234,
  "cpu_percent": 2.1,
  "memory_mb": 12
}
```

### Policy Checks

```yaml
policy_checks:
  password_exposure:
    enabled: true
    patterns:
      - "password"
      - "passwd"
      - "secret"
      - "token"
      - "api_key"
    action: redact

  regulated_data:
    enabled: true
    paths:
      - /var/pii/*
      - /var/hipaa/*
      - /var/financial/*
    action: block

  data_retention:
    pii_data: 30d
    general_logs: 90d
    security_events: 365d

  suspicious_patterns:
    enabled: true
    alert_on:
      - Multiple failed authentication attempts
      - Attempts to access blocked paths
      - Rate limit violations
      - Unusual command sequences
    notify: security-team@example.com
```

### Dry-Run Mode Implementation

```yaml
dry_run:
  enabled: true
  default: false  # User must opt-in

  prompt_format: |
    [DRY RUN MODE]
    Would execute the following:
    {{commands}}

    Proceed with execution? [y/N]

  timeout_for_approval: 30s

  show_commands: true
  show_estimated_impact: true
```

## Progressive Trust Levels

### Trust Level Definitions

```yaml
trust_levels:
  level_1_initial:
    name: "Initial"
    permissions:
      - read_only_commands
      - standard_monitoring_tools
      - common_paths_only
    restrictions:
      - no_write_operations
      - no_service_control
      - no_custom_scripts
    rate_limit_multiplier: 1.0

  level_2_established:
    name: "Established"
    permissions:
      - level_1_permissions
      - custom_commands
      - broader_path_access
      - simple_write_operations
    restrictions:
      - no_critical_service_control
      - write_operations_require_approval
    rate_limit_multiplier: 1.5
    promotion_criteria:
      - min_successful_explorations: 50
      - accuracy_rate: 0.95
      - no_security_incidents: true
      - user_verifications: 10
      - time_in_system: 7d

  level_3_trusted:
    name: "Trusted"
    permissions:
      - level_2_permissions
      - service_restarts
      - config_changes
      - scripted_operations
    restrictions:
      - production_changes_require_approval
      - destructive_operations_blocked
    rate_limit_multiplier: 2.0
    promotion_criteria:
      - min_successful_explorations: 200
      - accuracy_rate: 0.98
      - no_security_incidents: true
      - user_verifications: 50
      - time_in_system: 30d
```

### Trust Score Calculation

```yaml
trust_scoring:
  factors:
    accuracy:
      weight: 0.4
      calculation: successful_explorations / total_explorations

    safety:
      weight: 0.3
      calculation: 1.0 if no_incidents else 0.0

    verification:
      weight: 0.2
      calculation: user_verified_results / total_results

    time:
      weight: 0.1
      calculation: min(days_in_system / 30, 1.0)

  thresholds:
    level_2: 0.75
    level_3: 0.90
```

## Complete Guardrail Configuration Example

```yaml
# /etc/lt/exploration-policy.yaml
exploration_policy:
  version: "1.0"

  # User and Authentication
  user: ltexplore
  ssh_key: /etc/lt/exploration_key

  # Target Systems
  allowed_hosts:
    - name: mikrotik-router
      host: 192.168.1.1
      port: 22
      trust_level: 2

    - name: glinet-wifi
      host: 192.168.1.6
      port: 22
      trust_level: 2

    - name: kubernetes-cluster
      host: k8s-api.internal
      port: 6443
      trust_level: 1

  # Command Permissions
  command_allowlist:
    # MikroTik
    - /system resource print
    - /interface bridge host print
    - /interface bridge port print
    - /interface monitor-traffic * once
    - /ip firewall connection print count-only
    - /log print where topics~"error"

    # OpenWrt
    - iwinfo *
    - ip addr
    - ip route
    - cat /proc/net/arp

    # Kubernetes
    - kubectl get *
    - kubectl describe *
    - kubectl top *

  command_blocklist:
    - /system reboot
    - /interface disable
    - /ip firewall connection remove
    - rm -rf
    - docker rm
    - kubectl delete

  # Rate Limiting
  rate_limit:
    commands_per_minute: 10
    max_concurrent: 3
    burst_allowance: 5

  # Timeouts
  timeout:
    default: 30s
    max: 5m

  # Resource Limits
  resources:
    max_cpu_percent: 25
    max_memory_mb: 500

  # Logging and Audit
  audit_log: /var/log/lt-exploration.log
  log_format: json
  log_rotation: daily
  log_retention: 90d

  # Policy Enforcement
  policy_checks:
    password_exposure: redact
    regulated_data_access: block
    suspicious_patterns: alert

  # Approval Requirements
  require_approval:
    - write_operations
    - config_changes
    - service_restarts
    - destructive_operations

  # Progressive Trust
  trust_level: 2
  auto_promote: true

  # Dry-Run Mode
  dry_run:
    available: true
    default: false
```

## Implementation Notes

### Security Considerations

1. **Principle of Least Privilege**: Start with minimal permissions, expand only as needed
2. **Defense in Depth**: Layer multiple guardrails (allowlists + rate limits + audit)
3. **Fail Closed**: When in doubt, block the operation and require approval
4. **Audit Everything**: Log all exploration activity for security review
5. **Regular Review**: Periodically review and update allowlists/blocklists

### Performance Considerations

1. **Rate Limiting**: Prevents system overload while allowing rapid exploration
2. **Timeout Enforcement**: Prevents runaway processes from consuming resources
3. **Resource Quotas**: Ensures exploration doesn't impact production workloads
4. **Concurrent Limits**: Prevents parallel exploration from overwhelming systems

### Operational Considerations

1. **Monitoring**: Track exploration patterns, success rates, failure modes
2. **Alerting**: Notify on suspicious patterns or policy violations
3. **Documentation**: Keep allowlists updated as infrastructure evolves
4. **Training**: Educate users on proper intent articulation for better results

## Example Implementations

### Shell Script Wrapper

```bash
#!/bin/bash
# /usr/local/bin/lt-explore

CONFIG="/etc/lt/exploration-policy.yaml"
LOG="/var/log/lt-exploration.log"
USER="ltexplore"

# Load configuration
# Check rate limits
# Verify command against allowlist
# Execute with timeout and resource limits
# Log everything
# Return results
```

### Python Implementation

```python
#!/usr/bin/env python3
# /usr/local/bin/lt-explore.py

import yaml
import subprocess
import logging
from typing import Dict, List
from ratelimit import RateLimiter

class ExplorationGuardrails:
    def __init__(self, config_path: str):
        self.config = self.load_config(config_path)
        self.rate_limiter = RateLimiter(
            max_calls=self.config['rate_limit']['commands_per_minute'],
            period=60
        )

    def is_command_allowed(self, command: str) -> bool:
        # Check against allowlist and blocklist
        pass

    def execute_with_guardrails(self, command: str, host: str) -> Dict:
        # Rate limit check
        # Permission check
        # Execute with timeout and resource limits
        # Log everything
        # Return results
        pass
```

This appendix provides the detailed implementation guidance for the guardrails discussed conceptually in Chapter 5. Adapt these templates to your specific infrastructure, security requirements, and operational needs.
