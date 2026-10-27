---
name: accessible-frontend
description: Build React flows with English/Hindi localization, keyboard access, and WCAG checks. Use for the SPA, swipe deck, consent screens, or static landing page.
---

# Accessible frontend

Keep the landing page static and indexable at `/` and `/hi/`; the SPA lives under `/app/`. Put user-facing strings in `frontend/src/locales/en.json` and `hi.json`; use English fallback and keep keys aligned. Add consent, privacy and error keys to `.agent/docs/HINDI_REVIEW.md`.

Every swipe action needs an equivalent button. Provide visible focus, labels, and status text that does not rely on color. Set the document language and retain Devanagari-capable system font fallbacks. Verify main flows with keyboard tests and Playwright plus axe; record serious or critical findings and fix them before a checkpoint closes. Check the initial JS budget and swipe paint latency from the bootstrap prompt.
