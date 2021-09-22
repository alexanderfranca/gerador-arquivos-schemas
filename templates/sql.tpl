SELECT
    % for column in columns:
    ,${column['name']}
    % endfor
    ,CONVERT(VARCHAR, GETUTCDATE(), 126) AS dataplatform_execution_date 
    ,CONVERT(VARCHAR(60), '{{ts}}', 126) AS dataplatform_extraction_date    
FROM
    [${catalog}].[${schema_orig}].[${table}]
