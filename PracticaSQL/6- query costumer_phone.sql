SELECT 
    ivr_id AS calls_ivr_id,
    MAX(CASE WHEN step_name = 'CUSTOMER_PHONE' THEN step_result END) AS customer_phone
FROM ivr_steps
WHERE step_name = 'CUSTOMER_PHONE'
GROUP BY ivr_id;