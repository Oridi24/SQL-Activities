SELECT 
    detail.calls_ivr_id,
    detail.calls_phone_number,
    detail.calls_ivr_result,
    detail.calls_vdn_label,
    detail.calls_start_date,
    detail.calls_end_date,
    detail.calls_total_duration,
    detail.calls_customer_segment,
    detail.calls_ivr_language,
    CASE 
        WHEN COUNT(steps.step_name) > 0 AND MAX(steps.step_result) = 'OK' THEN 1
        ELSE 0
    END AS info_by_dni_lg
FROM keepcoding.ivr_detail AS detail
LEFT JOIN keepcoding.ivr_steps AS steps
    ON detail.calls_ivr_id = steps.ivr_id
    AND steps.step_name = 'CUSTOMERINFOBYDNI.TX'
GROUP BY 
    detail.calls_ivr_id, 
    detail.calls_phone_number, 
    detail.calls_ivr_result, 
    detail.calls_vdn_label, 
    detail.calls_start_date, 
    detail.calls_end_date, 
    detail.calls_total_duration, 
    detail.calls_customer_segment, 
    detail.calls_ivr_language;