import json
from math_ops import *

def lambda_handler(event, context):
    
    
    print("Event Data -> ", event)
    print("Trigger Received !!!")

    print("Square of a number = ", square(5))
    print("Sum of two numbers = ", sum(5,4))
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Bye Bye !!')
    }