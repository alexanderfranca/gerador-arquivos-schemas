from datetime import datetime, timedelta

from airflow import DAG
from airflow.models import Variable

from mssql_plugin import MssqlToGcsOutboxOperator
from operators_utils import send_alerts

CONFIG = Variable.get('${schema}', deserialize_json=True)


def create_alerts(context):
    send_alerts(context, 
                pagerduty_integration_key=Variable.get("pagerduty_integration_api_key_dataplatform_team", None), 
                slack_users=CONFIG.get('slack_notification_users',[]))


default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(year=2014, month=1, day=1),
    'retries': 3,
    'retry_delay': timedelta(minutes=10),
    'delay_on_limit_secs': 5,
    'on_failure_callback': create_alerts,
}

dag = DAG(
    dag_id='${dag_id}',
    schedule_interval='0 3 * * *',
    template_searchpath=Variable.get('template_sql_path'),
    default_args=default_args,
    max_active_runs=CONFIG['${max_active_runs}'].get('max_active_runs', 1)
)

${constant} = MssqlToGcsOutboxOperator(
    dag=dag,
    task_id='${task_id}',
    source_sql='${source_sql}',
    source_mssql_conn_id='${conn_id}',
    google_cloud_storage_conn_id=CONFIG.get('gcp_conn_id'),
    gcs_bucket_name=CONFIG.get('gcs_outbox_bucket_name'),
    gcs_path=CONFIG['${gcs_path}'].get('outbox_path'),
    parallel_threads=CONFIG.get('parallelism_level'),
)
