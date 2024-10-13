

1. s3_to_lambda_read


create new lambda, 
author from scratch 
function name =  s3_to_lambda_read
runtime = python 3.11

Increasing the timeout of lambda from 3 sec to 1 mins because reading file will take time
Configuration ---> General configuration --> Timeout = 1 min

code ---> add layer = 
AWS layers
AWS layer = Pandas


now because we are reading the data from s3 using lambda funciton we need to provide the premssions using role
Configuration ---> Premissions --> role name (click the link)
Attach premission--> Attach Policy--> AmazoneS3FullAccess--> 




create a new bucket , buket name = s3-to-lambda-read
connect above with the event notificatioin from s3 bucket 

add event notification in s3 buckets = Properties --> event notificaiton 
Event name = s3-to-lambda-read
suffix = .csv
Event type = all object create events
Destination= Lambda function  = s3-to-lambda-read



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

now finaly upload the .csv file, 
Lambda --> Moniter --> View cloudwatch logs = here see the logs 


https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html



ojective completed from above 2 things 1. how boto3 works , and 2. how to read different attributes of events








need to revisit the following again: 

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
--> Basic     (/ if select advance need to chnage add the arn of s3 bucket -- this need some research)
    publisher = everyone
    Suscribers - Only the topic owner

remaining default

click on create subscription and select email, and enter the mail id, now downstream need to accept the subscrition , so go to gmail and accept , the publish message and give subject and body

use case- in one topic we can send order and payment data both, 
but we will crate 2 consumers of lambda, one process only order and one only payment as per the attribute 




### S3 to SNS 

Create a bucket 
in bucket go to properties , then event notification, then create a event notification and keep destination as sns and select above sns

now add a folder to the bucket , now we will be able to get the notificiton on mail, which will be in json format

S3 --> SNS --> Email



# Lambda to SNS

S3 --> Lambda --> SNS --> mail

add message progrmatically in sns topic 

```py

import boto3
import pandas as pd


s3_client = boto3.client('s3')
sns_client = boto3.client('sns')
sns_arn = 'arn:aws:sns:ap-south-1:566373416292:sns-topic'

def lambda_handler(event, context):
    # TODO implement
    print(event)
    try:
        bucket_name = event["Records"][0]["s3"]["bucket"]["name"]
        s3_file_key = event["Records"][0]["s3"]["object"]["key"]
        print(bucket_name)
        print(s3_file_key)
        resp = s3_client.get_object(Bucket=bucket_name, Key=s3_file_key)
        print(resp['Body'])
        df_s3_data = pd.read_csv(resp['Body'], sep=",")
        print(df_s3_data.head())
        message = "Input S3 File has been processed succesfuly !!"
        respone = sns_client.publish(Subject="SUCCESS - Daily Data Processing",TargetArn=sns_arn, Message=message, MessageStructure='text')
    except Exception as err:
        print(err)
        message = "Input S3 File processing failed !!"
        respone = sns_client.publish(Subject="FAILED - Daily Data Processing", TargetArn=sns_arn, Message=message, MessageStructure='text')
```







### SQS

here first messages are sent to the SQS topic, 
then consumer has to pool these messages in batch , batch length can me 10 etc.



1. from lambda generate messages to SQS, then there is a auto triger to lambda, once SQL recieve the messages it will send it to lambda
   this is automated trigring 

2. from lambda generate messages to SQL, then manually pool from other lamda
    this is manual polling 

suggested way is the second one where we are polling and then deleting the message because we have more contorl in that way





### Event Bridge 

1. Event brigde schedule 
in above sqs, we published 100 msgs, and by manually trigring lambda we read 10 mes
now using event bridge we are creating a reoccuring thing which will triger lambda, in every 1 mins

we will use scheduled event bridge 
do not give flexible time window
give cron synax 

disable once used 


## Event Bridgle pipe

Lambda = print event_bridge_pipe data

pipe hase 

1. Source = SQS
2. FIltering = give filter condition 
3. Enrichment = to change the input after filtering (we can remove it also)
4. Target = lambda 


shutdown the piplines you may chaged




