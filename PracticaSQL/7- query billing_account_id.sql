SELECT 
    ivr_id AS calls_ivr_id,
    COUNT(CASE WHEN step_name = 'BILLING_ACCOUNT_ID' THEN step_result END) AS billing_account_id
FROM ivr_steps
WHERE step_name = 'BILLING_ACCOUNT_ID'
GROUP BY calls_ivr_id;

--- Relacionada con tabla detail

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
    COUNT(CASE WHEN steps.step_name = 'BILLING_ACCOUNT_ID' THEN steps.step_result END) AS billing_account_id
FROM ivr_detail AS detail
LEFT JOIN ivr_steps AS steps
ON detail.calls_ivr_id = steps.ivr_id
WHERE steps.step_name = 'BILLING_ACCOUNT_ID'
GROUP BY detail.calls_ivr_id, detail.calls_phone_number, detail.calls_ivr_result, 
         detail.calls_vdn_label, detail.calls_start_date, detail.calls_end_date, 
         detail.calls_total_duration, detail.calls_customer_segment, detail.calls_ivr_language;