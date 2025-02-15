-- query
SELECT 
 ivr_id AS calls_ivr_id, 
CASE 
        WHEN vdn_label LIKE 'ATC%' THEN 'FRONT'
        WHEN vdn_label LIKE 'TECH%' THEN 'TECH'
        WHEN vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
END AS vdn_aggregation
FROM ivr_calls
;

-- almacenar la clasificación en vdn_aggregation de tabla ivr_detail
UPDATE keepcoding.ivr_detail AS detail
SET vdn_aggregation = 
    CASE 
        WHEN detail.calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
        WHEN detail.calls_vdn_label LIKE 'TECH%' THEN 'TECH'
        WHEN detail.calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END
;