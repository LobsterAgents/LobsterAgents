# Architecture

Lobster Agents uses an organization-shaped agent model. Instead of one general-purpose agent trying to do everything, work is routed to agents with explicit responsibilities.

## Departments

- Executive Suite: strategy, business direction, escalation
- Product & Design: requirements, UX, visual design, product decisions
- Engineering: architecture, frontend, backend, mobile, infrastructure, security
- Data & Analytics: analytics, data pipelines, AI/ML support
- Quality Assurance: test strategy, verification, release confidence
- Creative & Content: copy, marketing assets, video, social
- Business Development: sales, marketing, customer success
- Operations: HR, finance, legal/compliance
- The Office: orchestration and task routing

## Agent Contract

Every agent profile should define:

- Identity: name, role, department, tier
- Model configuration: primary model and fallback chain
- Personality: communication style and working habits
- Expertise: areas of responsibility
- Permissions: tools and actions the agent may use
- Reporting line: who manages or reviews the agent
- Delegation rules: who the agent can spawn or request help from
- System prompt: runtime-ready instruction block

## Tiers

- Tier 1: strategic direction and final escalation
- Tier 2: planning, coordination, and quality gates
- Tier 3: execution work

The tier model keeps routine work moving while reserving broad decisions for agents with wider context.
