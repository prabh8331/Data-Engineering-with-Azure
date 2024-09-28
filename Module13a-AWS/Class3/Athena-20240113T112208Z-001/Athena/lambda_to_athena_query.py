import boto3
import time
import os

ATHENA_OUTPUT_BUCKET = "s3://sales-data-analysis-gds/output_from_lambda/"  # S3 bucket where Athena will put the results, e.g., "s3://sales-data-analysis-gds/output/"
DATABASE = 'sales_db'  # The name of the database in Athena
QUERY = 'SELECT year_id, count(*) as total_orders FROM sales_order_data group by year_id'  # The SQL query you want to execute

def lambda_handler(event, context):
    client = boto3.client('athena')
    
    # Start the Athena query execution
    response = client.start_query_execution(
        QueryString=QUERY,
        QueryExecutionContext={
            'Database': DATABASE
        },
        ResultConfiguration={
            'OutputLocation': ATHENA_OUTPUT_BUCKET
        }
    )
    print(response)

    query_execution_id = response['QueryExecutionId']
    
    while True:
        response = client.get_query_execution(QueryExecutionId=query_execution_id)
        state = response['QueryExecution']['Status']['State']
        
        if state in ['SUCCEEDED', 'FAILED', 'CANCELLED']:
            break
        
        time.sleep(5)  # Poll every 5 seconds
    
    # Here, you can handle the response as per your requirement
    if state == 'SUCCEEDED':
        # Fetch the results if necessary
        result_data = client.get_query_results(QueryExecutionId=query_execution_id)
        print(result_data)
        return {
            'statusCode': 200,
            'body': result_data
        }
    else:
        return {
            'statusCode': 400,
            'body': f"Query {state}"
        }
