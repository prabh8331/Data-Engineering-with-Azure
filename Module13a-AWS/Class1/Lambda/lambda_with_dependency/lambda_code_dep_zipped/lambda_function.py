import json
import requests

def lambda_handler(event, context):
    
    
    # print("Event Data -> ", event)
    # print("Trigger Received !!!")

    # a = 2
    # b = 3

    # print("Sum of a and b = ", a+b)
    
    # # TODO implement
    # return {
    #     'statusCode': 200,
    #     'body': json.dumps('Bye Bye !!')
    # }
    
    print("Event Data -> ", event)
    response = requests.get("https://www.google.com/")
    print(response.text)
    return response.text