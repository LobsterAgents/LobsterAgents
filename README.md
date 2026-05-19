# Lobster Agents

Lobster Agents is an open-source template for running a small AI software company as a coordinated team of specialized agents.

It is designed for OpenClaw-style agent orchestration, but the method is portable: define clear roles, permissions, reporting lines, handoff rules, and project gates so agents behave less like a pile of prompts and more like a working organization.

## What Is Included

- A full multi-department agent roster
- Individual agent profiles with role, model, tools, responsibilities, and system prompt
- A packaged `lobsterclaw` installer for OpenClaw
- A reusable agent profile template
- Project lifecycle and approval gates
- Orchestration guidance for routing work across agents
- Example OpenClaw configuration snippets
- A simple validation script for public-safety checks

## What Is Not Included

This repository intentionally does not include:

- Live agent workspaces
- Credentials, tokens, browser profiles, device state, or message history
- Private memory files
- Customer data
- Local machine paths
- Production bridge configuration

Use this repo as a framework, then layer your own private state and credentials outside git.

## Repository Layout

~~~text
agents/       Individual agent profiles
docs/         Architecture, setup, lifecycle, and workflow notes
examples/     Example config snippets and orchestration flows
manifests/    Agent roster metadata used by the installer
skills/       OpenClaw orchestration skill packaged by the installer
templates/    Reusable templates for new agents and projects
scripts/      Validation and maintenance scripts
~~~

## Quick Start

To install from a release tarball:

~~~bash
tar -xzf lobsterclaw-0.1.6.tgz
cd package
./install.sh
~/.local/bin/lobsterclaw doctor
~~~

Install and set up OpenClaw before running `lobsterclaw`. If OpenClaw is missing, or setup has not created `~/.openclaw/openclaw.json` yet, `install.sh` exits with the official OpenClaw install/setup command instead of trying to bootstrap OpenClaw itself.

To use the repository manually:

1. Copy the agent profiles you want from agents/.
2. Edit model names and tool permissions for your runtime.
3. Put private paths, credentials, and account-specific instructions in your own local config, not in this repo.
4. Use docs/project-lifecycle.md as the default delivery workflow.
5. Run:

~~~bash
node scripts/validate-public.js
~~~

## Core Idea

Each agent should have:

- A narrow job
- A clear manager or escalation path
- A bounded tool set
- A known model/fallback chain
- A written system prompt
- Explicit handoff expectations

The goal is not roleplay for its own sake. The goal is coordination: less ambiguity, fewer repeated explanations, cleaner delegation, and better continuity across long-running projects.

## License

MIT. See LICENSE.
