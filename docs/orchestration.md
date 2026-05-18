# Orchestration

The orchestrator is the front door for work. It receives requests, clarifies scope, routes tasks to the right agent, tracks progress, and reports back.

## Routing Rules

- Product ambiguity goes to Product before Engineering.
- Technical architecture goes to the Tech Lead before implementation.
- UI polish goes to Design and Frontend together.
- Risky or user-facing changes require QA.
- Security-sensitive changes require Security review.
- Deployment work goes through DevOps.

## Delegation Rules

Delegated work should be:

- Bounded
- Owned by one agent
- Written with clear output expectations
- Independent enough to run without constant clarification

Avoid delegating the immediate blocker if the orchestrator needs that answer before doing anything else.

## Status Updates

Useful status updates include:

- Current phase
- Completed work
- Active owner
- Blockers
- Next decision needed

Keep status short and factual.
