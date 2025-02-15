-- Agregar los campos document_type y document_identification a la tabla ivr_detail
ALTER TABLE keepcoding.ivr_detail
ADD COLUMN document_type varchar,
ADD COLUMN document_identification varchar
;
-- Actualizar datos desde ivr_steps
UPDATE keepcoding.ivr_detail AS detail
SET document_type = (
        SELECT step_result 
        FROM keepcoding.ivr_steps AS steps
        WHERE steps.ivr_id = detail.calls_ivr_id 
        AND steps.step_name = 'DOCUMENT_TYPE'
        ORDER BY steps.step_sequence ASC
        LIMIT 1  -- Tomamos el primer documento identificado en la llamada
    ),
    document_identification = (
        SELECT step_result 
        FROM keepcoding.ivr_steps AS steps
        WHERE steps.ivr_id = detail.calls_ivr_id 
        AND steps.step_name = 'DOCUMENT_IDENTIFICATION'
        ORDER BY steps.step_sequence ASC
        LIMIT 1  -- Tomamos el primer documento identificado en la llamada
    );

---query 
SELECT 
    ivr_id AS calls_ivr_id,
    MAX(CASE WHEN step_name = 'DOCUMENT_TYPE' THEN step_result END) AS document_type,
    MAX(CASE WHEN step_name = 'DOCUMENT_IDENTIFICATION' THEN step_result END) AS document_identification
FROM ivr_steps
WHERE step_name IN ('DOCUMENT_TYPE', 'DOCUMENT_IDENTIFICATION')
GROUP BY calls_ivr_id
;