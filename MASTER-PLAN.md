# Lobster Agents LLC - Master Plan

Lobster Agents is a coordinated multi-agent software company pattern. It defines a roster, reporting lines, model tiers, responsibilities, and handoff rules so OpenClaw agents can work as a structured team.

## Operating Model

- Bob Hawthorne is the default front door and office manager.
- Department leads route work to specialists.
- Agents keep durable project notes in their assigned workspaces.
- Private customer data and credentials stay outside this public repository.

## Runtime Layout

The installer creates runtime files under user-owned local directories:

- OpenClaw state: ~/.openclaw
- Lobster company data: ~/Data/lobsteragents
- Agent workspaces: ~/Data/lobsteragents/workspaces
- Project source code: ~/Source

## Installation

Install the package tarball with npm, then run the installer:

~~~bash
tar -xzf LobsterAgents-0.1.10.tgz
cd package
./install.sh
lobsteragents models openai/gpt-5.5-pro openai/gpt-5.5 vllm/qwen3.6-fp8
lobsteragents connect main
lobsteragents doctor
~~~

The installer backs up the OpenClaw config before patching agent entries.
