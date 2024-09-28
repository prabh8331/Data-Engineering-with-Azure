import json

def process_sales_order(sales_order):
    print(sales_order)  # Replace with your actual processing logic.

def lambda_handler(event, context):
    # Loop through each message that triggered the lambda function
    print("Starting SQS Batch Process")
    print("Messages received in current batch = ",len(event['Records']))
    for record in event['Records']:
        sales_order = json.loads(record['body'])
        process_sales_order(sales_order)

    print("Ending SQS Batch Process")
    return {
        'statusCode': 200,
        'body': json.dumps('Processed sales orders from SQS!')
    }
