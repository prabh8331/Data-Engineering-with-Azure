import json

def lambda_handler(event, context):
    # TODO implement
    print("Event Data -->",event)
    print("Trigger Received !!!")
    a=2
    b=3
    print("sum of a and b= " a+b)

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

