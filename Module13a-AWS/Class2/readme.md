

1. s3_to_lambda_read


create new lambda, 
author from scratch 
function name =  s3_to_lambda_read
runtime = python 3.11

configuraiton = timeout = 1 min


connect above with the event notificatioin from s3 bucket 

add triger = s3 bucket 
event type = crate 


now we will add the files to the s3 bucket then read that file using panda and print content of it
we will use boto to point the csv file

to read the file using panda need it depencenty, which we will do from layer  

```py

import boto3
import pandas as pd
from io import StringIO

def lambda_handler(event, context):
    print(event)
    # Get the S3 bucket and object key from the Lambda event trigger
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    # Use boto3 to get the CSV file from S3
    s3_client = boto3.client('s3')
    response = s3_client.get_object(Bucket=bucket, Key=key)
    file_content = response["Body"].read().decode('utf-8')

    # Read the content using pandas
    data = pd.read_csv(StringIO(file_content))
    print(data)

```
https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html




now because we are reading the data from s3 using lambda funciton we need to provide the premssions using role

ojective completed from above 2 things 1. how boto3 works , and 2. how to read different attributes of events

this is how we can make things event driven 






### SNS

it is messaging Q

it is a push based service 

Amazon Simple Notification Service (Amazon SNS) is a fully managed messaging service provided by AWS. It is designed for distributing notifications to a wide range of recipients. With SNS, you can send messages to individual recipients or to large numbers of recipients

send a message to an SNS topic, and then that single message can be delivered to many recipients 
across various supported protocols.

Multiple Protocols: SNS supports multiple protocols, meaning you can deliver messages to:
○ HTTP/HTTPS endpoints
○ Email/Email-JSON
○ Short Message Service (SMS)
○ Application (for sending messages to other AWS services or to applications)
○ AWS Lambda
○ Simple Queue Service (SQS)
○ Application Endpoints (for mobile devices)

Hands on

1. sending mail using sns

SNS --> Topics --> Create topic 

Type --> Standard 
name --> first_sns

Access policy
--> Basic     (/ if select advance need to chnage add the arn of s3 bucket)
    publisher = everyone
    Suscribers - Only the topic owner

remaining default

click on create subscription and select email, and enter the mail id, now downstream need to accept the subscrition , so go to gmail and accept , the publish message and give subject and body

use case- in one topic we can send order and payment data both, 
but we will crate 2 consumers of lambda, one process only order and one only payment as per the attribute 




### S3 to SNS 

