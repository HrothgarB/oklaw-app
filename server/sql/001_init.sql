CREATE TABLE titles (
  id SERIAL PRIMARY KEY,
  number INT NOT NULL,
  name TEXT NOT NULL
);
CREATE UNIQUE INDEX idx_titles_number ON titles(number);

CREATE TABLE statutes (
  id BIGSERIAL PRIMARY KEY,
  title_id INT NOT NULL REFERENCES titles(id) ON DELETE CASCADE,
  section_number TEXT NOT NULL,
  heading TEXT,
  text TEXT NOT NULL,
  effective_date DATE,
  repealed BOOLEAN DEFAULT FALSE,
  source_url TEXT,
  last_seen_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_statutes_title_section ON statutes(title_id, section_number);

CREATE TABLE statute_keywords (
  statute_id BIGINT REFERENCES statutes(id) ON DELETE CASCADE,
  keyword TEXT NOT NULL
);
CREATE INDEX idx_statute_keywords ON statute_keywords(keyword);

CREATE TABLE cases (
  id BIGSERIAL PRIMARY KEY,
  court TEXT NOT NULL,
  docket TEXT,
  citation TEXT,
  decision_date DATE,
  title TEXT NOT NULL,
  summary TEXT,
  text TEXT NOT NULL,
  source_url TEXT,
  last_seen_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_cases_decision_date ON cases(decision_date);

CREATE TABLE case_citations (
  case_id BIGINT REFERENCES cases(id) ON DELETE CASCADE,
  cite TEXT NOT NULL
);

CREATE TABLE links_statute_case (
  statute_id BIGINT REFERENCES statutes(id) ON DELETE CASCADE,
  case_id BIGINT REFERENCES cases(id) ON DELETE CASCADE,
  relation TEXT
);
