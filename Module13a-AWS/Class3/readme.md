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


DB-Instance Identifer = database-1
Master user name = admin

master password = yuiop12345


public access = yes  (in prduction best practice is to keep in  private netowrk)

VPC security group (firewall) = Create new

keep everything defaul and crate the database 






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