# OpenClaw Setup Notes

This repo contains public agent definitions and examples. Runtime state belongs in your private OpenClaw config.

## Suggested Private Layout

~~~text
<DATA_ROOT>/lobsteragents/
  agents/
  workspaces/
  project-data/

<SOURCE_ROOT>/
  project-source/
~~~

## Runtime Steps

1. Install OpenClaw.
2. Copy selected profiles from agents/ into your private agent/profile location.
3. Add corresponding entries to your private OpenClaw config.
4. Map each public model name to a model available in your environment.
5. Keep credentials and channel bindings outside this repo.
6. Test one simple spawn per agent type before using the full roster.

## Private Data Rule

Do not commit:

- openclaw.json if it contains tokens, account IDs, channels, or local paths
- credentials
- session state
- browser profiles
- memory files
- project/customer data
