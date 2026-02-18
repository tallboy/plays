# Examples: Idea Refinement

**Back to:** [Idea Refinement](../../../skills/define/idea-refinement.md)

---

## Example 1: Vague Request → Clear Requirements

**Before:**
> "We need better search."

**After Idea Refinement:**

```markdown
# Refined Requirements: Improve Product Search

## Initial Request
"We need better search." - Product Manager

## 5 Ws

**WHO:** All users (authenticated and anonymous)

**WHAT:** Full-text search across product names, descriptions, and categories

**WHEN:** Triggered by typing in header search box (debounced after 300ms)

**WHERE:** Search bar in global header, results in dropdown overlay

**WHY:** 40% of support tickets are "I can't find X product"

## Problem Statement
Users can't find products efficiently, leading to lost sales and support burden. Current search only matches exact product names.

## Success Criteria
1. Search returns results within 200ms for 95th percentile
2. Results ranked by relevance (exact match > partial match > category match)
3. Shows top 5 results in dropdown, "See all results" link for more
4. Handles typos with fuzzy matching (Levenshtein distance ≤ 2)
5. Works with keyboard navigation (arrow keys, enter to select)

## Assumptions (Validated)
- ✅ Search backend already exists (Elasticsearch), just need UI integration
- ✅ No need for filters in initial version (coming in Phase 2)
- ✅ Mobile and desktop both need search
- ✅ Search history NOT required (privacy concerns)

## Out of Scope
- Advanced filters (price range, brand) - Phase 2
- Search analytics dashboard - Separate project
- Voice search - Future consideration

## Decisions
- Using existing Elasticsearch over building new: Leverage existing investment
- Dropdown vs. dedicated page: Faster for most users, dedicated page for "see all"
- Fuzzy matching on: Benefits outweigh occasional false positives
```

---

## Example 2: Feature Request with Hidden Complexity

**Initial Request:**
> "Add email notifications when user is mentioned."

**Questions Asked:**
1. **WHO** gets notified? (Just the mentioned user, or also their manager?)
2. **WHAT** triggers it? (Any mention, or only in specific contexts?)
3. **WHEN** is email sent? (Immediately, batched hourly, user preference?)
4. **WHERE** can mentions happen? (Comments, tickets, chat, all of above?)
5. **WHY** email vs. in-app notification?

**Refined Scope:**

```markdown
# Refined Requirements: Mention Notifications

## Problem Statement
Users miss important mentions in ticket comments, leading to delayed responses and customer frustration.

## 5 Ws

**WHO:**
- Primary: Mentioned user receives notification
- Secondary: NOT their manager (considered, rejected for privacy)

**WHAT:**
- @username syntax in ticket comments
- Matches existing users only (no team/channel mentions)
- Notification includes: who mentioned them, which ticket, comment excerpt

**WHEN:**
- Email sent immediately when mention is posted
- User can opt out in preferences (default: on)
- No batching in Phase 1 (keeps implementation simple)

**WHERE:**
- Mentions in ticket comments only
- NOT in: chat, wiki pages, commit messages (future consideration)

**WHY:**
- Email chosen over in-app notification: Users don't stay logged in all day
- In-app notification added in Phase 2

## Success Criteria
1. User receives email within 30 seconds of being mentioned
2. Email includes direct link to comment
3. Email is skipped if user has opted out
4. System handles @mentions of non-existent users gracefully (no email)
5. Performance: No noticeable slowdown when posting comments

## Phased Approach

### Phase 1 (This Sprint) - MVP
- Mentions in ticket comments only
- Immediate email notification
- Opt-out option in user preferences

### Phase 2 (Future) - Enhancements
- Mentions in chat
- Batched digest option (daily/weekly)
- In-app notifications

### Explicitly Out of Scope
- @team or @channel mentions (only individual users)
- Manager notifications (privacy concerns)
- Slack/external integrations
- Mention analytics

## Assumptions (Validated)
- ✅ Email service can handle additional load: Confirmed with infra (< 1% increase)
- ✅ Users want email notifications: Survey shows 78% prefer email
- ⚠️ @username syntax familiar to users: Needs user testing in Phase 1
- ❌ Real-time in-app needed immediately: FALSE - Users said email sufficient for now

## Decisions

### Decision 1: Email-first, in-app later
- **Rationale:** Simpler implementation, users already check email
- **Alternatives:** In-app only (users miss notifications), both (complex MVP)
- **Trade-off:** Some delay vs. implementation speed

### Decision 2: No @team mentions in Phase 1
- **Rationale:** Unclear semantics (who's on "team"?), potential for spam
- **Alternatives:** Allow team mentions (complex rules), allow any @text (spam risk)
- **Trade-off:** Limited functionality vs. clear user experience
```

---

## Example 3: Stakeholder Gives Solution, Not Problem

**Initial Request:**
> "Add a refresh button to the dashboard."

**Refinement Session:**

```markdown
# Refinement Session Transcript

Q: What problem are you trying to solve with the refresh button?
A: The data on the dashboard gets stale.

Q: How often does it get stale? What's the impact?
A: It updates every 5 minutes, but users don't know when it last updated. They sometimes make decisions on old data.

Q: What decisions are they making? What's the cost of old data?
A: Sales managers looking at pipeline data. If data is 4 minutes old and they're on a call with exec, they can't give current numbers.

Q: Would showing "Last updated: 2 minutes ago" help?
A: Yes! That would be even better than a refresh button.

Q: What if we also reduced the polling interval from 5 minutes to 1 minute?
A: That would solve 95% of the problem.

# Refined Solution

## Original Request
Add refresh button

## Actual Problem
Users don't know if dashboard data is current, leading to distrust and poor decisions.

## Proposed Solution (Better)
1. Show "Last updated: X minutes ago" timestamp
2. Reduce polling from 5 min → 1 min
3. NO refresh button needed (simpler implementation, less UI clutter)

## Success Criteria
1. Timestamp updates every minute
2. Data never more than 2 minutes old
3. Users report confidence in data currency (survey post-launch)

## Why This Is Better
- Solves root problem (data currency visibility)
- Simpler UI (no button)
- Simpler implementation (just add timestamp, tune polling)
- Better UX (automatic updates vs. manual refresh)
```

**Key Insight:** By digging into the *problem*, we found a better solution than the requested *solution*.

---

## Example 4: Assumptions Surface Technical Constraints

**Initial Request:**
> "Add real-time collaboration to the document editor."

**Refinement Process:**

```markdown
# Refinement: Real-Time Collaboration

## Assumptions Captured

### Initial Assumptions (Before Validation)
1. ⚠️ Real-time means simultaneous editing (like Google Docs)
2. ⚠️ WebSockets infrastructure exists
3. ⚠️ Conflict resolution not needed (last write wins)
4. ⚠️ All users on modern browsers

## Validation Results

### Assumption 1: Real-time means simultaneous editing
- **Validated with:** Product Manager
- **Result:** ❌ FALSE
- **Reality:** "Real-time" means "see changes within 10 seconds"
- **Impact:** Polling is sufficient, no WebSockets needed

### Assumption 2: WebSockets infrastructure exists
- **Validated with:** Infrastructure team
- **Result:** ❌ FALSE
- **Reality:** No WebSocket support, would take 2 sprints to add
- **Impact:** Must use polling approach (lucky assumption 1 was false!)

### Assumption 3: Conflict resolution not needed
- **Validated with:** User research
- **Result:** ❌ FALSE
- **Reality:** Users expect to see who's editing and prevent collisions
- **Impact:** Need edit locking mechanism

### Assumption 4: All users on modern browsers
- **Validated with:** Analytics data
- **Result:** ⚠️ PARTIALLY TRUE
- **Reality:** 5% of users on IE11
- **Impact:** Need polyfill or fallback UI

## Revised Approach

**Original vision:** Google Docs-style collaboration
**Revised scope:** Optimistic locking with 10-second refresh

### Phase 1 (Achievable This Quarter)
- Poll for changes every 10 seconds
- Show "X is editing this document" indicator
- Prevent concurrent edits (lock document when opened)
- Gracefully degrade for IE11 (read-only mode with warning)

### Phase 2 (Future, if WebSockets added)
- True simultaneous editing
- Character-level operational transforms
- Cursor presence indicators
```

**Lesson:** Validating assumptions surfaced technical constraints early, preventing a false start on impossible architecture.

---

Back to [Idea Refinement](../../../skills/define/idea-refinement.md)
