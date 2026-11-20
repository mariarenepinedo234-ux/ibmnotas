CREATE TABLE career_names_by_year (
  career_id INTEGER NOT NULL REFERENCES careers(id) ON DELETE CASCADE,
  effective_year TEXT NOT NULL CHECK (effective_year ~ '^20[0-9]{2}$'),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 160),
  PRIMARY KEY (career_id, effective_year)
);

CREATE FUNCTION career_name_for_year(career integer, original_name text, academic_year text)
RETURNS text LANGUAGE sql STABLE AS $$
  SELECT COALESCE(
    (SELECT name
     FROM career_names_by_year
     WHERE career_id = career
       AND effective_year <= COALESCE(academic_year, to_char(now() AT TIME ZONE 'America/La_Paz', 'YYYY'))
     ORDER BY effective_year DESC
     LIMIT 1),
    original_name
  );
$$;
