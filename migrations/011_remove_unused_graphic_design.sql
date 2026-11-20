-- Retirar Diseño Gráfico cuando carece de vínculos académicos.
DELETE FROM subjects AS subject
USING careers AS career
WHERE subject.career_id = career.id
  AND upper(trim(career.name)) IN ('DISEÑO GRÁFICO', 'DISEÑO GRAFICO', 'DISENO GRAFICO')
  AND NOT EXISTS (SELECT 1 FROM offerings WHERE subject_id = subject.id)
  AND NOT EXISTS (SELECT 1 FROM academic_groups WHERE subject_id = subject.id)
  AND NOT EXISTS (SELECT 1 FROM subject_series WHERE subject_id = subject.id);

DELETE FROM careers AS career
WHERE upper(trim(career.name)) IN ('DISEÑO GRÁFICO', 'DISEÑO GRAFICO', 'DISENO GRAFICO')
  AND NOT EXISTS (SELECT 1 FROM subjects WHERE career_id = career.id)
  AND NOT EXISTS (SELECT 1 FROM students WHERE career_id = career.id)
  AND NOT EXISTS (SELECT 1 FROM study_plans WHERE career_id = career.id);
