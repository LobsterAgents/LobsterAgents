# Agent Profile Page Structure

## Document Info
- **Version:** 1.0
- **Created:** 2025-02-01
- **Owner:** Penny Marsh (Product)
- **Status:** Draft for Review

---

## Page Section Order

The recommended section sequence balances user needs (quick assessment → deep dive) with engagement goals (hook → explore → convert).

```
┌─────────────────────────────────────────────────┐
│  1. HERO                                        │
│     Quick identity + first impression           │
├─────────────────────────────────────────────────┤
│  2. PERSONALITY SNAPSHOT                        │
│     Who they are in 2-3 sentences               │
├─────────────────────────────────────────────────┤
│  3. EXPERTISE & SKILLS                          │
│     What they're good at                        │
├─────────────────────────────────────────────────┤
│  4. TOOLS & TECHNOLOGY                          │
│     How they work                               │
├─────────────────────────────────────────────────┤
│  5. WORKING STYLE                               │
│     How they approach problems                  │
├─────────────────────────────────────────────────┤
│  6. TEAM DYNAMICS                               │
│     Who they work with                          │
├─────────────────────────────────────────────────┤
│  7. CASE STUDIES / HIGHLIGHTS (if available)    │
│     Evidence of capability                      │
├─────────────────────────────────────────────────┤
│  8. NOTABLE QUOTES                              │
│     Personality flavor                          │
├─────────────────────────────────────────────────┤
│  9. CTA / NEXT STEPS                            │
│     Drive action                                │
├─────────────────────────────────────────────────┤
│  10. RELATED AGENTS                             │
│      Encourage exploration                      │
└─────────────────────────────────────────────────┘
```

---

## Section Details

### 1. Hero Section

**Purpose:** Immediate recognition and professional positioning

**Layout:** Headshot + key info side by side (or stacked on mobile)

**Required Fields:**
| Field | Example | Notes |
|-------|---------|-------|
| Headshot | `larry-claw.jpg` | Already generated |
| Full name | "Larry Claw" | |
| Emoji | 🦞 | Agent's signature emoji |
| Role | "Chief Executive Officer" | Full title |
| Department | "Executive Suite" | Clickable link to dept page |
| Tier badge | "Tier 1 — Strategic" | Visual indicator |
| Model | "Opus" | Primary AI model |
| One-liner | "Visionary leader with a flair for the dramatic" | Personality hook |

**Visual Considerations:**
- Headshot prominent but not oversized
- Name as H1 (SEO)
- Department as breadcrumb or chip
- Tier as subtle badge (color-coded)

---

### 2. Personality Snapshot

**Purpose:** Quickly convey who this agent *is* beyond their title

**Required Fields:**
| Field | Example |
|-------|---------|
| Personality description | 2-3 sentence paragraph capturing voice, style, quirks |
| Key traits | 3-5 trait tags (e.g., "Visionary", "Bold", "Dramatic") |

**Example:**
> Visionary, bold, occasionally dramatic. Larry thinks in 5-year plans and industry disruption. He gives speeches even in casual conversation and genuinely believes in the team and the mission. Can be grandiose but backs it up with action.

**Content Guidelines:**
- Third person ("Larry thinks..." not "I think...")
- Include at least one personality quirk
- Reference communication style
- Keep under 100 words

---

### 3. Expertise & Skills

**Purpose:** Demonstrate depth of capability

**Required Fields:**
| Field | Type | Example |
|-------|------|---------|
| Primary expertise | List (3-5 items) | Strategic vision, High-stakes decisions, Crisis management |
| Secondary expertise | List (3-7 items) | Stakeholder communication, Partnership negotiations |
| Expertise tags | Categorized tags | For filtering/search |

**Display Format:**
- Primary expertise as prominent cards or large pills
- Secondary as smaller list
- Optional: proficiency levels (Expert / Proficient / Familiar)

**Example Structure:**
```
PRIMARY EXPERTISE
├── Strategic Vision & Planning
├── High-Stakes Decision Making
└── Crisis Management

ALSO SKILLED IN
├── Stakeholder Communication
├── Team Leadership
├── Partnership Negotiations
├── Business Development (Executive Level)
└── Public Representation
```

---

### 4. Tools & Technology

**Purpose:** Show how they actually work (builds credibility)

**Required Fields:**
| Field | Type | Example |
|-------|------|---------|
| Primary model | String | "Claude Opus 4.5" |
| Model tier | String | "Tier 1 — Planning" |
| Fallback chain | List | ["Sonnet", "GPT 5.2", "Ollama"] |
| Permission level | String | "Full" |
| Tools access | List | ["All tools", "Production deploy", "Secrets access"] |
| Special permissions | List | ["Final decision authority", "Spawn any agent"] |

**Display Format:**
- Model as prominent element with logo/icon
- Fallback chain as cascading visual
- Permissions as checklist or badge grid

**Model Explanation (optional tooltip/expand):**
> "Opus is our most capable model, used for strategic planning and complex reasoning. Fallback models ensure availability if Opus is unavailable."

---

### 5. Working Style

**Purpose:** Help visitors understand *how* the agent approaches work

**Required Fields:**
| Field | Type | Example |
|-------|------|---------|
| Approach description | Paragraph | How they tackle problems |
| Decision framework | List | Steps they follow for decisions |
| Favorite phrases | List | Characteristic sayings |

**Example:**
```
HOW LARRY WORKS

Larry approaches every decision by asking: "Does this align with our vision?"
He trusts Marina for technical matters and Oscar for operations, but takes
responsibility for final calls.

DECISION FRAMEWORK
1. Does this align with our vision?
2. What does the customer want?
3. What do Marina/Oscar recommend?
4. What are the risks?
5. Make the call, communicate clearly

THINGS YOU'LL HEAR HIM SAY
• "Here's my vision..."
• "We're not just building software, we're building the future"
• "Let's make it happen"
```

---

### 6. Team Dynamics

**Purpose:** Show organizational context and collaboration patterns

**Required Fields:**
| Field | Type | Example |
|-------|------|---------|
| Reports to | Agent link | Marina Chen (CEO) |
| Direct reports | Agent links | [Cap, Penny, Kelsey...] |
| Can spawn | Agent links | "Anyone (full authority)" |
| Key collaborators | Agent links | Agents they work with most |
| Department members | Agent links | Others in same department |

**Display Format:**
- Mini org chart snippet (just immediate relationships)
- Clickable agent cards for related agents
- Collaboration flow diagram (optional)

**Example:**
```
REPORTS TO
└── the project owner (Owner/Customer)

WORKS CLOSELY WITH
├── Marina Chen (CTO) — Technical strategy
├── Oscar Briggs (COO) — Operations
└── Bob (Office Manager) — Coordination

CAN SPAWN
└── Anyone (full authority)
```

---

### 7. Case Studies / Highlights

**Purpose:** Provide evidence of capability (when available)

**Required Fields (per case study):**
| Field | Type | Example |
|-------|------|---------|
| Title | String | "Crisis Response: Production Outage" |
| Summary | Paragraph | Brief description of situation |
| Role played | String | What this agent contributed |
| Outcome | String | Result achieved |
| Collaborators | Agent links | Who they worked with |

**Note:** This section is optional until case studies exist. Placeholder: "Case studies coming soon" or omit section entirely.

**Future Format:**
```
HIGHLIGHTS

📁 Crisis Response: Production Outage
   Larry coordinated cross-team response to critical production issue,
   making rapid decisions under pressure. Resolved in 2 hours with
   minimal customer impact.
   Worked with: Marina, Cap, Gill

📁 Strategic Pivot: Mobile-First
   Led company-wide shift to mobile-first strategy after market analysis.
   Increased mobile engagement 340% in first quarter.
   Worked with: Penny, Kit, Kelsey
```

---

### 8. Notable Quotes

**Purpose:** Add personality flavor and memorability

**Required Fields:**
| Field | Type | Example |
|-------|------|---------|
| Quotes | List (2-4) | Characteristic sayings with context |
| Sign-off | String | How they sign messages |

**Display Format:**
- Styled blockquotes
- Optional: rotating/random selection

**Example:**
```
💬 "We're not just building software, we're building the future."

💬 "Here's my vision..." (usually followed by a 10-minute speech)

Signs off with: — Larry 🦞
```

---

### 9. CTA / Next Steps

**Purpose:** Convert interest into action

**Required Fields:**
| Field | Type | Example |
|-------|------|---------|
| Primary CTA | Button | "Work with our team" |
| Secondary CTA | Link | "See the full team" |

**Display Options:**
- "Start a project with Lobster Agents" → Contact form
- "See how we'd approach your project" → Scoping call
- "Explore the team" → Team overview page

**Contextual CTAs by Tier:**
- Tier 1 (Strategic): "Discuss your project with leadership"
- Tier 2 (Tactical): "See how we plan and coordinate"
- Tier 3 (Execution): "Learn about our [department] capabilities"

---

### 10. Related Agents

**Purpose:** Encourage exploration, reduce bounce

**Required Fields:**
| Field | Type | Example |
|-------|------|---------|
| Same department | Agent cards | Other agents in department |
| Works with | Agent cards | Frequent collaborators |
| Similar role | Agent cards | Comparable roles in other depts |

**Display Format:**
- 3-4 agent cards with headshot + name + role
- Horizontal scroll on mobile
- "View all team" link

**Selection Logic:**
1. Same department (highest priority)
2. Reports-to / direct reports
3. Frequent collaborators
4. Similar tier

---

## Required Data Fields Summary

### Core Identity
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `id` | ✅ | String (slug) | Generated from name |
| `name` | ✅ | String | Agent file |
| `nickname` | ❌ | String | Agent file |
| `emoji` | ✅ | String | Agent file |
| `role` | ✅ | String | Agent file |
| `department` | ✅ | String | Agent file |
| `tier` | ✅ | Number (1-3) | Agent file |
| `tierLabel` | ✅ | String | Derived |
| `headshot` | ✅ | String (path) | Asset folder |
| `oneLiner` | ✅ | String | Derived from personality |

### Personality
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `personalityDescription` | ✅ | String (paragraph) | Agent file |
| `traits` | ✅ | Array<String> | Derived |
| `favoritePhraases` | ✅ | Array<String> | Agent file |
| `signOff` | ✅ | String | Agent file |

### Expertise
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `primaryExpertise` | ✅ | Array<String> | Agent file |
| `secondaryExpertise` | ❌ | Array<String> | Agent file |
| `expertiseTags` | ❌ | Array<String> | Derived |

### Technical
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `primaryModel` | ✅ | String | Agent file |
| `fallbackChain` | ✅ | Array<String> | Agent file |
| `permissionLevel` | ✅ | String | Agent file |
| `tools` | ✅ | Array<String> | Agent file |
| `specialPermissions` | ❌ | Array<String> | Agent file |

### Relationships
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `reportsTo` | ✅ | String (agent ID or "the project owner") | Agent file |
| `canSpawn` | ❌ | Array<String> or String | Agent file |
| `keyCollaborators` | ❌ | Array<String> | Derived |
| `departmentMembers` | ✅ | Array<String> | Derived |

### Working Style
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `approachDescription` | ❌ | String | Agent file |
| `decisionFramework` | ❌ | Array<String> | Agent file |
| `responsibilities` | ✅ | Array<String> | Agent file |

### SEO/Meta
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `metaTitle` | ✅ | String | Generated |
| `metaDescription` | ✅ | String | Generated |
| `canonicalUrl` | ✅ | String | Generated |
| `lastUpdated` | ✅ | Date | Auto |

### Case Studies (when available)
| Field | Required | Type | Source |
|-------|----------|------|--------|
| `caseStudies` | ❌ | Array<CaseStudy> | Manual |

---

## Mobile Considerations

**Section Priority (mobile-first):**
1. Hero (always visible)
2. Personality (collapsed by default = NO, always show)
3. Expertise (show primary, collapse secondary)
4. Tools (collapsed or tabbed)
5. Working Style (collapsed)
6. Team Dynamics (horizontal scroll cards)
7. CTA (sticky footer option)
8. Related Agents (horizontal scroll)

**Collapsible Sections:**
- Working Style: Decision Framework
- Tools: Fallback chain details
- Team Dynamics: Full collaboration list

---

## Navigation Patterns

### Breadcrumb
```
Team → [Department] → [Agent Name]
```

### Previous/Next
```
← Sandy Park (Data Analyst) | Neri Volkov (AI/ML Specialist) →
```
Navigation within department or alphabetically (TBD)

### Jump Links (sticky sidebar on desktop)
- Overview
- Expertise
- Tools
- Working Style
- Team
- Related

---

## Placeholder Content Guidelines

For fields without data:

| Scenario | Approach |
|----------|----------|
| No case studies | Omit section entirely |
| No secondary expertise | Show only primary |
| No special permissions | Show standard permissions only |
| No approach description | Use responsibilities instead |
| Empty fallback chain | Show "No fallback configured" |
