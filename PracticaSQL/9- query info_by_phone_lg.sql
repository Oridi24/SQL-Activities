SELECT 
    detail.calls_ivr_id,
    MAX(
        CASE 
            WHEN steps.step_name = 'CUSTOMERINFOBYPHONE.TX' 
                 AND steps.step_result = 'OK' 
            THEN 1 
            ELSE 0 
        END
    ) AS info_by_phone_lg
FROM keepcoding.ivr_detail AS detail
LEFT JOIN keepcoding.ivr_steps AS steps
    ON detail.calls_ivr_id = steps.ivr_id
GROUP BY detail.calls_ivr_id;