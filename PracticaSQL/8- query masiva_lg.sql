SELECT 
    detail.calls_ivr_id,
    MAX(
        CASE 
            WHEN modules.module_name = 'AVERIA_MASIVA' THEN 1 
            ELSE 0 
        END
    ) AS masiva_lg
FROM keepcoding.ivr_detail AS detail
LEFT JOIN keepcoding.ivr_modules AS modules
    ON detail.calls_ivr_id = modules.ivr_id
GROUP BY detail.calls_ivr_id
;