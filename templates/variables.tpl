        % for table in tables:
        "${table}": {
            "outbox_path": "events/${schema}/${table}"
        },
        % endfor
