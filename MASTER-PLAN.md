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
npm install -g ./lobsterclaw-0.1.2.tgz
lobsterclaw install
lobsterclaw doctor
~~~

The installer backs up the OpenClaw config before patching agent entries.
