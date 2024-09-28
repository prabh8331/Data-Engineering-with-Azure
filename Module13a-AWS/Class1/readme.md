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


Hands on 

services --> Lambda --> Functions --> Create function
1. Author from scratch
2. Function name : sample_lambda
3. Runtime : Python 3.11
4. Architecture: x86_64

Premissions 
By default, Lambda will create an execution role with permissions to upload logs to Amazon CloudWatch Logs. You can customize this default role later when adding triggers.

5. Create a new role with basic Lambda permissions 
    as Lambda is AWS service and if it want to access some other service or performe with other service it needs premission which we will give from IAM roles 


once created we need some thing to triger this event 
1. dummy triger --> give the json inut --> click test to run the lambda funciton
2. use s3 bucket event notificaiton, this will have on what event nofitifcation to generate and then destinaiton of the event which will be lambda
3. can control s3 bucket notification as per the prefix and sufix, in case we wnat to send notifianton to lambda only when a perticular type of file is uploaded to perticuler folder

can ceate event driven data pipelines using lambda

capture event 