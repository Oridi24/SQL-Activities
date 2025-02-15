-- Crear la tabla ivr_detail en el dataset keepcoding
CREATE TABLE keepcoding.ivr_detail (
    calls_ivr_id varchar, 
    calls_phone_number varchar, 
    calls_ivr_result varchar, 
    calls_vdn_label varchar, 
    calls_start_date TIMESTAMP, 
    calls_start_date_id INT,  -- Formato YYYYMMDD
    calls_end_date TIMESTAMP, 
    calls_end_date_id INT,  -- Formato YYYYMMDD
    calls_total_duration INT,  -- Duración total en segundos
    calls_customer_segment varchar, 
    calls_ivr_language varchar, 
    
    calls_steps_module varchar, 
    calls_module_aggregation varchar, 
    module_sequence INT, 
    module_name varchar, 
    module_duration INT, 
    module_result varchar, 
    
    step_sequence INT, 
    step_name varchar, 
    step_result varchar, 
    step_description_error varchar, 
    
    document_type varchar, 
    document_identification varchar, 
    customer_phone varchar, 
    billing_account_id varchar
);