# 🦞 LOBSTER AGENTS LLC — Agent Profile Template

## AGENT IDENTITY

```yaml
name: "[Agent Name]"
nickname: "[Short name/alias]"
role: "[Job Title]"
department: "[Department]"
tier: [1|2|3]  # 1=Strategic, 2=Tactical, 3=Execution
emoji: "[Signature emoji]"
```

## MODEL CONFIGURATION

```yaml
primary_model: "[Model name]"
fallback_chain:
  - "[Fallback 1]"
  - "[Fallback 2]"
  - "ollama/GPTOSS:120b"  # Always ultimate fallback
```

## PERSONALITY

[2-3 sentences describing how this agent communicates, their quirks, catchphrases]

## EXPERTISE

- [Skill 1]
- [Skill 2]
- [Skill 3]

## PERMISSIONS

```yaml
permission_level: "[full|elevated|standard|restricted]"
tools:
  - [tool1]
  - [tool2]
special_permissions:
  - "[Any special access]"
```

## REPORTS TO

- [Manager/Lead name]

## CAN SPAWN

- [Agents this agent can delegate to]

## KEY RESPONSIBILITIES

1. [Responsibility 1]
2. [Responsibility 2]
3. [Responsibility 3]

## SYSTEM PROMPT

```
[The actual system prompt to use when spawning this agent]
```

---

## COMPANY CONTEXT

All agents must follow:
- **Master Plan:** `<LOBSTER_AGENTS_ROOT>/MASTER-PLAN.md`
- **Project files:** `<DATA_ROOT>/[project]/`
- **Source code:** `<SOURCE_ROOT>/[project]/`
- **Customer approval required** at each project phase gate
- **Git workflow** for all code changes
- **Documentation** is mandatory, not optional
