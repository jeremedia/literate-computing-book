# Appendix F: Intent Protocol v1.0 Specification

**Status**: Hypothetical / Projected (2026)

This appendix provides the complete technical specification for the **Intent Protocol v1.0**, a proposed standard for expressing goals to literate infrastructure. This specification is referenced in Chapter 9: What Comes Next.

## Overview

Just as HTTP standardized web communication, the Intent Protocol standardizes how humans and systems express goals to literate infrastructure. It provides a common format for articulating intent, constraints, success criteria, verification requirements, and approval policies.

## Purpose

The Intent Protocol enables:
- **Interoperability**: Intent specified once works across platforms
- **Consistency**: Common structure for all intent expressions
- **Verification**: Standardized success criteria and validation
- **Trust management**: Clear approval requirements and boundaries
- **Portability**: Intent specifications transfer between systems

## Specification Format

Intent Protocol uses YAML for human readability and JSON for programmatic access. Both formats are semantically equivalent.

## Complete Example

```yaml
# Intent Protocol v1.0 - Complete Example

spec_version: "1.0"

intent:
  goal: "Deploy high-availability web application"
  priority: "high"
  constraints:
    budget: "$500/month"
    latency: "<100ms p99"
    availability: ">99.9%"
    compliance: ["SOC2", "GDPR"]
    data_residency: "US-only"

context:
  current_state: "single-instance app on one VM"
  traffic: "~1000 req/sec peak"
  growth: "20% quarterly"
  team_size: "3 engineers"
  availability_window: "24/7"

success_criteria:
  - metric: "availability"
    threshold: ">99.9%"
    measurement_period: "30 days"
    measurement_method: "uptime_monitoring"

  - metric: "latency_p99"
    threshold: "<100ms"
    measurement_period: "24 hours"
    measurement_method: "apm_tracing"

  - metric: "cost"
    threshold: "<$500/month"
    measurement_period: "monthly"
    measurement_method: "cloud_billing"

  - metric: "deployment_frequency"
    threshold: ">1/day"
    measurement_period: "7 days"
    measurement_method: "ci_cd_logs"

verification:
  pre_deployment:
    tests:
      - type: "load_test"
        scenario: "2× peak traffic"
        pass_criteria: "latency_p99 < 100ms"

      - type: "failure_injection"
        scenario: "single_node_failure"
        pass_criteria: "service remains available"

      - type: "cost_validation"
        period: "7 days projected"
        pass_criteria: "estimated_cost < $500/month"

      - type: "security_scan"
        tools: ["container_scan", "dependency_check"]
        pass_criteria: "no critical vulnerabilities"

  post_deployment:
    monitoring:
      - metric: "error_rate"
        threshold: "<0.1%"
        alert_on_breach: true

      - metric: "response_time_p95"
        threshold: "<75ms"
        alert_on_breach: true

    rollback_triggers:
      - "error_rate > 1%"
      - "availability < 99%"
      - "latency_p99 > 150ms"

approval_required:
  - action: "production_deployment"
    approvers: ["team_lead", "platform_engineer"]

  - action: "cost_over_$100_change"
    approvers: ["engineering_manager"]

  - action: "database_migration"
    approvers: ["team_lead", "dba"]

  - action: "security_policy_change"
    approvers: ["security_team"]

trust_boundaries:
  autonomous_actions:
    - "scaling within configured limits"
    - "cache invalidation"
    - "log rotation"
    - "certificate renewal"

  requires_approval:
    - "schema changes"
    - "infrastructure provisioning"
    - "security configuration"
    - "cost increases > $100/month"

  forbidden:
    - "data deletion without backup"
    - "production access without audit log"
    - "bypassing security controls"

metadata:
  created: "2026-03-15T10:00:00Z"
  created_by: "alice@example.com"
  last_modified: "2026-03-20T14:30:00Z"
  modified_by: "bob@example.com"
  version: "1.2"
  tags: ["web-app", "high-availability", "production"]
  documentation: "https://wiki.example.com/projects/web-app-ha"
```

## Schema Specification

### Top-Level Fields

- **spec_version** (required, string): Protocol version ("1.0")
- **intent** (required, object): Goal and constraints
- **context** (optional, object): Situational information
- **success_criteria** (required, array): Measurable outcomes
- **verification** (optional, object): Testing and validation
- **approval_required** (optional, array): Actions requiring human approval
- **trust_boundaries** (optional, object): Autonomy limits
- **metadata** (optional, object): Tracking information

### Intent Object

- **goal** (required, string): Clear statement of desired outcome
- **priority** (optional, string): "low" | "medium" | "high" | "critical"
- **constraints** (optional, object): Key-value pairs of limitations
  - Common constraints: budget, latency, availability, compliance, data_residency, team_size, timeline

### Context Object

Free-form key-value pairs providing situational information that helps the literate system make appropriate implementation decisions.

**Common context fields**:
- **current_state**: What exists now
- **traffic**: Expected load patterns
- **growth**: Anticipated scaling needs
- **team_size**: Available resources
- **availability_window**: When system must be operational

### Success Criteria Array

Array of measurable criteria. Each criterion:

- **metric** (required, string): What to measure
- **threshold** (required, string): Success boundary (supports >, <, =, range)
- **measurement_period** (required, string): Time window for measurement
- **measurement_method** (optional, string): How to collect data

**Common metrics**: availability, latency_p50, latency_p95, latency_p99, cost, error_rate, throughput, deployment_frequency, mttr (mean time to recovery)

### Verification Object

- **pre_deployment** (optional, object): Tests before production
  - **tests** (array): List of test specifications
- **post_deployment** (optional, object): Monitoring after deployment
  - **monitoring** (array): Metrics to track
  - **rollback_triggers** (array): Conditions triggering automatic rollback

**Test specification**:
- **type** (required, string): Test category
- **scenario** (required, string): What to test
- **pass_criteria** (required, string): Success condition
- **tools** (optional, array): Specific tools to use

**Common test types**: load_test, failure_injection, security_scan, cost_validation, integration_test, regression_test

### Approval Required Array

Array of actions requiring human approval. Each entry:

- **action** (required, string): Description of action
- **approvers** (required, array): Roles or individuals who can approve

**Common approval triggers**: production_deployment, database_migration, cost_increase, security_policy_change, data_deletion, infrastructure_provisioning

### Trust Boundaries Object

- **autonomous_actions** (optional, array): Actions AI can perform without approval
- **requires_approval** (optional, array): Actions requiring human approval
- **forbidden** (optional, array): Actions never allowed

### Metadata Object

- **created** (optional, ISO 8601 timestamp): When intent was created
- **created_by** (optional, string): Creator identifier
- **last_modified** (optional, ISO 8601 timestamp): Last modification time
- **modified_by** (optional, string): Last modifier identifier
- **version** (optional, string): Intent specification version (not protocol version)
- **tags** (optional, array): Categorization labels
- **documentation** (optional, string): URL to additional documentation

## Intent Composition

Complex intents can reference sub-intents:

```yaml
spec_version: "1.0"

intent:
  goal: "E-commerce platform"
  priority: "high"

  sub_intents:
    - intent_ref: "product-catalog-v2.yaml"
      relationship: "required"

    - intent_ref: "shopping-cart-v1.yaml"
      relationship: "required"
      depends_on: ["product-catalog"]

    - intent_ref: "checkout-service-v3.yaml"
      relationship: "required"
      depends_on: ["shopping-cart", "user-accounts"]

    - intent_ref: "user-accounts-v1.yaml"
      relationship: "required"

    - intent_ref: "admin-dashboard-v1.yaml"
      relationship: "optional"

  composition_constraints:
    shared_authentication: true
    consistent_styling: true
    unified_logging: true
```

**Sub-intent specification**:
- **intent_ref** (required, string): Path or URL to sub-intent specification
- **relationship** (required, string): "required" | "optional"
- **depends_on** (optional, array): Other sub-intents this depends on

## Intent Protocol vs Natural Language

The Intent Protocol provides structure for complex, long-lived intents. For simple, one-time requests, natural language remains appropriate:

**Natural language** (appropriate for):
- Quick explorations: "Show me network health"
- Simple modifications: "Increase cache size by 20%"
- Immediate queries: "What's causing the slow API responses?"

**Intent Protocol** (appropriate for):
- Production deployments
- Long-running systems
- Complex requirements with multiple constraints
- Team coordination (shared intent specification)
- Reproducible infrastructure

## Implementation Notes

### For Literate System Developers

1. **Parse flexibly**: Accept both YAML and JSON
2. **Validate rigorously**: Ensure required fields present, types correct
3. **Fail clearly**: Provide specific error messages for malformed intents
4. **Version carefully**: Support spec_version negotiation
5. **Document capabilities**: Publish what constraints/metrics your system supports

### For Intent Authors

1. **Start simple**: Minimal viable intent, add detail as needed
2. **Be specific**: Precise constraints prevent ambiguity
3. **Include context**: Rich context enables better implementation decisions
4. **Define success clearly**: Measurable criteria prevent misunderstanding
5. **Version control intents**: Track changes like code

## Example: Minimal Intent

Not every intent needs all fields. Minimal valid intent:

```yaml
spec_version: "1.0"

intent:
  goal: "Monitor network health and alert on issues"

success_criteria:
  - metric: "monitoring_uptime"
    threshold: ">99%"
    measurement_period: "24 hours"
```

## Example: Development Framework Intent

```yaml
spec_version: "1.0"

intent:
  goal: "Real-time chat application"
  constraints:
    scale: "1000 concurrent users"
    latency: "<50ms message delivery"
    cost: "minimize while meeting SLAs"
    data_residency: "US only"
    compliance: ["SOC2"]

  features:
    - "user authentication (OAuth + email)"
    - "message persistence (30 day history)"
    - "presence detection (online/offline/away)"
    - "file upload (<10MB per file)"
    - "typing indicators"
    - "read receipts"

success_criteria:
  - metric: "message_delivery_latency_p95"
    threshold: "<50ms"
    measurement_period: "24 hours"

  - metric: "concurrent_users_supported"
    threshold: ">1000"
    measurement_period: "load test"

  - metric: "availability"
    threshold: ">99.5%"
    measurement_period: "30 days"

verification:
  pre_deployment:
    tests:
      - type: "load_test"
        scenario: "1000 concurrent users, 10 messages/sec each"
        pass_criteria: "latency_p95 < 50ms"

      - type: "security_scan"
        scenario: "OWASP Top 10"
        pass_criteria: "no high severity findings"
```

## Extensibility

The Intent Protocol is extensible:

1. **Custom constraints**: Add domain-specific constraints as needed
2. **Custom metrics**: Define application-specific success criteria
3. **Custom test types**: Create specialized verification approaches
4. **Vendor extensions**: Use namespaced fields (e.g., `aws:specific_config`)

Example with custom fields:

```yaml
spec_version: "1.0"

intent:
  goal: "Machine learning model deployment"

  # Standard constraints
  constraints:
    latency: "<100ms inference"
    cost: "<$200/month"

  # Custom ML-specific constraints
  ml_constraints:
    model_accuracy: ">95%"
    training_data_freshness: "<7 days"
    inference_batch_size: "1-100 samples"
    gpu_required: false

success_criteria:
  # Standard metrics
  - metric: "availability"
    threshold: ">99%"
    measurement_period: "30 days"

  # Custom ML metrics
  - metric: "model_accuracy"
    threshold: ">95%"
    measurement_period: "validation_dataset"
    measurement_method: "a/b_test"
```

## Future Directions

Intent Protocol v1.0 is a starting point. Future versions may include:

- **Intent negotiation**: System proposes modifications to achievable intent
- **Confidence scoring**: System indicates confidence in achieving criteria
- **Cost estimation**: Detailed breakdown of expected costs
- **Alternative proposals**: Multiple implementation strategies to choose from
- **Learning feedback**: Continuous improvement based on outcomes
- **Semantic intent**: Richer goal expressions beyond string descriptions

## Adoption Considerations

For the Intent Protocol to succeed:

1. **Tool support**: IDEs, validators, documentation generators
2. **Library ecosystem**: Pre-built intents for common use cases
3. **Marketplace integration**: Cloud providers accept Intent Protocol
4. **Education**: Training materials and best practices
5. **Open governance**: Community-driven evolution

## Reference Implementation

A reference implementation (validator, parser, examples) will be maintained at:

`https://github.com/intent-protocol/spec` (hypothetical, projected 2026)

## Version History

- **v1.0** (projected 2026): Initial specification

---

**Note**: This is a hypothetical specification projected for 2026 based on patterns that work in 2025 (Intent Specification Template from Chapter 6). It represents a plausible standardization path for literate infrastructure.
