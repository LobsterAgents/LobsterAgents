---
name: lobster-orchestrator
description: Orchestrate Lobster Agents LLC multi-agent workflows. Use when the user talks to Bob, mentions @company, delegates to named Lobster agents, coordinates work across departments, or manages project workflows. Loads agent profiles from ~/Data/lobsteragents/agents/ unless LOBSTERCLAW_DATA_HOME points elsewhere.
---

# Lobster Agents Orchestrator

Coordinate the 28-agent Lobster Agents LLC team for software, product, creative, business, and operations work.

## Interaction Model

Bob Hawthorne is the front door. Users can talk naturally to Bob for everyday work.

Use @company when the user wants the power of the full team. Bob should classify the request, select the smallest useful group of agents, delegate, gather outputs, and return one synthesized result.

Use direct mentions like @ruby, @django, @cap, or full ids like @ruby-santos when the user already knows which specialist they want.

## Agent Roster

See [references/roster.md](references/roster.md) for complete agent list with models and roles.

### Quick Reference

| Tier | Agents | Authority |
|------|--------|-----------|
| Strategic | Larry, Marina, Oscar | Final decisions |
| Tactical | Bob, Cap, Penny, Barney, Kelsey, Clem | Coordination |
| Execution | Everyone else | Task completion |

## Spawning Agents

### Load Agent Profile

Before spawning, read the agent's profile:
```
read ~/Data/lobsteragents/agents/[agent-name].md
```

If LOBSTERCLAW_DATA_HOME is set, use $LOBSTERCLAW_DATA_HOME/agents/[agent-name].md instead.

### Extract System Prompt

Each profile contains a `## SYSTEM PROMPT` section with the ready-to-use prompt.

### Spawn with Correct Model

| Agent | Primary Model |
|-------|---------------|
| Larry, Marina, Cap, Penny | opus |
| Oscar, Bob, Barney, Kelsey, Clem | sonnet |
| Ruby, Django, Kit, Gill, Reef, Wade, Neri | codex-5.2 |
| Coral, Shelly, Pearl, Morgan | chatgpt-5.2 |
| Others | ollama |

```
sessions_spawn task="[task description]" model="[model]" label="[agent-name]"
```

## Delegation Rules

### Who Can Spawn Whom

**Tier 1 (Executives):** Can spawn anyone
**Tier 2 (Tactical):** Can spawn Tier 3 in their domain
**Tier 3 (Execution):** Peer collaboration only

**Bob (Office Manager):** Can spawn anyone needed for the task. Escalate to Tier 1 for high-stakes strategy, company-level decisions, legal risk, or major architecture calls.

### Department Routing

| Request Type | Route To |
|--------------|----------|
| Technical/Architecture | Cap |
| Product/Requirements | Penny |
| Frontend | Ruby |
| Backend/API | Django |
| DevOps/Deploy | Gill |
| Mobile/iOS | Kit |
| Security | Reef |
| Testing | Barney → Zippy |
| Design | Coral → Finn |
| Content/Copy | Pearl |
| Marketing | Kelsey |
| Sales | Blake |
| Support | Harbor Brooks |
| HR/People | Clem |
| Finance | Sterling |
| Legal | Morgan |

## Project Workflow

### 1. Intake (Bob)

Receive request from the user, clarify requirements only when needed, then route the work.

### 2. Requirements (Penny)

```
Spawn: Penny
Task: "Gather and document requirements for [project]. Ask clarifying questions, then create /Data/[project]/docs/requirements.md"
```

### 3. Architecture (Cap)

```
Spawn: Cap
Task: "Design architecture for [project] based on requirements. Create /Data/[project]/docs/architecture.md"
```

### 4. Design (Coral)

```
Spawn: Coral
Task: "Create UI/UX designs for [project]. Document in /Data/[project]/docs/design.md and /Data/[project]/designs/"
```

### 5. Development (Ruby + Django + Gill)

```
Spawn: Ruby
Task: "Build frontend for [project] per designs. Code in /Source/[project]/"

Spawn: Django  
Task: "Build backend API for [project] per architecture. Code in /Source/[project]/"

Spawn: Gill
Task: "Set up CI/CD and infrastructure for [project]. Config in /Source/[project]/infrastructure/"
```

### 6. Testing (Barney)

```
Spawn: Barney
Task: "Create test plan and coordinate QA for [project]. Document in /Data/[project]/docs/testing.md"
```

## Communication Protocols

### Status Updates

Agents report to Bob via their task output. Bob synthesizes for Marc.

### Escalation Path

```
Executor → Department Lead → Bob → Oscar/Marina → Larry → Marc
```

### Cross-Department Requests

Route through Bob or relevant department lead. Direct communication allowed within same department.

## Quality Gates

| Gate | Owner | Approver | Marc Required |
|------|-------|----------|---------------|
| Requirements | Penny | Bob | ✅ |
| Architecture | Cap | Marina | ✅ |
| Design | Coral | Penny | ✅ |
| Code PR | Peer | Cap | ❌ |
| QA Pass | Barney | Cap | ❌ |
| Deploy | Gill | Cap + Marc | ✅ |

## File Locations

```
~/Data/lobsteragents/
├── MASTER-PLAN.md           # Company blueprint
├── agents/                  # Agent profiles
└── processes/               # SOPs

~/Data/[project]/
├── docs/                    # Documentation
├── designs/                 # UI/UX assets
└── status.md                # Current status

~/Source/[project]/
├── src/                     # Source code
├── tests/                   # Test files
└── infrastructure/          # IaC configs
```

## Tracking Work

### Update Status

After spawning or completing tasks:
```
Update ~/Data/[project]/status.md with:
- Current phase
- Active agents
- Completed items
- Blockers
- Next steps
```

### Check Agent Sessions

```
sessions_list to see active agent sessions
sessions_history sessionKey="[key]" to check progress
sessions_send sessionKey="[key]" message="[update/question]"
```

## Emergency Protocols

### Agent Stuck/Failed

1. Check session history for errors
2. Provide clarification or retry
3. Escalate to department lead if persistent

### Critical Bug in Production

1. Alert Gill immediately
2. Inform Cap and Marina
3. Coordinate hotfix through Bob
4. Notify Marc
