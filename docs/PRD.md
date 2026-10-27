# PRD: Manufacturer Matchmaking Platform (working title)

**Status:** v4 (self-audit passed; all interview questions closed; ready for engineering handoff) | **Depth:** Full | **Date:** 2026-10-25
**Author / owner:** Founder (solo)
**Launch date:** 1 December 2026 | **Primary success check:** 1 March 2027

**Changes in v4:**
- Schedule confirmed realistic by the founder, who will use AI-assisted development (D-22).
- Pilot categories and the 30-manufacturers-per-category target confirmed as achievable (D-20).
- First consumers will come from organic cold outreach (D-21). Added a public landing page (FR-52) so outreach has somewhere to send people.
- Founder reports legal advice received with no issues (Q4 closed; A10).
- No open questions remain; the suggested cut order is kept in reserve (section 16).

**Changes in v3:**
- Launch date fixed at 1 Dec 2026; primary target now has a window: 10 to 15 connected consumers within 3 months of launch (D-17).
- Manufacturer data is collected manually, not scraped (D-5, D-16). Required documents arrive in the CSV import with each manufacturer (FR-11, FR-51).
- The product is free for all users at launch (D-15).
- Quality priorities set: design, UI, UX, latency and speed (D-18), with numeric targets proposed (D-19, NFR-2, NFR-3, NFR-13, NFR-14, NFR-18, NFR-19).
- Matching weights and pilot categories proposed (D-20); relevance ordering text updated (FR-45).
- FR-48 (outcome recording) promoted to P0, because it is how the primary goal is measured.
- Assumptions A1 to A3 confirmed; A2 refined.

## 1. Overview
A mobile-first website, for India only, where first-time founders ("consumers") find manufacturers that fit their product and that they qualify for. A consumer builds one profile with their requirements and compliance documents. They then browse manufacturers as a swipeable deck, ordered by how well each fits: swipe left to hide one, swipe right to send an introduction. On a right swipe the consumer explicitly consents to which documents and product details are shared, and the manufacturer is notified by email. The platform stores and forwards documents but does not verify them. The manufacturer database is built by hand by the founder. Version 1 is an introduction service only: no chat, quotes, samples workflow or payments, and it is free for everyone. It launches on 1 December 2026, is built and run by one person at zero recurring cost, and aims to connect 10 to 15 consumers with manufacturers within three months, whether or not a deal results.

## 2. Product Type
**Type:** web app (two-sided marketplace, mobile-first responsive, with a small admin area)

**Checks that do not apply**
- Offline sync and binary size: always-online website, no installed app.
- Multi-tenancy: one shared marketplace, not isolated customer tenants. Per-resource authorization still applies (NFR-5).
- Payments and card-data compliance: no payments, and no charges to anyone, in v1 (D-7, D-15).
- In-app messaging infrastructure: out of scope in v1 (D-7); contact is by email notification.
- Phone and SMS verification: removed with OTP sign-in (D-12).
- SEO for logged-in pages: only the public landing page needs to be indexable (Assumption A5).

## 3. Problem and Evidence
- **Problem:** A first-time founder who wants a product manufactured does not know which factories exist, which would accept their order, or what documents each demands. Finding and approaching manufacturers is slow, scattered and discouraging.
- **Evidence:**
  - The founder states this is "really hard" for first-time founders. *Medium strength: first-hand claim, no interviews yet.*
  - Public Indian D2C founder guides describe the same manual process: write a one-page spec sheet, work through directories such as IndiaMART, check certifications such as FSSAI, GMP and ISO, and worry about MOQs, samples and quality control. *Medium: corroborates the pain, not the solution.*
  - Existing alternatives found in searches: IndiaMART (a search directory; one source notes orders cannot be placed on it), Zetwerk (a managed marketplace aimed at OEM and EPC industrial orders), and niche RFQ directories (Finding MFG, Enggpro). No swipe-style, readiness-matched product aimed at first-time founders surfaced. *Low: searches were not exhaustive, so absence is not proof.*
- **Existing work:** None provided. No prototype or code to read.
- **Job to be done:** When I have a product idea and no manufacturer contacts, I want to find manufacturers I actually qualify for and approach them with my documents ready, so that I can get my product made without months of cold outreach.

## 4. Goals and Objectives
| Goal | Measure | Target |
|---|---|---|
| G1 Make approaching manufacturers fast and easy | Time from first sign-in to first request sent; unaided completion in usability test (NFR-18) | No time target at launch; set after pilot data |
| G2 Build a usable supply side | Manufacturer records that appear in decks (FR-27, FR-50) | At least 30 per pilot category at launch (proposed, D-20) |
| G3 Connect consumers with manufacturers (primary goal) | Consumers who report being in contact with a manufacturer through the platform (FR-48), whether or not a deal results | At least 10 to 15 consumers within 3 months of launch, i.e. by 1 Mar 2027 (D-13, D-17) |
| G4 Match well | Share of sent requests that get a response; distribution of pass reasons (FR-47) | No target at launch; set after the first 4 weeks of pilot data |
| G5 Run at zero cost | Recurring spend on infrastructure and services | Rs 0 per month (stated by founder) |
| G6 Treat manufacturers and consumers fairly | Time to honor a manufacturer opt-out or removal request | Within 2 business days (proposed default, D-14) |
| G7 Feel fast and well designed | Core Web Vitals and usability test (NFR-3, NFR-18, NFR-19) | "Good" Core Web Vitals ratings; 4 of 5 test users unaided (proposed, D-19) |

## 5. Scope
**In scope (initial release)**
- Google sign-in only (D-9)
- English and Hindi interface
- Consumer profile, document uploads with type labels, and a product brief
- Admin-managed manufacturer database, entered by hand or by CSV import that includes each manufacturer's required documents
- Swipe deck ordered by relevance, with consumer-controlled filters (category, location, radius)
- Consent screen, email notification to the manufacturer, expiring read-only link to consented items
- Passed list (with optional pass reasons), Sent requests list with outcome tracking, request limits, manufacturer opt-out
- Admin audit log
- Public landing page in English and Hindi, with Google sign-in
- Free to use for everyone

**Explicitly out of scope**
- Phone OTP and email-and-password sign-in (D-12)
- Automated scraping of manufacturer data (D-16)
- Platform verification of consumer documents (D-3)
- Manufacturer self-onboarding and legitimacy verification (deferred until traction, D-5; recorded as P2)
- In-platform chat, quotes, order management, physical sample logistics, payments, contracts, quality inspection (D-7)
- Charging consumers or manufacturers (D-15)
- Mutual-match mechanics where the manufacturer must also swipe (D-2)
- Design files in editing formats such as CAD, PSD or AI; designs must be exported as PDF or image (A9)
- Countries other than India; languages other than English and Hindi
- Native mobile apps

## 6. Anti-Goals
1. **Not a verified marketplace in v1.** The platform will not vouch for documents or manufacturers. Trade-off accepted: consumers see an "Unverified" label and must do their own due diligence.
2. **Not a transaction platform in v1.** No money, chat or contracts pass through it. Trade-off accepted: no revenue and no visibility into what happens after the introduction, so success is measured by asking users (FR-39, FR-48).
3. **Not dating-style social software.** Swiping is a triage tool. Manufacturers never see who passed on them.
4. **Not spending money.** Any feature that needs a paid service is deferred or disabled rather than paid for (NFR-1).
5. **Not maximizing the volume of introductions.** Derived from the founder's stated failure condition, poor matching. Trade-off accepted: a default category filter, relevance ordering and a daily request cap reduce raw volume to protect match quality and manufacturers' goodwill.

## 7. Users / Target Audience
### Consumer (first-time founder or small brand)
- Either a registered business (with GST and similar) or an idea-stage individual with nothing registered yet.
- Any product industry; not technical about manufacturing; mostly on a phone; reads English or Hindi; has a Google account.
- Needs: find fitting manufacturers, know what each requires, show their documents once rather than repeatedly.
- Today: searches directories, cold-calls and emails, learns each manufacturer's requirements one by one.

### Manufacturer (passive recipient in v1)
- A factory or contract manufacturer whose business details and email the founder found by hand from sources the founder believes permit this use (A10). Most have not joined the platform.
- Receives an email with a consumer's profile summary and a link to the consented items. Can opt out.
- Later (P2): claims its profile, sets its own checklist, and is verified.

### Admin (the founder)
- Enters and imports manufacturer records with their required documents, handles removal and opt-out requests, watches basic counts and match-quality signals.

## 8. Functional Requirements
IDs are permanent. New requirements take the next number; withdrawn ones are marked `Withdrawn`, never renumbered.

| ID | Requirement | Priority | Acceptance |
|---|---|---|---|
| FR-1 | The system shall let a visitor sign up and sign in with a Google account. | P0 | AC-FR-1 |
| FR-2 | **Withdrawn.** Phone OTP sign-in removed: a paid per-message service conflicts with the zero-cost constraint (D-12). | n/a | n/a |
| FR-3 | The system shall let a user choose English or Hindi and show all user-facing text in the chosen language. | P0 | AC-FR-3 |
| FR-4 | The system shall let a consumer create a profile containing business status (registered business or idea-stage individual), name, product category, location (state, city, PIN code) and a text description of what they want made. | P0 | AC-FR-4 |
| FR-5 | The system shall let a consumer upload a document and label it with a document type. | P0 | AC-FR-5 |
| FR-6 | The system shall let a consumer view, replace and delete their uploaded documents. | P0 | AC-FR-6 |
| FR-7 | The system shall let a consumer create a product brief containing a description, quantity range, target timeline and attached images or design files exported as PDF or image. | P0 | AC-FR-7 |
| FR-8 | The system shall show a privacy notice and record the user's consent to data processing before an account is created. | P0 | AC-FR-8 |
| FR-9 | The system shall let a consumer delete their account, which also deletes their profile, documents and briefs. | P0 | AC-FR-9 |
| FR-10 | The system shall let an admin create and edit a manufacturer record containing name, address, product categories, location, contact email, minimum order quantity, certifications, source URL and date collected. | P0 | AC-FR-10 |
| FR-11 | The system shall let an admin bulk-import manufacturer records from a CSV file whose columns include name, address, contact email, product categories, minimum order quantity, certifications and required documents, and report each rejected row with its reason. | P0 | AC-FR-11 |
| FR-12 | The system shall let an admin add, edit and remove checklist items on a manufacturer record by hand, each with a label and an optional document type. | P0 | AC-FR-12 |
| FR-13 | The system shall let an admin remove or hide a manufacturer record, after which it no longer appears in any consumer's deck. | P0 | AC-FR-13 |
| FR-14 | The system shall write every admin create, edit, import, hide and remove action to an audit log with the actor and timestamp. | P0 | AC-FR-14 |
| FR-15 | The system shall label every manufacturer in the consumer interface as "Unverified". | P0 | AC-FR-15 |
| FR-16 | The system shall include a working opt-out link in every email sent to a manufacturer. | P0 | AC-FR-16 |
| FR-17 | The system shall, after a manufacturer opts out, send it no further emails and hide it from all decks. | P0 | AC-FR-17 |
| FR-18 | The system shall present manufacturers to the consumer one card at a time as a swipeable deck. | P0 | AC-FR-18 |
| FR-19 | The system shall show on each card the manufacturer's name, location, product categories, minimum order quantity and certifications where known, and a count of the form "meets X of Y requirements". | P0 | AC-FR-19 |
| FR-20 | The system shall let the consumer filter the deck by product category, location and distance radius. | P0 | AC-FR-20 |
| FR-21 | The system shall let the consumer filter the deck to manufacturers whose checklist the consumer currently meets in full. | P1 | AC-FR-21 |
| FR-22 | The system shall let the consumer open a full manufacturer profile from a card, showing every checklist item marked "met", "not met" or "to confirm". | P0 | AC-FR-22 |
| FR-23 | The system shall, on a left swipe, remove the manufacturer from the consumer's deck, add it to the consumer's Passed list and send the manufacturer no notification. | P0 | AC-FR-23 |
| FR-24 | The system shall let the consumer move a manufacturer from the Passed list back into the deck. | P0 | AC-FR-24 |
| FR-25 | The system shall provide on-screen buttons that perform the same actions as swiping left and right. | P0 | AC-FR-25 |
| FR-26 | The system shall let the consumer undo their most recent swipe. | P1 | AC-FR-26 |
| FR-27 | The system shall exclude from all decks any manufacturer that has no valid contact email. | P0 | AC-FR-27 |
| FR-28 | The system shall, on a right swipe, open a consent screen naming the manufacturer and listing the profile fields, documents and product brief that would be shared, and shall send nothing at that point. | P0 | AC-FR-28 |
| FR-29 | The system shall let the consumer include or exclude each document and the product brief individually on the consent screen. | P0 | AC-FR-29 |
| FR-30 | The system shall share no consumer data with a manufacturer until the consumer confirms on the consent screen. | P0 | AC-FR-30 |
| FR-31 | The system shall, on confirmation, email the manufacturer a profile summary and a link to the consented items. | P0 | AC-FR-31 |
| FR-32 | The system shall make the link read-only, limited to the consented items, and expire it 30 days after sending (proposed default, D-14). | P0 | AC-FR-32 |
| FR-33 | The system shall record each consent with the consumer, manufacturer, items shared and timestamp. | P0 | AC-FR-33 |
| FR-34 | The system shall let the consumer revoke a sent request, after which its link shows no items. | P0 | AC-FR-34 |
| FR-35 | The system shall show the consumer a Sent requests list with each request's status ("sent", "link opened", "delivery failed", "revoked"). | P0 | AC-FR-35 |
| FR-36 | The system shall mark a request "delivery failed" when the email bounces or cannot be delivered. | P0 | AC-FR-36 |
| FR-37 | The system shall limit each consumer to 5 new requests per day (proposed default, D-14). | P0 | AC-FR-37 |
| FR-38 | The system shall warn the consumer and require confirmation before sending a second request to a manufacturer they have already contacted. | P0 | AC-FR-38 |
| FR-39 | The system shall, 14 days after a request is sent (proposed default, D-14), ask the consumer whether the manufacturer responded and record the answer. | P1 | AC-FR-39 |
| FR-40 | The system shall show an admin the counts of users, requests sent, delivery failures, opt-outs, reported responses and connected consumers. | P1 | AC-FR-40 |
| FR-41 | The system shall let a manufacturer claim its record and manage its own details and checklist. | P2 | AC-FR-41 |
| FR-42 | The system shall verify a manufacturer's legitimacy before showing it as verified. | P2 | AC-FR-42 |
| FR-43 | The system shall let a consumer and manufacturer exchange messages inside the platform. | P2 | AC-FR-43 |
| FR-44 | The system shall let a manufacturer accept or decline a request inside the platform. | P2 | AC-FR-44 |
| FR-45 | The system shall order each consumer's deck first by whether the manufacturer's product categories include the consumer's category, then by a relevance score made up of checklist fit (40%), minimum-order-quantity fit (30%) and distance (30%), highest first (proposed weights, D-20). | P0 | AC-FR-45 |
| FR-46 | The system shall, by default, show only manufacturers whose product categories include the consumer's profile category, and shall let the consumer change the category filter. | P0 | AC-FR-46 |
| FR-47 | The system shall, on a left swipe, offer the consumer an optional one-tap reason (wrong category, too far, requirements not met, minimum order too high, other) that can be skipped without delaying the swipe. | P1 | AC-FR-47 |
| FR-48 | The system shall let the consumer record the outcome of each sent request as one of "no response", "in contact", "deal in discussion" or "deal closed", and let them change it later. | P0 | AC-FR-48 |
| FR-49 | The system shall show on each card whether the consumer's stated quantity is at or above the manufacturer's minimum order quantity, or "unknown" when either value is missing. | P1 | AC-FR-49 |
| FR-50 | The system shall exclude from all decks any manufacturer record that has no product category or no location. | P0 | AC-FR-50 |
| FR-51 | The system shall create, for each required document in an imported row, a checklist item linked to a known document type when the name matches one, and left as "to confirm" when it does not. | P0 | AC-FR-51 |
| FR-52 | The system shall show a public landing page, in English and Hindi, that explains the product, states that it is free, and offers Google sign-in. | P0 | AC-FR-52 |

## 9. Non-Functional Requirements
| ID | Requirement | Category | Acceptance |
|---|---|---|---|
| NFR-1 | The system shall run entirely on free-tier or free services, with no paid subscription or per-use charge to the owner at launch. | Cost | AC-NFR-1 |
| NFR-2 | The system shall provide a usable layout, without horizontal scrolling, from a phone width of 360 px up to desktop widths (proposed, D-19). | Responsive | AC-NFR-2 |
| NFR-3 | The system shall achieve "good" Core Web Vitals on a mid-range Android phone over a 4G connection, at the 75th percentile: Largest Contentful Paint at or under 2.5 s, Interaction to Next Paint at or under 200 ms, Cumulative Layout Shift at or under 0.1 (proposed, D-19). | Performance | AC-NFR-3 |
| NFR-4 | The system shall transmit all data over TLS and store uploaded documents encrypted at rest. | Security | AC-NFR-4 |
| NFR-5 | The system shall return a document only to its owner or to a holder of a valid, unexpired, unrevoked share link that covers that document. | Security | AC-NFR-5 |
| NFR-6 | The system shall generate share links that cannot be guessed or derived from any record ID. | Security | AC-NFR-6 |
| NFR-7 | The system shall accept only PDF, JPG and PNG files of up to 10 MB each, and at most 25 files per consumer, and reject all others with a clear message (proposed defaults, D-14). | Security | AC-NFR-7 |
| NFR-8 | The system shall limit each consumer to 20 file uploads per hour (proposed default, D-14). | Abuse | AC-NFR-8 |
| NFR-9 | The system shall send at most one email for a confirmed request, even if the confirm action is repeated or retried. | Idempotency | AC-NFR-9 |
| NFR-10 | The system shall be built to meet the notice, consent, security, retention and deletion duties of India's Digital Personal Data Protection Act, 2023 and Rules, 2025, whose main obligations take effect in mid-May 2027, as confirmed by legal review (Q4). | Privacy | AC-NFR-10 |
| NFR-11 | The system shall keep a consumer's data while the account is active, delete it on account deletion, and delete the data of accounts inactive for 12 months (proposed default, D-14). | Data lifecycle | AC-NFR-11 |
| NFR-12 | The system shall provide every English interface string in Hindi, falling back to English when a translation is missing. | Localization | AC-NFR-12 |
| NFR-13 | The system shall meet WCAG 2.1 Level AA on its main flows (proposed, D-19). | Accessibility | AC-NFR-13 |
| NFR-14 | The system shall support the latest two major versions of Chrome, Safari, Edge and Firefox on desktop, and Chrome on Android and Safari on iOS at the current and previous major versions (proposed, D-19). | Compatibility | AC-NFR-14 |
| NFR-15 | The system shall record application errors and email delivery outcomes so the admin can review them. | Observability | AC-NFR-15 |
| NFR-16 | The system shall take daily backups of the database and uploaded documents, subject to free-tier limits (checked in M0), and a restore shall be rehearsed before launch (proposed, D-19). | Reliability | AC-NFR-16 |
| NFR-17 | The system shall send manufacturer emails from the founder's own domain with sender authentication so they are not rejected as spoofed. | Deliverability | AC-NFR-17 |
| NFR-18 | In a moderated test before launch, at least 4 of 5 first-time users shall complete sign-in, profile, a swipe and a confirmed request without help (proposed, D-19). | Usability | AC-NFR-18 |
| NFR-19 | The system shall show the next card within 100 ms of the consumer releasing a swipe (proposed, D-19). | Performance | AC-NFR-19 |

## 10. User Journeys
### Journey 1: Sign up and build a profile
1. Visitor opens the site on a phone and picks English or Hindi.
2. They accept the privacy notice and sign in with Google.
3. They enter business status, category, location and what they want made.
4. They upload documents and label each (for example GST or FSSAI).
5. They write a short product brief with quantity and timeline, and attach images or PDF designs.

**Failure paths:** Sign-in cancelled, so no account is created. Unsupported or oversized file, so a clear message and the upload is rejected. Upload interrupted, so the user can retry without losing the rest of the profile.

### Journey 2: Browse and swipe
1. Consumer opens the deck. It is already filtered to their category and ordered by relevance; they can change the category, location and radius.
2. They see one card at a time showing "meets X of Y requirements", the quantity fit and the "Unverified" label.
3. They tap a card to read the full checklist, or swipe (or tap a button).
4. A left swipe moves the manufacturer to Passed; they may tap a reason, and can restore it later.

**Failure paths:** No manufacturers match the filters, so an empty state suggests widening the radius or category. Slow connection, so the next card shows a loading state instead of freezing.

### Journey 3: Send an introduction
1. Consumer swipes right. The consent screen lists exactly what will be shared.
2. They untick any document they do not want to share and confirm.
3. The manufacturer is emailed a summary and an expiring link.
4. The request appears in Sent requests; the consumer can revoke it at any time.
5. The consumer records the outcome whenever things change; after 14 days they are also asked whether the manufacturer responded.

**Failure paths:** Daily limit reached, so the consumer is told when they can send again. Duplicate request, so a warning and a confirmation. Email bounces, so the status becomes "delivery failed".

### Journey 4: Manufacturer receives an introduction
1. Manufacturer opens the email and the link, and sees only what the consumer consented to.
2. They contact the consumer directly using the details provided.
3. If they do not want emails, they follow the opt-out link and are not emailed again.

**Failure paths:** Link expired or revoked, so a plain message says access is no longer available.

### Journey 5: Admin builds supply and tunes matching
1. Admin finds manufacturers and their emails by hand, and imports a CSV including each one's required documents; rejected rows are listed with reasons.
2. Admin fixes checklist items that arrived as "to confirm" by linking them to a document type.
3. Admin reviews pass reasons and response rates, and corrects bad category or location data.
4. Admin removes a manufacturer on request; it disappears from decks immediately.

**Failure paths:** Malformed CSV, so nothing partial is silently imported.

## 11. Acceptance Criteria
**AC-FR-1** Given a visitor with no account; When they complete Google sign-in; Then an account exists and they reach profile setup. *Failure:* Given they cancel Google sign-in; Then no account is created.

**AC-FR-3** Given a user on English; When they choose Hindi; Then all user-facing text renders in Hindi and the choice persists across sessions.

**AC-FR-4** Given a signed-in user; When they save the profile with all required fields; Then it is stored. *Failure:* Given a required field is empty; Then saving is blocked and the field is flagged.

**AC-FR-5** Given a consumer; When they upload a permitted file and choose a type; Then it appears in their document list with that type.

**AC-FR-6** Given an uploaded document; When the consumer replaces or deletes it; Then the list updates and the old file is no longer retrievable.

**AC-FR-7** Given a consumer; When they save a product brief with a quantity range and attachments; Then it appears as a selectable item on the consent screen.

**AC-FR-8** Given a new visitor; When they try to sign up without accepting the privacy notice; Then no account is created. Given they accept; Then the consent and its time are stored.

**AC-FR-9** Given a consumer with documents; When they delete their account; Then their profile, documents and briefs are removed and share links stop working.

**AC-FR-10** Given an admin; When they save a manufacturer with all fields; Then it is stored with its source URL and collection date.

**AC-FR-11** Given a CSV with 3 valid rows and 1 invalid row; When the admin imports it; Then 3 records are created, including their address and required documents, and 1 row is reported with its reason.

**AC-FR-12** Given a manufacturer; When the admin adds a checklist item "GST certificate" with document type GST; Then that item shows on the manufacturer's profile. Given the admin removes it; Then it no longer shows.

**AC-FR-13** Given a manufacturer in a consumer's deck; When the admin hides it; Then it no longer appears in that deck on next load. *Edge:* Given a request was already sent, Then the Sent requests entry remains.

**AC-FR-14** Given an admin edits a record; When the audit log is viewed; Then it shows the actor, action and timestamp.

**AC-FR-15** Given any manufacturer card or profile; Then the "Unverified" label is visible.

**AC-FR-16** Given an email sent to a manufacturer; Then it contains an opt-out link that opens a confirmation page.

**AC-FR-17** Given a manufacturer has opted out; When any consumer swipes right on it; Then no email is sent. And it does not appear in decks.

**AC-FR-18** Given matching manufacturers; When the deck opens; Then exactly one card is shown and a swipe reveals the next.

**AC-FR-19** Given a manufacturer with 5 checklist items of which the consumer has matching documents for 3; Then the card shows "meets 3 of 5 requirements". Given a field is unknown, Then it is omitted, not shown as empty.

**AC-FR-20** Given a radius of 50 km around the consumer's location; When the filter is applied; Then no manufacturer outside that radius is shown (radius options TBD).

**AC-FR-21** Given the filter is on; Then only manufacturers where every item is "met" appear.

**AC-FR-22** Given a card; When the consumer opens the full profile; Then every checklist item shows "met", "not met" or "to confirm" (items with no document type show "to confirm").

**AC-FR-23** Given a card; When the consumer swipes left; Then it leaves the deck, appears in Passed, and no email or notification goes to the manufacturer.

**AC-FR-24** Given a manufacturer in Passed; When the consumer restores it; Then it reappears in the deck.

**AC-FR-25** Given a card; When the consumer taps the right button; Then the result equals a right swipe. Same for the left button.

**AC-FR-26** Given a swipe just made; When the consumer taps undo; Then the manufacturer returns to the deck and the Passed list. *Edge:* Given a right swipe was already confirmed and sent, Then undo is not offered; revoke (FR-34) applies instead.

**AC-FR-27** Given a manufacturer record with no contact email; Then it never appears in any deck.

**AC-FR-28** Given a card; When the consumer swipes right; Then the consent screen appears and no email has been sent.

**AC-FR-29** Given the consent screen with 3 documents; When the consumer unticks one; Then only the 2 ticked documents are included.

**AC-FR-30** Given the consent screen is open; When the consumer closes it without confirming; Then nothing is shared and the manufacturer stays in the deck.

**AC-FR-31** Given a confirmed request; Then the manufacturer receives one email with a profile summary and a link.

**AC-FR-32** Given a valid link; When opened; Then only consented items show and none can be edited. Given the link is 31 days old; Then it shows no items.

**AC-FR-33** Given a confirmed request; Then a consent record exists with consumer, manufacturer, items and timestamp.

**AC-FR-34** Given a sent request; When the consumer revokes it; Then opening the link afterward shows no items and the status becomes "revoked".

**AC-FR-35** Given requests in various states; When the consumer opens Sent requests; Then each shows its current status.

**AC-FR-36** Given an email that bounces; Then the request shows "delivery failed" and the consumer is told.

**AC-FR-37** Given a consumer who has sent 5 requests today; When they confirm a sixth; Then it is refused with the time they can try again.

**AC-FR-38** Given a consumer already contacted a manufacturer; When they swipe right on it again; Then a warning appears and the request is sent only after they confirm.

**AC-FR-39** Given a request sent 14 days ago; When the consumer next opens the app; Then they are asked whether the manufacturer responded and the answer is stored. *Edge:* Given they already recorded an outcome, Then they are not asked again.

**AC-FR-40** Given activity in the system; When the admin opens the dashboard; Then counts for users, requests, delivery failures, opt-outs, reported responses and connected consumers are shown.

**AC-FR-41 to AC-FR-44** (P2) Deferred. Scenarios to be written when these move into scope.

**AC-FR-45** Given manufacturer A includes the consumer's category and is 20 km away, and manufacturer B includes it and is 200 km away, all else equal; Then A appears before B. Given manufacturer C does not include the category and is nearby; Then C appears after both A and B. Given two manufacturers in the same category and distance where one has a higher checklist fit; Then the higher-fit one appears first.

**AC-FR-46** Given a consumer whose profile category is "skincare"; When they open the deck without changing filters; Then every card lists "skincare" among its categories. Given they change the category filter; Then the deck updates.

**AC-FR-47** Given a left swipe; When the reason prompt appears and the consumer ignores it; Then the swipe completes and no reason is stored. Given they tap "too far"; Then that reason is stored against the pass.

**AC-FR-48** Given a sent request; When the consumer selects "in contact"; Then the status updates and the consumer counts as connected. Given they later select "deal closed"; Then the status updates again. Given they select "no response"; Then they do not count as connected for that request.

**AC-FR-49** Given a consumer quantity of 300 and a manufacturer minimum of 500; Then the card shows the quantity is below the minimum. Given the manufacturer's minimum is missing; Then the card shows "unknown".

**AC-FR-50** Given a manufacturer record with no category; Then it never appears in any deck. Same for no location.

**AC-FR-51** Given an imported row listing "GST certificate" and "Factory licence", where only GST is a known document type; Then two checklist items are created, GST linked to its type and "Factory licence" marked "to confirm", and the admin is shown the unmatched name.

**AC-FR-52** Given a visitor who is not signed in; When they open the site address; Then they see the landing page in their chosen language with a Google sign-in button. Given they are already signed in; Then they go straight to the deck.

**AC-NFR-1** Given the production setup; When the monthly bill and service plans are reviewed; Then no paid plan or charge exists.

**AC-NFR-2** Given a 360 px wide screen; When each main screen is opened; Then nothing requires horizontal scrolling.

**AC-NFR-3** Given a mid-range Android phone on a 4G profile; When the landing page, deck and profile are measured over real or lab runs; Then LCP is at or under 2.5 s, INP at or under 200 ms and CLS at or under 0.1 at the 75th percentile.

**AC-NFR-4** Given any request to the site; Then it is served over TLS. And stored files are encrypted at rest.

**AC-NFR-5** Given consumer A's document URL; When consumer B or an anonymous visitor requests it; Then access is denied. Given an expired or revoked link; Then access is denied.

**AC-NFR-6** Given two share links; Then neither can be derived from the other or from a record ID.

**AC-NFR-7** Given a 12 MB PDF; When it is uploaded; Then it is rejected with a message. Given a DOCX file; Then it is rejected. Given a consumer with 25 files; When they upload a 26th; Then it is rejected.

**AC-NFR-8** Given a consumer who has uploaded 20 files in the last hour; When they upload another; Then it is refused until the window passes.

**AC-NFR-9** Given a double tap on Confirm; Then exactly one email is sent.

**AC-NFR-10** Given the legal review (Q4) lists obligations; Then each is traced to a requirement or open question before launch.

**AC-NFR-11** Given an account with no activity for 12 months; Then its data is deleted. Given an active account; Then its data is kept.

**AC-NFR-12** Given Hindi is selected; When a string has no Hindi translation; Then the English text is shown, not a blank or a key.

**AC-NFR-13** Given the main flows; When they are audited against WCAG 2.1 AA; Then no failures remain.

**AC-NFR-14** Given each supported browser; When the main flows run; Then they complete.

**AC-NFR-15** Given an application error or bounce; Then it appears in the admin's records.

**AC-NFR-16** Given a daily backup; When a restore is rehearsed before launch; Then data and documents return intact.

**AC-NFR-17** Given a test email sent from the founder's domain to a mailbox provider; Then it passes sender-authentication checks.

**AC-NFR-18** Given 5 first-time users with no instructions; When each tries to sign in, build a profile, swipe and send a request; Then at least 4 complete it without help. *Failure:* Given fewer than 4 succeed; Then launch waits for fixes to the failing steps.

**AC-NFR-19** Given a swipe release; Then the next card is visible within 100 ms.

## 12. Success Metrics
| Metric | Definition | Baseline | Target | Source |
|---|---|---|---|---|
| Connected consumers (primary) | Consumers who report "in contact", "deal in discussion" or "deal closed" on at least one request | 0 (pre-launch) | At least 10 to 15 by 1 Mar 2027 | FR-48 |
| Reported response rate | Requests with an outcome other than "no response" / requests older than 14 days | none | none at launch; set after 4 weeks of data | FR-39, FR-48 |
| Deal progress (tracked, not a target) | Requests reaching "deal in discussion" or "deal closed" / all requests | none | none; the goal counts connections regardless of deals | FR-48 |
| Match quality | Share of cards swiped right; distribution of pass reasons | none | none at launch; reviewed weekly during pilot | FR-47, swipe log |
| Time to first request | Sign-in to first confirmed request | none | none at launch | Event log |
| Usable manufacturer records | Records that pass FR-27 and FR-50 and are not opted out | 0 | At least 30 per pilot category at launch (proposed, D-20) | Admin dashboard |
| Delivery health | Requests with "delivery failed" / total requests | none | none at launch | Email outcomes |
| Opt-out rate | Manufacturers who opted out / manufacturers emailed | none | none at launch | Opt-out log |
| Core Web Vitals | LCP, INP, CLS at the 75th percentile on mobile | none | Good ratings (NFR-3) | Field or lab measurement |
| Recurring spend | Monthly infrastructure and service cost | Rs 0 | Rs 0 | Billing |

## 13. Risks
### Four big risks
- **Value (the founder's stated failure condition):** The founder says this fails if matching is poor and introductions do not convert. This is the main risk. Mitigations in this spec: the deck defaults to the consumer's category and is ordered by relevance (FR-45, FR-46), records missing category or location are excluded (FR-50), quantity-versus-minimum fit is used in ranking and shown on cards (FR-45, FR-49), and pass reasons and outcomes are captured (FR-47, FR-48) so matching can be tuned. A second value risk is acquisition: the founder plans to find the first 10 to 15 consumers organically through cold outreach (D-21), which is slow and untested, and the primary target depends on it. Test: a closed pilot in one or two product categories, reviewing pass reasons and response rates weekly, plus 5 to 10 founder interviews. Evidence so far is only the founder's claim plus public guides.
- **Usability:** The founder prioritizes design, UI and UX. Will founders trust swiping for a high-stakes choice? Mitigation: cards show key facts and a full profile one tap away (FR-19, FR-22). Test: a moderated test with 5 first-time users before launch (NFR-18).
- **Feasibility:** (a) *Schedule:* launch is 1 Dec 2026, about 5 weeks from the date of this PRD, for one person who also has to collect manufacturer data by hand. The founder judges it realistic using AI-assisted development (Q14, closed); that is a judgement not yet tested, so the P0-only launch scope and the suggested cut order in section 16 stay in reserve as a safety net. (b) *Free tiers:* a zero-rupee budget limits choices; phone OTP was removed for this reason, and hosting, database, file storage and email sending may still hit free-tier limits. The founder reports a domain and email are available at no cost (D-11). Spike in M0: confirm free-tier limits for hosting, storage and email volume, and set up sender authentication.
- **Viability and legal:** Scraping is off the table (D-16); the founder collects manufacturer emails by hand from sources the founder believes allow it (A10, not verified by this PRD). Remaining exposure: emailing businesses that never opted in, handling manufacturers' contact data, and holding consumers' business documents. India's DPDP Rules were notified in November 2025; the main obligations on notice, consent, security and retention take effect in mid-May 2027, about 5 months after launch, so building to them now avoids rework. There is no revenue (free for all, D-15), which is fine for the pilot but unresolved long term. Mitigations: provenance recorded (FR-10), opt-out in every email (FR-16, FR-17), consent before sharing (FR-28 to FR-30), legal review before launch (Q4; the founder reports legal advice received with no issues). This is not legal advice.

### Pre-mortem
Assume it failed a year from now. These are hypotheses, not findings.
1. **Matching was poor**, so consumers saw irrelevant factories and left (the founder's own failure condition). Mitigation: FR-45, FR-46, FR-49, FR-50; pass reasons (FR-47) reviewed weekly; a narrow pilot where manufacturer data is good.
2. **Not enough consumers arrived**, so the 10 to 15 target was never reached even though the product worked. Mitigation: the founder's cold outreach (D-21) starts before launch; a public landing page (FR-52) gives outreach a place to send people; the connected-consumer count is reviewed weekly.
3. **Manufacturers ignored the emails**, so introductions never converted into conversations. Mitigation: outcomes measured from launch (FR-48); the daily cap and relevance ordering keep emails targeted; P2 claim flow once traction exists.
4. **A data leak or misuse of shared documents** destroyed trust. Mitigation: NFR-4 to NFR-6, expiring and revocable links, sharing only by consent.
5. **The launch slipped or shipped half-finished** because one person had five weeks. Mitigation: P0-only launch scope, P1 items deferred, suggested cut order held in reserve (Q14).
6. **Free tiers ran out or the service went down** while one person ran everything. Mitigation: NFR-15, NFR-16, the M0 spike.
7. **Complaints or legal notices** over unsolicited emails. Mitigation: legal review, opt-out, removal within 2 business days (Q4).
8. **Stale or wrong manufacturer data** made cards misleading. Mitigation: "Unverified" label, source and date on records, admin edit and remove.

## 14. Timeline
Launch date is fixed by the founder, who confirmed the schedule is realistic (Q14). Milestone dates below were proposed by working backward from it.

| Milestone | Target | Depends on |
|---|---|---|
| M0 Spike: free-tier limits for hosting, storage, email; sender authentication on the founder's domain; manufacturer data collection begins; cold outreach begins | 1 Nov 2026 | none |
| M1 Google sign-in, profile, document upload, language switch | 8 Nov 2026 | M0 |
| M2 Admin tools, CSV import with required documents, checklists | 15 Nov 2026 | M0 |
| M3 Relevance-ordered swipe deck, filters, consent, email, share links, Sent and Passed lists, outcome tracking | 22 Nov 2026 | M1, M2 |
| M4 Hardening: limits, opt-out, audit log, accessibility, backups, usability test with 5 users, at least 30 manufacturers per pilot category loaded | 29 Nov 2026 | M3 |
| **Launch** | **1 Dec 2026** | M4 |
| Primary success check: 10 to 15 connected consumers | 1 Mar 2027 | Launch |
| Review against DPDP obligations before they take effect | before mid-May 2027 | none |
| M5 (after traction) Manufacturer claim, verification, in-platform messaging | TBD | Pilot results |

## 15. Decisions
| # | Decision | Reason | Alternatives rejected |
|---|---|---|---|
| D-1 | Build a mobile-first responsive website that also works on larger screens. | "mobile-first with big screen compatibility as well". | Native apps; desktop-first. |
| D-2 | Swipe is one-sided and by the consumer: right means send an introduction (after consent), left means hide it into a Passed list the consumer can reopen. Manufacturers never see left swipes. | Most manufacturers are not on the platform yet, so a mutual match is impossible. The founder said "works" to this recommendation. | Dating-style mutual match; shortlist-only swipe. |
| D-3 | Each manufacturer defines its own checklist. The platform stores and passes along consumer documents but does not verify them. | "The factory defines the checklist and they only check the documents." | Platform-defined standard checklists; platform verification. |
| D-4 | Documents and brief are shared with a manufacturer only after the consumer's explicit consent, per request. | Founder: "Yes, after explicit consent things go to the manufacturer". | Auto-share on swipe; share everything by default. |
| D-5 | (Amended in v3) Manufacturer data is collected manually by the founder. Self-onboarding and legitimacy verification come after traction. | "Initially it will be manual... once I get traction the manufacturers will onboard and get verified." Later: "I won't scrape I will manually search for manufacturers and their emails". | Automated scraping (see D-16); waiting for manufacturers to sign up first. |
| D-6 | A right swipe notifies the manufacturer through its contact details, even if unclaimed. v1 uses email (A3, confirmed). | Founder: the contact details get notified on a right swipe; A3 "Correct". | Notify only joined manufacturers; SMS or WhatsApp (cost). |
| D-7 | v1 is an introduction only (contact details). No chat, quotes, samples workflow or payments. | Founder: "Initially only contact details". | In-platform chat or ordering in v1. |
| D-8 | The consumer controls filtering (location, radius and similar). | Founder: "Filtering will be within the consumers hand". | Platform-ranked decks that cannot be changed. (Default category filter and relevance ordering are allowed because the consumer can always change the filters; founder accepted them in v3.) |
| D-9 | Sign-in by Google only; interface in English and Hindi; India only. | Founder's answers. | Email and password; phone OTP (see D-12); more languages; other countries. |
| D-10 | Consumers include both registered businesses and idea-stage individuals. | Founder: "Both". | Registered businesses only. |
| D-11 | The product is built by one person at zero recurring cost. The founder already has a domain and email at no cost. | "I am solo... Rs 0, everything will be free." "Yes domain and emails are there for free." | Paid services; hiring. |
| D-12 | Phone OTP sign-in is removed (FR-2 withdrawn). | Founder: "Fine remove OTP, just Google OAuth". OTP is a paid per-message service, which conflicts with D-11. | Keeping OTP as P1; paying for OTP. |
| D-13 | The primary success target is at least 10 to 15 consumers connected with manufacturers through the platform, whether or not a deal results. "Connected" means the consumer reports being in contact (FR-48). Poor matching and unconverted introductions are the stated failure condition. | Founder: "Atleast 10-15 consumers are connected with manufacturers... irrespective whether the deal converts"; "It will fail if the matching... sucks and things are not converted." Founder confirmed the reported-contact definition (Q13: "Yes"). | Measuring success by closed deals or revenue; platform-verified contact. |
| D-14 | Limits and defaults used in this PRD: files PDF, JPG and PNG up to 10 MB each, 25 files per consumer; 20 uploads per hour; 5 requests per day; share links expire after 30 days; outcome prompt after 14 days; data of accounts inactive for 12 months deleted; manufacturer removal or opt-out honored within 2 business days. | The founder answered "Yes" when asked whether Claude should propose these. They are Claude's proposals, not the founder's own numbers, and should be adjusted after the pilot. | Leaving them TBD. |
| D-15 | The product is free for all users, consumers and manufacturers, at launch. Revenue model is left open for later. | Founder: "Free for all currently". | Charging for requests, subscriptions or commissions at launch. |
| D-16 | No automated scraping. Manufacturers and their emails are found and entered by hand from sources the founder believes allow it. | Founder: "I won't scrape I will manually search for manufacturers and their emails which are allowed." | Scraping directories. |
| D-17 | Launch on 1 December 2026. The primary target is checked three months later, on 1 March 2027. | Founder: "Want to launch on 1st of december, 2026"; "within 3 months of launch". | A later launch; an open-ended window. |
| D-18 | The product is optimized for design, UI, UX, latency and speed. | Founder: "optimized for design, ui, ux, latency, speed". | Treating speed and design as later polish. |
| D-19 | Numeric quality targets used in this PRD: 360 px minimum phone width; Core Web Vitals "good" ratings (LCP at or under 2.5 s, INP at or under 200 ms, CLS at or under 0.1, 75th percentile; these thresholds were checked against 2026 sources and are unchanged); next card within 100 ms of a swipe; WCAG 2.1 AA; latest two major browser versions (current and previous on mobile); daily backups with a rehearsed restore; 4 of 5 test users succeed unaided. | Founder set the priorities (D-18) and gave no numbers; they are Claude's proposals using common standards, accepted by the founder's "whatever seems best" delegation. | Leaving them TBD. |
| D-20 | Matching: accept the default category filter and relevance ordering (founder: "Yes I accept it, whatever seems best"). Proposed weights within the category: checklist fit 40%, quantity fit 30%, distance 30%, tuned weekly from pass reasons and response rates. Proposed pilot: one or two product categories, such as cosmetics and personal care and food products, where private-label makers typically hold standard certifications such as FSSAI, GMP and ISO and publish catalogues, so checklist matching is easier to get right; at least 30 usable manufacturers per pilot category at launch. | Weights, pilot categories and the 30-manufacturer floor are Claude's proposals under the founder's delegation, not the founder's own numbers. In v4 the founder confirmed the pilot categories and that 30 usable manufacturers per category is achievable by hand. | Equal weights; a pilot across all industries; launching with a thin deck. |
| D-21 | The first consumers come from organic cold outreach by the founder; no paid acquisition. | Founder: "Organically, I will do cold outreaches"; consistent with D-11. | Paid ads or promotions. |
| D-22 | The 1 December 2026 launch is kept; the founder judges it realistic using AI-assisted development. | Founder: "Yes it is realistic, I will use AI assisted development so things will be quick". | Moving the launch date; cutting scope up front. |

## 16. Open Questions and Assumptions
**Open questions:** none. All interview questions are closed.

**Suggested cut order, held in reserve** (the founder did not change it): if the schedule slips, drop the P1 items first (FR-21, FR-26, FR-40, FR-47, FR-49 display), then the audit log (FR-14), then restore-from-Passed (FR-24), then Hindi only on the core screens.

**Closed questions** (kept for reference)
- Q1: Primary target and window set (D-13, D-17). Secondary metrics have no target at launch (section 12).
- Q2: Free for all at launch; future revenue deliberately left open (D-15).
- Q3: Phone OTP removed (D-12).
- Q5, Q6: Limits, retention and removal time proposed in D-14.
- Q7: "Samples" means a digital product brief with images and designs (FR-7, A9); physical samples are out of scope.
- Q8: Failure condition answered (D-13).
- Q9: Launch date set (D-17).
- Q10: Domain and email available at no cost (D-11); sending limits are checked in M0.
- Q11: Priorities set (D-18); numeric targets proposed (D-19).
- Q12: Ordering and default category filter accepted; weights and pilot proposed (D-20); pilot confirmation in Q15.
- Q13: "Connected" means consumer-reported contact (D-13).
- Q4: Founder reports legal advice received and "all good" (A10). This PRD has not independently checked it.
- Q14: Schedule confirmed realistic by the founder (D-22).
- Q15: Pilot categories and 30 manufacturers per category confirmed achievable (D-20). Regions are not restricted; the radius filter handles location.
- Q16: First consumers via organic cold outreach (D-21).

**Assumptions**
- A1 (confirmed): The "meets X of Y" count is computed by whether the consumer has uploaded a document of the matching type. It is self-declared, never verified. Checklist items with no document type show "to confirm".
- A2 (confirmed and refined): The list of document types comes from the data the founder uploads with each manufacturer (name, address, contact, required documents). Document names that do not match a known type are kept as "to confirm" until the admin links them (FR-51).
- A3 (confirmed): v1 notifies manufacturers by email only. Manufacturers with no email are excluded from decks (FR-27).
- A4: Checklists are free-form items entered or imported by the admin, not a fixed structure per industry.
- A5: Only the landing page needs to be public and indexable.
- A6: Supported browsers are current mainstream browsers on Android and iOS plus desktop (see NFR-14).
- A7: The "meets all requirements" filter (FR-21) is optional and off by default.
- A8: Product categories are a fixed list managed by the admin so that matching on category is exact. The list is not yet defined.
- A9: Designs shared in a brief are exported as PDF or image. Editing formats such as CAD, PSD or AI are not accepted in v1.
- A10: The sources the founder finds manufacturers and emails from permit that use. The founder states they do and reports that legal advice found no issues; this PRD has not independently checked either.

## 17. PRD Quality Self-Audit
**Score:** 92 / 100 (all categories apply; none excluded)

| Category | Score |
|---|---|
| Strategic alignment and value | 18 / 20 |
| Requirements precision | 23 / 25 |
| Technical completeness (web app) | 18 / 20 |
| Risks | 14 / 15 |
| Traceability and acceptance | 19 / 20 |

**Gaps**
- Problem evidence is one founder's claim plus public guides; no interviews or pilot data yet.
- The acquisition plan is organic cold outreach with no stated volume or conversion assumptions, so reaching 10 to 15 connected consumers in 3 months is unproven (D-21).
- The schedule is confirmed by the founder's judgement only; the five-week timeline for one person remains the biggest delivery risk (D-22).
- Many numbers are Claude's proposals accepted by delegation, not founder-chosen: D-14, D-19, D-20 (including the matching weights and the 30-manufacturer floor).
- Legal clearance and source permissions rest on the founder's statements and have not been independently checked (A10).
- Secondary metrics have no targets at launch; they will be set after pilot data.
- P2 requirements (FR-41 to FR-44) have no scenarios yet.
