import json

def lambda_handler(event, context):
    
    
    print("Event Data -> ", event)
    print("Trigger Received !!!")

    a = 2
    b = 3

    print("Sum of a and b = ", a+b)
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Bye Bye !!')
    }