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
FROM keepcoding.ivr_detail a
;