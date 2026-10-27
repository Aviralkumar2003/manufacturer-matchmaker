## 5. Requirements register

Compound PRD items stay as one ID where one acceptance scenario covers them; every sub-assertion in the PRD's `AC-` scenarios becomes its own test case. Priority P2 items are recorded so the agent does not build them.

| ID | Requirement | PRD source | Type | ISO 25010 characteristic | Priority | Checkpoint |
|---|---|---|---|---|---|---|
| FR-001 | Visitor can sign up and sign in with a Google account; cancelling sign-in creates no account | FR-1 / AC-FR-1 | Functional | - | P0 | 2 |
| FR-002 | Withdrawn: phone OTP sign-in (conflicts with zero cost, D-12). No OTP code may exist. | FR-2 / D-12 | Negative | - | n/a | 2 |
| FR-003 | User can choose English or Hindi; all user-facing text renders in the chosen language and the choice persists | FR-3 | Functional | - | P0 | 2 |
| FR-004 | Consumer can create a profile: business status, name, product category, state, city, PIN code, free-text description; required fields block save | FR-4 | Functional | - | P0 | 2 |
| FR-005 | Consumer can upload a document and label it with a document type | FR-5 | Functional | - | P0 | 2 |
| FR-006 | Consumer can view, replace and delete uploaded documents; replaced or deleted files are no longer retrievable | FR-6 | Functional | - | P0 | 2 |
| FR-007 | Consumer can create a product brief: description, quantity range, target timeline, image or PDF attachments | FR-7 | Functional | - | P0 | 2 |
| FR-008 | Privacy notice is shown and consent recorded (with time) before an account is created | FR-8 | Functional | - | P0 | 2 |
| FR-009 | Consumer can delete their account, removing profile, documents and briefs; share links then stop working | FR-9 | Functional | - | P0 | 2 |
| FR-010 | Admin can create and edit a manufacturer record: name, address, categories, location, contact email, MOQ, certifications, source URL, date collected | FR-10 | Functional | - | P0 | 3 |
| FR-011 | Admin can bulk-import manufacturers from CSV (including required documents) and sees each rejected row with its reason; a malformed file imports nothing | FR-11 | Functional | - | P0 | 3 |
| FR-012 | Admin can add, edit and remove checklist items on a manufacturer, each with a label and optional document type | FR-12 | Functional | - | P0 | 3 |
| FR-013 | Admin can hide or remove a manufacturer; it then appears in no deck. Existing Sent requests stay visible | FR-13 | Functional | - | P0 | 3 |
| FR-014 | Every admin create, edit, import, hide and remove action is written to an append-only audit log with actor and timestamp | FR-14 | Functional | - | P0 | 3 |
| FR-015 | Every manufacturer card and profile shows an "Unverified" label | FR-15 | Functional | - | P0 | 4 |
| FR-016 | Every email to a manufacturer contains a working opt-out link that opens a confirmation page | FR-16 | Functional | - | P0 | 5 |
| FR-017 | After opt-out, the manufacturer receives no further emails and is hidden from all decks | FR-17 | Functional | - | P0 | 5 |
| FR-018 | Deck shows one manufacturer card at a time, swipeable | FR-18 | Functional | - | P0 | 4 |
| FR-019 | Card shows name, location, categories, MOQ and certifications where known, and "meets X of Y requirements"; unknown fields are omitted | FR-19 | Functional | - | P0 | 4 |
| FR-020 | Consumer can filter the deck by category, location and distance radius | FR-20 | Functional | - | P0 | 4 |
| FR-021 | Consumer can filter to manufacturers whose checklist they meet in full (off by default) | FR-21 / A7 | Functional | - | P1 | 4 |
| FR-022 | Full manufacturer profile opens from a card; every checklist item shows met, not met or to confirm | FR-22 | Functional | - | P0 | 4 |
| FR-023 | Left swipe removes the manufacturer from the deck, adds it to Passed and notifies nobody | FR-23 | Functional | - | P0 | 4 |
| FR-024 | Consumer can move a manufacturer from Passed back into the deck | FR-24 | Functional | - | P0 | 4 |
| FR-025 | On-screen buttons perform the same actions as left and right swipes | FR-25 | Functional | - | P0 | 4 |
| FR-026 | Consumer can undo the most recent swipe, unless a request was already sent | FR-26 | Functional | - | P1 | 4 |
| FR-027 | Manufacturers with no valid contact email appear in no deck | FR-27 / A3 | Functional | - | P0 | 4 |
| FR-028 | Right swipe opens a consent screen naming the manufacturer and listing what would be shared; nothing is sent yet | FR-28 | Functional | - | P0 | 5 |
| FR-029 | Consumer can include or exclude each document and the product brief on the consent screen | FR-29 | Functional | - | P0 | 5 |
| FR-030 | No consumer data is shared with a manufacturer until the consumer confirms | FR-30 | Functional | - | P0 | 5 |
| FR-031 | On confirmation, the manufacturer is emailed a profile summary and a link to the consented items | FR-31 | Functional | - | P0 | 5 |
| FR-032 | Share link is read-only, limited to consented items, and expires 30 days after sending | FR-32 / D-14 | Functional | - | P0 | 5 |
| FR-033 | Each consent is recorded with consumer, manufacturer, items shared and timestamp | FR-33 | Functional | - | P0 | 5 |
| FR-034 | Consumer can revoke a sent request; its link then shows no items | FR-34 | Functional | - | P0 | 5 |
| FR-035 | Sent requests list shows status: sent, link opened, delivery failed, revoked | FR-35 | Functional | - | P0 | 5 |
| FR-036 | A request is marked delivery failed when the email bounces or cannot be delivered | FR-36 | Functional | - | P0 | 5 |
| FR-037 | Each consumer is limited to 5 new requests per day | FR-37 / D-14 | Functional | - | P0 | 5 |
| FR-038 | Second request to an already-contacted manufacturer needs a warning and confirmation | FR-38 | Functional | - | P0 | 5 |
| FR-039 | 14 days after sending, the consumer is asked (next time they open the app) whether the manufacturer responded; the answer is stored | FR-39 / D-14 | Functional | - | P1 | 5 |
| FR-040 | Admin sees counts of users, requests, delivery failures, opt-outs, reported responses and connected consumers | FR-40 | Functional | - | P1 | 6 |
| FR-041 | Deferred (P2): manufacturer claims its record and manages details. Do not build. | FR-41 | Functional | - | P2 | none |
| FR-042 | Deferred (P2): verify manufacturer legitimacy. Do not build. | FR-42 | Functional | - | P2 | none |
| FR-043 | Deferred (P2): in-platform messaging. Do not build. | FR-43 | Functional | - | P2 | none |
| FR-044 | Deferred (P2): manufacturer accepts or declines in-platform. Do not build. | FR-44 | Functional | - | P2 | none |
| FR-045 | Deck ordering: category match first, then relevance score = checklist fit 40% + MOQ fit 30% + distance 30%, highest first; weights are configuration | FR-45 / D-20 | Functional | - | P0 | 4 |
| FR-046 | Deck defaults to manufacturers whose categories include the consumer's category; consumer can change the filter | FR-46 | Functional | - | P0 | 4 |
| FR-047 | Left swipe offers an optional one-tap reason that never delays the swipe | FR-47 | Functional | - | P1 | 4 |
| FR-048 | Consumer can record and later change the outcome of each sent request: no response, in contact, deal in discussion, deal closed | FR-48 / D-13 | Functional | - | P0 | 5 |
| FR-049 | Card shows whether the consumer's quantity is at or above the MOQ, or unknown when either is missing | FR-49 | Functional | - | P1 | 4 |
| FR-050 | Manufacturers with no product category or no location appear in no deck | FR-50 | Functional | - | P0 | 3 |
| FR-051 | Each required document in an imported row becomes a checklist item, linked to a known document type when the name matches, else to confirm | FR-51 / A2 | Functional | - | P0 | 3 |
| FR-052 | Public landing page, English and Hindi, explains the product, states it is free, offers Google sign-in; signed-in users go straight to the deck | FR-52 | Functional | - | P0 | 2 |
| NFR-001 | No paid subscription or per-use charge to the owner at launch | NFR-1 / D-11 | Constraint | - | P0 | 1 |
| NFR-002 | Usable layout with no horizontal scroll from 360 px width to desktop | NFR-2 | NFR | Interaction capability | P0 | 2 |
| NFR-003 | Core Web Vitals good at p75 on mid-range Android over 4G: LCP <= 2.5 s, INP <= 200 ms, CLS <= 0.1 | NFR-3 / D-19 | NFR | Performance efficiency | P0 | 6 |
| NFR-004 | All data over TLS; uploaded documents encrypted at rest | NFR-4 | NFR | Security | P0 | 1 |
| NFR-005 | A document is returned only to its owner or to the holder of a valid, unexpired, unrevoked share link covering it | NFR-5 | NFR | Security | P0 | 5 |
| NFR-006 | Share links cannot be guessed or derived from any record ID | NFR-6 | NFR | Security | P0 | 5 |
| NFR-007 | Accept only PDF, JPG, PNG up to 10 MB each, max 25 files per consumer; reject others with a clear message | NFR-7 / D-14 | NFR | Security | P0 | 2 |
| NFR-008 | Limit each consumer to 20 file uploads per hour | NFR-8 / D-14 | NFR | Security | P0 | 2 |
| NFR-009 | At most one email per confirmed request, even if confirm is repeated or retried | NFR-9 | NFR | Reliability | P0 | 5 |
| NFR-010 | Meet the notice, consent, security, retention and deletion duties of India's DPDP Act 2023 and Rules 2025; trace each duty to a requirement or open item before launch | NFR-10 | NFR | Security | P0 | 6 |
| NFR-011 | Keep data while the account is active; delete on account deletion; delete accounts inactive for 12 months | NFR-11 / D-14 | NFR | Security | P0 | 6 |
| NFR-012 | Every English interface string exists in Hindi, falling back to English if missing | NFR-12 | NFR | Interaction capability | P0 | 2 |
| NFR-013 | WCAG 2.1 Level AA on the main flows | NFR-13 / D-19 | NFR | Interaction capability | P0 | 6 |
| NFR-014 | Latest two major versions of Chrome, Safari, Edge, Firefox on desktop; Chrome on Android and Safari on iOS at current and previous major | NFR-14 / D-19 | NFR | Compatibility | P0 | 6 |
| NFR-015 | Application errors and email delivery outcomes are recorded and reviewable by the admin | NFR-15 | NFR | Maintainability | P0 | 1 |
| NFR-016 | Daily backups of database and documents with a restore rehearsed before launch | NFR-16 / D-19 | NFR | Reliability | P0 | 1 |
| NFR-017 | Manufacturer emails are sent from the founder's domain with sender authentication | NFR-17 | NFR | Reliability | P0 | 5 |
| NFR-018 | Moderated pre-launch test: at least 4 of 5 first-time users complete sign-in, profile, a swipe and a confirmed request unaided | NFR-18 / D-19 | NFR | Interaction capability | P0 | 6 |
| NFR-019 | Next card visible within 100 ms of releasing a swipe | NFR-19 / D-19 | NFR | Performance efficiency | P0 | 4 |
| CON-001 | Launch on 2026-12-01; primary success check 2027-03-01 | D-17, D-22 | Constraint | - | P0 | 1 |
| CON-002 | Run at Rs 0 recurring cost; any feature needing a paid service is deferred or disabled, never paid for | D-11, G5, anti-goal 4 | Constraint | - | P0 | 1 |
| CON-003 | India only; English and Hindi only | D-9 | Constraint | - | P0 | 2 |
| CON-004 | No automated scraping; manufacturer data is entered or imported by the admin only | D-16 | Negative | - | P0 | 3 |
| CON-005 | No payments, charging, chat, quotes, sample logistics or contracts in v1 | D-7, D-15 | Negative | - | P0 | 5 |
| CON-006 | The platform does not verify consumer documents or manufacturers; the Unverified label stays | D-3, anti-goal 1 | Negative | - | P0 | 4 |
| CON-007 | Google sign-in only; no email/password and no phone OTP | D-9, D-12 | Negative | - | P0 | 2 |
| CON-008 | Solo, AI-assisted build; P0 scope first; the PRD's cut order stays in reserve (P1 items, then audit log display, then Passed restore, then Hindi on core screens only) | D-22, PRD section 16 | Constraint | - | P0 | 6 |
| CON-009 | Prefer India-region services where a free tier offers one | Founder, BD-05, BD-06 | Constraint | - | P1 | 1 |

---
