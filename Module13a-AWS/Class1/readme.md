# AWS 

Why data pipelines on cloud are cheaper than on-prem solution?
1. Infrastructure Costs: Cloud platforms eliminate the need to invest in physical hardware, reducing both upfrot capital expense and ongoing maintenance costs
2. Scalability: 
3. Operational Efficiency: 
4. Resource Utilization:
5. Reduced Overhead: 
6. Flexibility
7. Innovation Pace:
8. Disaster Recovery & Redundancy

Most commonly used AWS Services to build data pipelines
S#
Lambda
IAM
EVENT BRIDGE
EC2
SNS
SQS
STEP Functions 
GLUE
KINESIS
RDS
ATHENA
REDSHIFT
DynamoDB

AWS EMR (managed hadoop cluster)


## AWS S3: 

Object Storage: S3 is an object storage service, meaning it is designed to store unstuctured data
Durablilty and Availability 
Scalability
Data Organization 
Versioning
Security 
Event Configuration

AWS S3 Pricing Factors 
Storage
Requests
Data Transfer
Additional Features
Storage Management


S3 command with AWS CLI (configure the aws cli)

Getting started with AWS S3

Services --> S3 --> Left Hand side bar --> Buckets --> create bucket --> give bucket name and keep everything default (can add tags env dev)

install cli
```BASH
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


aws --version
```

once S3 bucket is crated go to CLI

```bash
aws s3 ls


```
creating data-engineer1 user
Setting up the user
Services --> IAM --> Users --> Create user --> 
1. Specify user details --> User name -> data-engieer1    (as console login is not enabled this user will not be able to access aws ui)
2. Set permissions --> Add user to group 
    a. Create group --> data-engineer-admin-group
        search s3 --> AmazonS3FullAccess
3. Review and create --> add tag-- team: data-engineers
Create user

Services --> IAM --> Users --> data-engineer1 --> Security credentials --> Create access key --> select CLI --> Download .csv file

login into ubuntu server
```bash
aws configure
# enter access key and secret access key



# some aws commands

# List all buckets 
aws s3 ls

# List files inside the bucket
aws s3 ls s3://noob2-temp

aws s3 ls s3://noob2-temp/Input_data/

# Copy a local file to a bucket.
aws s3 cp localfile.txt s3://my-bucket-name/
# Copy a file from a bucket to the local system.
aws s3 cp s3://my-bucket-name/file.txt localfile.txt
# Move a local file to a bucket (removes the local file after copying).
aws s3 mv localfile.txt s3://my-bucket-name/ 
# Delete a file from a bucket.
aws s3 rm s3://my-bucket-name/file.txt

```

to setup the connicitivity b/w 2 services or service with user there should be proper role and policy should be attached 

in company usually there is a dedicated devops team who give access


Create folder in S3 bucket 

Amazon s3 --> Buckers --> noob2-temp 

1. Objects --> create folder --> Input_data

2. Properties --> Amazon Resource Name (ARN): every service we create or instance of that service in order to work with it programticly, in order to cummunicate with it, it is this unique identifer of that instance 

this is arn for bucket i created : arn:aws:s3:::noob2-temp

3. Properties ---> Event notifications

upload file 
go inside the Input_data folder, upload file, select file from system (store_data.csv), upload

each folder / file in s3 is object 

select store_data.csv
properties--> here will find keys


## AWS Lambda


AWS Lambda is a serverless computing service that lets you run code without provisioning or managing servers. It automatically scales your application by running code in response to events, such as changes to data in Amazon S3 buckets or updates in an Amazon DynamoDB table.


this is computing servcie, here we pay for compute, we don't have to setup any envrionment that is taken care of already, and this need come trigring point (event driven) to execute this code 



when user signup and enter detail then, when click submit buttun , pack all info/data enterd by user in json format (or protobuf etc) and will send as a payload to backend server, and then injust data to database this injectoin of data will need to run some code, this compute can be handled by lambda

Lambda can scale 
in case multple user try to signup then 2 instance of injecton code / 2 threads will deal with 2 incoming requests 

Stateless: By default, AWS Lambda is stateless, meaning each function execution is independent. If you need to maintain 
state, you would use an external service, like Amazon RDS or DynamoDB


can ceate event driven data pipelines using lambda capture event 


Hands on 

--- create a lambda funciton
services --> Lambda --> Functions --> Create function
1. Author from scratch
2. Function name : sample_lambda
3. Runtime : Python 3.11
4. Architecture: x86_64

Premissions 
By default, Lambda will create an execution role with permissions to upload logs to Amazon CloudWatch Logs. You can customize this default role later when adding triggers.

5. Create a new role with basic Lambda permissions 
    as Lambda is AWS service and if it want to access some other service or performe with other service it needs premission which we will give from IAM roles 

---- create one dummy test event which will trigger this lambda function
Code --> Test --> Configure test event --> Create new event --> event name (dumy_trigger_event) --> event sharing setting = private --> Template = hello world --> update the json file

--> make change to the code 

```py
import json

def lambda_handler(event, context):
    # TODO implement
    print(event)
    print("Hello")
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }

```
--> Deploy
--> test 

Monitor --> View CloudWatch logs --> Log groups --> Log streams --> click the different group to check the logs


----- create event trigger for above lambda group when any change happens to the S3 bucket - noob2-temp
Amazon S3 --> Bucket --> noob2-temp --> Event notifications --> Create event notification --> 
--> event name = Capture S3 bucket changes --> (for not Prefix and Suffix empty) --> 
--> Event type --> select = All object create events aand all object removal event
--> Destination --> Lambda funtion --> choose "lambda_test" --> Save changes

---- select lambda_test
now in digram it will show in trigger S3 bucket is showing 

-- for testing create one folder and delete that folder in bucket
--> s3 --> bucket --> noob2-temp --> create folder --> "test_lambda" 
--> cloud watch --> Lops --> Logs Groups --> /aws/lambda/lambda_test --> select the top log
now delete above folder and observe cloud watch

---- control event notification to by adding prefix and Suffix
edit above event and add prefix = Input_data/
Suffix = .csv


once created we need some thing to triger this event 
1. dummy triger --> give the json inut --> click test to run the lambda funciton
2. use s3 bucket event notificaiton, this will have on what event nofitifcation to generate and then destinaiton of the event which will be lambda
3. can control s3 bucket notification as per the prefix and sufix, in case we wnat to send notifianton to lambda only when a perticular type of file is uploaded to perticuler folder


if coded in local environment and want to deploy to aws without login in into the conlose
```py
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

```


```
sudo apt update
sudo apt install zip


cd lambda_test/
zip lambda_function.zip lambda_function.py
```

uplaod this code --> 

Lambda --> Funcitons --> lambda_test --> Code --> upload from --> .zip file


--> contolling the lambda deploy from cmd
provide lambda premission to group data-engineer-admin-group (data-egineer1 is part of this group)
--> IAM --> User group --> data-engineer-admin-group --> premissions --> add premmision -> atach policy --> 
AWSLambda_FullAccess --> Attach policy



```bash
aws lambda get-function --function-name lambda_test

aws lambda update-function-code \
    --function-name lambda_test \
    --zip-file fileb://lambda_function.zip

```


Doubt 1--> S3 bucket = noo2-temp and lambda = Lambda_test are 2 servics and both need premissions to access by defining role, so when i added Event notification in S3 and gave destination to lambda_test how this worked?

```
aws lambda get-function --function-name lambda_test

in output
 "Role": "arn:aws:iam::339713016962:role/service-role/lambda_test-role-apm2q7qm"

aws iam list-attached-role-policies --role-name lambda_test-role-apm2q7qm



S3 Buckets: Access is managed via bucket policies and ACLs, not directly through IAM roles
so by defalult any lambda can access any S3 bucket

```


by default lambda_function.py is created and has def lambda_handler(event, context), and this is a basically a handler function, but in case we want to change the handler funciton and we have created some other file like main.py then this should have a function which should have event and context input paramter 

in Runtime setting --> Handler = main.handler_funciton_name (by default it will be = lambda_funciton.lambda_handler)

above was the code without any depencency 


Now code with depenceny 
e.g. lets try to import requests
but lambda uses the base python image and it don't have any librieris 

we need to package our code with all the depencency 

how to package depencency for lambda code




if someone want to regularly use some common packages from lambda e.g. pandas, numpy etc. in that case we use layer in lambda
we don't need to package it every time


making of layer 

`math_ops.py
```py
def square(n):
    return n**2

def sum(n):
    return n+n
```

zip above 

Lambda --> Layers --> create layer --> Name = math ops library --> upload --> compatable runtime (python diff versions)

this layer can be used in multiple lambda funcitons by different users 

we can add multiple layers 









-- docker qns 


deploy the from docker --> cloud build ??
when we create a docekr image from git we use cloud build
when ever we create image from git, there i have put a docker file
we create a cloud build aml file, in argument
-f docker_file_name 

use case of lambda--> 
lambda is short live with one thred, not ment for paralled computing, so it can not deal with procssing of big data in s3 , it should be used for event driven task, which don't need high computing 
because lambda will have 15 mins cutoff and after that it will be killed 


-- auto scaling in spark
for the auto scalling in spark, in clould we need to tell when designing the infra, that how many max verical caling you would need for the worker node so spark will auto scale as per the need 

