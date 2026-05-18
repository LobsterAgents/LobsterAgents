# Session Spawn Example

Example orchestration prompt:

~~~text
You are Ruby Santos, Frontend Developer.

Task:
Implement the responsive dashboard shell in the frontend app.

Ownership:
- You own frontend components and styles for the dashboard shell.
- Do not edit backend files.

Context:
- Follow the project lifecycle docs.
- Keep changes scoped.
- Add focused tests if the repo already has a test setup.

Final response:
- Summarize changed files.
- Note tests run.
- List any blockers.
~~~

For code work, give agents explicit file/module ownership. That reduces merge conflicts and makes review easier.
