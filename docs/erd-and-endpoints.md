# OK Law — MVP Data Model & API (Day 1)

## ERD (minimal)
- **titles**: id, number, name
- **statutes**: id, title_id→titles, section_number, heading, text, effective_date, repealed:boolean, source_url, last_seen_at
- **statute_keywords**: statute_id→statutes, keyword
- **cases**: id, court, docket, citation, decision_date, title, summary, text, source_url, last_seen_at
- **case_citations**: case_id→cases, cite
- **links_statute_case**: statute_id→statutes, case_id→cases, relation

## API (MVP)
### Statutes
- GET /api/statutes?title=##&section=##&q=keyword&limit=&offset=
- GET /api/statutes/:id

### Cases
- GET /api/cases?q=keyword&court=&year=&limit=&offset=
- GET /api/cases/:id

### Meta
- GET /health
