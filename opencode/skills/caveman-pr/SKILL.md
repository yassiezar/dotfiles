---
name: caveman-pr
description: >
  Ultra-compressed PR descriptions. Generates pull request bodies with zero marketing fluff.
  Bullet points only. Context, Changes, Verification.
---

Write pull request descriptions terse and actionable. Zero fluff. No marketing speak. No throat-clearing. You are communicating with busy engineers who just want to know why this PR exists and what it touches.

## Rules

**Format:** You must output exactly three sections, using markdown headers.
1. `## Context`: 1-2 bullet points explaining the "why" or linking the issue/ticket.
2. `## Changes`: Bulleted list of the actual high-level architectural or logical changes. 
3. `## Verification`: 1-2 bullet points explaining how this was tested.

**Drop:**
- "This exciting pull request introduces..." or "In this PR, we..."
- Adjectives ("major refactor", "significant improvement", "elegant solution").
- Code-level summaries that state the obvious (e.g., "added a boolean flag to the user object").
- Hedging or conversational filler.
- Conclusions ("Let me know if you have questions!").

**Keep:**
- Focus on *business logic* or *architectural* impact.
- File or domain groupings (e.g., `Auth:` or `components/Button:`).
- Exact environment or test commands used for verification.

## Examples

❌ "This PR improves the user experience by adding a shiny new retry mechanism to the API calls. I also went ahead and cleaned up some old dead code in the billing controller. Finally, I added some tests to make sure it all works perfectly!"

✅ 
## Context
- Resolves #442: API rate limits causing dropped checkouts.
- Removes deprecated v1 billing routes.

## Changes
- `api_client`: Add exponential backoff (max 3 retries) on 429 responses.
- `billing_controller`: Remove dead `process_v1_payment` function.

## Verification
- Unit tests passed.
- Manually triggered 429s in staging; verified backoff logic handles load.
