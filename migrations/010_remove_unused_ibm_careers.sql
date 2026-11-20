-- Retirar del catálogo las carreras que IBM no ofrece, conservando el historial.
DELETE FROM subjects AS subject
USING careers AS career
WHERE subject.career_id = career.id
  AND upper(trim(career.name)) IN (
    'ELECTRÓNICA',
    'DISEÑO Y PRODUCCIÓN DE AUDIOVISUALES - GUIONIZACIÓN'
  )
  AND NOT EXISTS (SELECT 1 FROM offerings WHERE subject_id = subject.id)
  AND NOT EXISTS (SELECT 1 FROM academic_groups WHERE subject_id = subject.id)
  AND NOT EXISTS (SELECT 1 FROM subject_series WHERE subject_id = subject.id);

DELETE FROM careers AS career
WHERE upper(trim(career.name)) IN (
    'ELECTRÓNICA',
    'DISEÑO Y PRODUCCIÓN DE AUDIOVISUALES - GUIONIZACIÓN'
  )
  AND NOT EXISTS (SELECT 1 FROM subjects WHERE career_id = career.id)
  AND NOT EXISTS (SELECT 1 FROM students WHERE career_id = career.id)
  AND NOT EXISTS (SELECT 1 FROM study_plans WHERE career_id = career.id);
