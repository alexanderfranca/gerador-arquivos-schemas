[
    % for column in columns:
    {
          "name": "${column['name']}",
          "type": "${column['data_type_ddl']}",
          "mode": "NULLABLE",
          "description": "${column['name']}"
    },
    % endfor
    {
          "name": "dataplatform_execution_date",
          "type": "TIMESTAMP",
          "mode": "NULLABLE",
          "description": "time we are running the ingestion method"
    },
    {
          "name": "dataplatform_extraction_date",
          "type": "TIMESTAMP",
          "mode": "NULLABLE",
          "description": "Reference date beeing used by the ingestion method to find events"
    }
]
