Service : EC2, AWS RDS : transectional database service on AWS , 
Aetha : serverless database service in AWS 
redshift 

EMR cluster : to elastic mapreduce, to run spark , it is basically a managed hadoop cluster 

EC2: it is a comidity hardware, we are not going to frequently use it as a dataengineer 
but need to know because : whatever distributed computaion , or infrastructure we need, even redshift or glue or EMR, these are clusers and underground comidity hardware is EC2


in free teir we gets : EC2: in 12 month , their are different types of instances from small to big

Create a new instance and use the free tier instance 
create a key pair 

when creates a new EC2 instance it creates vpc, virtual private cloud (virtual network dedicated to your AWS account), 

in this private network we can define the inbound and outbound rules 



now we will ssh into the EC2 instance 



### AWS RDS
service --> RDS--> Databases -->create database 
standard create

Engine options=MySQL

Templates = Free tier

-- this option will not avaialble 
Availability and durability 
Deployment options 


DB-Instance Identifer = mydatabase
Master user name = admin

master password = yuiop12345


public access = yes  (in prduction best practice is to keep in  private netowrk)

VPC security group (firewall) = Create new

New VPC security group name=RDS_secutity_group

keep everything defaul and crate the database 


if not able to connect to the database from the connectors then check
RDS--> databases --> mydatabase--> connectivity & Security--> VPC security groups

also can assess these Security groups from the EC2 conlsoe

select RDS_secutity_group
edit inboud rules 
add rule
TYpe= Mysql, protocal = TCP, Port range = 3306, source = custom (or any),




connect with the vscode/ any other ide using the connector

once db is created 

endpoint(host) = database.ch2uyoay4rg1.us-east-1.rds.amazonaws.com
port = 3306
username=admin
password=yuiop12345
skip the database name
and connect

now create the sql file and execute the queries 



connect with pyton

pip3 install mysql-connector-python

best practices are always do exception handeling while connecting to any database progrmatically , and finally close the curser and connection
```py


import mysql.connector

def connect_and_create_db():
    connection = None
    try:
        connection = mysql.connector.connect(
            host='database.ch2uyoay4rg1.us-east-1.rds.amazonaws.com',
            port=3306,
            user='admin',
            password='yuiop12345'
        )
        if connection.is_connected():
            print("Successfully connected to the RDS instance.")
            
            cursor = connection.cursor()
            
            # Create a new database
            cursor.execute("CREATE DATABASE IF NOT EXISTS TempDB;")
            print("Database created successfully.")
            
            cursor.execute("SHOW DATABASES;")
            print(cursor.fetchall())
            
        else:
            print("Failed to connect to the RDS instance.")
    except mysql.connector.Error as e:
        print(f"Error: {e}")
    finally:
        if connection is not None and connection.is_connected():
            cursor.close()
            connection.close()
            print("Connection closed.")

if __name__ == "__main__":
    connect_and_create_db()

```



Transaction data bases are schema on write (not schema on read) ? what is schema on read/write?






### AWS Athena

RDS don't allow us to create any enternal table 

AWS Athena is a serverless, ineractive query service offered by Amazon Web Service (AWS) that allows users to analyzw data in S# using standard SQL, 


every 

Data catalog is the centrlized metadata store, it is also middle layer b/w query platorm and data



AWS Athena is Schema on Read


Athena vs Spark

Athena: performace can be improved if we use parquet file (comulnar data stroage), 



##### Athena hands on
open S3
create a bucket
bucketname: sales-data-analysis-gds
create folder input and output
uplaod the sales data input folder


revisit: this
uploadig the sales data in the partaion format
create a new folder = partationed_data
inside create a another folder =  country=USA





Amazon Athena --> Query editor --> settings --> Manage --> 
Locaton of query result - Optional: give the output folder locatoin
Assign bucket owner full access = yes

--- using the following to crate the metadata for the table
AWS Glue
Data catalog--> Databases --> add database = sales_db


--> Amazon Athena --> Query editor --> Data source = AwsDataCatalog --> Create table--> S3 bucket

== choose an existing database or crate a new database = choose and existing database = sales_db

Dataset
Location of input data set: give locaoi of s3 bucket
(when we read data from hive/aethana/etc we can have in back end data written in partation format itself)

Data format
Table type=Apache Hive    (athena provide various dataformat, )
file format= Json

SerDe properties= keep default

Column names= provide the column names of the dataset and their datatype

Table properties: 
need to explore these , can provide partaion and all, but for partation in back end that partation should be alread created


even when we setup the hive , we need to setup some metadatastore 
in athena we are using data catalog




now if we are using partiioned run:  

MSCK REPAIR TABLE sales_tb_partitioned; 
this command will add the partioned



Progrmatic access of Athena:
api, boto3 can be used
Create a function in lambda 

crate a new folder in s3 bucket = output_from_lambda


crate a new lambda funciotn: 
runtime = python
confuguraiotn=timeout = 15
premissions = roles
s3 full access and amaznoe athana full access (because labdba is going to use both of them)



```
import boto3
import time
import os

ATHENA_OUTPUT_BUCKET = "s3://sales-data-analysis-gds/output_from_lambda/"  # S3 bucket where Athena will put the results, e.g., "s3://sales-data-analysis-gds/output/"
DATABASE = 'sales_db'  # The name of the databimport boto3
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
ase in Athena
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


```


use case: above be integrated with sns to send notifictoin 

use case is an event driven analysis
when we received the file in s3, it triger the lambda, and then same data is use by athana to do some analysis








CREATE EXTRNAL TABLE IF NOT EXITS new_table_name(

    column
)




Editor--> 
Data sources





In athena if want to do on top of s3 etc. then we set data catalog in aws glue and create database etc. 

but if we want to query redshift from athena in that case we need to have connectoin setting from Connections

Crawlers will come handy if we have changing schema


interview qn:
lambda: 
qns : triger, memory , scalability , concurancy
glue: comprasin from spark, concurrnet execution, infrastructure of glue, how dynamica data frame work in glue, how glue works with crawler, job bookmarking in glue (for incremental refresh)
redshift: is more warehousing, internal and external table,  redshift spectum  ,partationing key concept, clustering key concept, architure of redshift



Fedrated query: will look it when readshift is steuped


in data desigining see how monotring , loging and altering part works 
data quality, vaiadtion, code quatity

design data engineering




---- availability, scalability, fault tolerance, and performance optimization
production-grade hosting of a Relational Database Management System (RDBMS), system design typically focuses on high availability, scalability, fault tolerance, and performance optimization

1. Primary (Master) and Replica (Slave) Architecture:
    Primary is write replica 
    Slave is read replica
    can have shared memory also for both

2. Synchronous vs. Asynchronous Replication:
   
3. Read/Write Separation:
   -- Proxy Layer: In large-scale production systems, a load balancer or a proxy layer (like HAProxy, ProxySQL) is often used to direct read queries to replicas and write queries to the primary database automatically. 

4. Failover Tools: Tools like etcd, Consul, and cloud-native solutions like Amazon RDS, Google Cloud SQL, or Azure Database handle the automatic promotion of replicas and failover operations with minimal downtime