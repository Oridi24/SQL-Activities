ALTER TABLE keepcoding.ivr_detail
ADD COLUMN masiva_lg int,
ADD COLUMN info_by_phone_lg int,
ADD COLUMN info_by_dni_lg int,
ADD COLUMN repeated_phone_24H int,
ADD COLUMN cause_recall_phone_24H int
;

CREATE TABLE keepcoding.ivr_summary AS
SELECT 
    calls_ivr_id AS ivr_id,
    calls_phone_number AS phone_number,
    calls_ivr_result AS ivr_result,
    vdn_aggregation,
    calls_start_date AS start_date,
    calls_end_date AS end_date,
    calls_total_duration AS total_duration,
    calls_customer_segment AS customer_segment,
    calls_ivr_language AS ivr_language,
    calls_steps_module AS steps_module,
    calls_module_aggregation AS module_aggregation,
    document_type,
    document_identification,
    customer_phone,
    billing_account_id,
    masiva_lg,
    info_by_phone_lg,
    info_by_dni_lg,
    repeated_phone_24H,
    cause_recall_phone_24H
FROM keepcoding.ivr_detail
;

---- una vez alteramos la tabla detail agregamos las querys relaizadas antes

--- masiva

UPDATE keepcoding.ivr_detail AS d
SET masiva_lg = sub.masiva_lg
FROM (
    SELECT 
        detail.calls_ivr_id,
        CASE 
            WHEN COUNT(modules.module_name) > 0 THEN 1
            ELSE 0
        END AS masiva_lg
    FROM keepcoding.ivr_detail AS detail
    LEFT JOIN keepcoding.ivr_modules AS modules
        ON detail.calls_ivr_id = modules.ivr_id
        AND modules.module_name = 'AVERIA_MASIVA'
    GROUP BY detail.calls_ivr_id
) AS sub
WHERE d.calls_ivr_id = sub.calls_ivr_id
;

--- info_by_dni

UPDATE keepcoding.ivr_detail AS d
SET info_by_dni_lg = sub.info_by_dni_lg
FROM (
    SELECT 
        detail.calls_ivr_id,
        CASE 
            WHEN COUNT(steps.step_name) > 0 
                 AND MAX(steps.step_result) = 'OK' THEN 1
            ELSE 0
        END AS info_by_dni_lg
    FROM keepcoding.ivr_detail AS detail
    LEFT JOIN keepcoding.ivr_steps AS steps
        ON detail.calls_ivr_id = steps.ivr_id
        AND steps.step_name = 'CUSTOMERINFOBYDNI.TX'
    GROUP BY detail.calls_ivr_id
) AS sub
WHERE d.calls_ivr_id = sub.calls_ivr_id
;

--- repeated phone

UPDATE keepcoding.ivr_detail AS a
SET repeated_phone_24H = sub.repeated_phone_24H,
    cause_recall_phone_24H = sub.cause_recall_phone_24H
FROM (
    SELECT 
        a.calls_ivr_id,
        a.calls_phone_number,
        a.calls_start_date,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM keepcoding.ivr_detail b
                WHERE b.calls_phone_number = a.calls_phone_number
                  AND b.calls_ivr_id <> a.calls_ivr_id
                  AND b.calls_start_date BETWEEN a.calls_start_date - INTERVAL '24 HOURS' AND a.calls_start_date
            ) THEN 1
            ELSE 0
        END AS repeated_phone_24H,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM keepcoding.ivr_detail c
                WHERE c.calls_phone_number = a.calls_phone_number
                  AND c.calls_ivr_id <> a.calls_ivr_id
                  AND c.calls_start_date BETWEEN a.calls_start_date AND a.calls_start_date + INTERVAL '24 HOURS'
            ) THEN 1
            ELSE 0
        END AS cause_recall_phone_24H
    FROM keepcoding.ivr_detail AS a
) AS sub
WHERE a.calls_ivr_id = sub.calls_ivr_id
;