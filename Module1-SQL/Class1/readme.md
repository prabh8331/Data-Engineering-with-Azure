# SQL

SQL is important for data engineering
SQL: Structured Query Language

Database: it is the colleciotn of data in sturctured form

As a dataengineer this is the core skill, so see the aspect of working wtih multple types of databases and know the scaliabaliy asspects of them

Types of Databased
    1. Transactional database
        - MySQL
        - Postgres
        - Oracle
        - MSSQL
    2. NoSQL Database
        - MongoDB
        - Cassandra
        - Elastic Search
        - Syclla DB
        - Neo4j

deciding part that this database is good for our archicture will be decided by CAP Theorum
NoSQL are horizantal scalible (adding more machines)- when increassing the capicity of large cluster by adding more machines
NoSQL are distuibureted
They give the parrallel computing


Knowing this database is important so that we can tell why we are going to use it

What is Transactoinal Databases
    - Vertically Scalable (when increasing the capacity of single machine)
    - ACID properties
        - A (Atomicity): Each query/action will be brokendown as atomic transaction which will have a complete lifecycle
        - C (Consistency)
        - I (Isolaton)
        - D (Durability)
    - Use case: Where data consistency is the primary factor
    - Faster Read/Write operation
    - Not used for heavy data analytical queries: will not give performace for heavy load and complex joins
        - this is bacause the why data is stored (i.e. Row Format)
    - Row Format


2. Data Consistency and atomicity: 

When written any query to the transactional database it is broken into atomic level of transacitions and each transaciton has compete life cycle 

e.g. there are 2 bank account A ($500) and B($600), and query is send 200 from A to B: 
Transacitons: 
    1. Deduct 200 from A
    2. Update Value of A to 300
    3. Add 200 to account B
    4. Update value of B to 800
    5. commit these changes

when ever a transaction is getting proffomed database will be in consistenct state after the completion of transaction either success or failuer there will not be any intermidate state, example if in above example after deduct from A if something break then it will rollback to orgnal value i.e. 500 it will be never like that A is 300 and B still 600, this is called data consistency

Operation on database:
    - Insert
    - update
    - delete

commit: 
rollback: 

there are only two outcomes of transactions- 
success 
or fail

WAL (Write Ahead Logs) are temporory change and will be makeing final change when commit will be done


Tranasacitonal database is come in use case when this type of stict consistency is needed e.g. banking systems, live ticket booking, or where everything is happening and there is no data descripency 


3. Isolation 
    
Each transaction runs independently without knowing about other
it helps in locking system 

example 1- 

A = 300

there are two concurrnet oppertion 
Transaciton 1: time 10:00:20 AM - Read the value of A : output will be 300
Transaciton 2: time 10:00:30 AM - Write the value of A (add 200) : output will be 500


example 3-

Concept of locking : when concurrent updates are happening then system will lock the value of A once 1 operation is happened then it will move to the next tranacition 

A = 300 

Transaciton 1: time 10:00:15 AM - Write the value of A = A + 200
Transaciton 2: time 10:00:17 AM - Write the value of A = A + 100

4. Durability 

Changes wll be kept in WAL untill commited or roll backed, It will be kept in volatile memory, hence helpful in recovery in case of crash



1:09:29
DBMS- > Database Managment system
these are softwae application which helps to store and manipulate the data

RDBMS- Relation database management system
software applicaitons which helps to store data and manipulate datasets will may have realtions with each other, and stored data in structured form