{
    "definitions": {},
    "$schema": "http://json-schema.org/draft-07/schema#",
    "$id": "http://example.com/root.json",
    "type": "object",
    "title": "${table_snake}",
    "projectInfo": {
      "tribe": "investigations",
      "squad": "dataplatform_treated",
      "project": "${schema}",
      "event": "${table_snake}"
    },
    "partition": "dataplatform_execution_date",
    "description": "${table_snake}",
    "required": [],
    "properties": {
    % for column in columns:
      "${column['name']}": {
        "$id": "#/properties/${column['name']}",
        "title": "${column['name']}",
        "type": [ "${column['data_type_json']}", "null" ]
        % if column['datetime'] == 1:
        ,"format": "date-time"
        % endif
      },
    % endfor
        "dataplatform_execution_date": {
            "$id": "#/properties/dataplatform_execution_date",
            "title": "time we are running the ingestion method",
            "type": [
                "string",
                "null"
            ],
            "format": "date-time"
        },
        "dataplatform_extraction_date": {
            "$id": "#/properties/dataplatform_extraction_date",
            "title": "Reference date beeing used by the ingestion method to find events",
            "type": [
                "string",
                "null"
            ],
            "format": "date-time"
        }
    }
}
