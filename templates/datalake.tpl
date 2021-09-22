    % for table in tables:
    {
      table_name         = "${table}",
      partitioned_column = "dataplatform_execution_date",
      ingestion_flows    = ["batch-loader"],
    },
    % endfor
