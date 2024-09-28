Hadoop is basics of all the distributed computioation 
so before covering any thing advance which is developed using Hadoo it is important to cover hadoop first

## What is BigData

Techinically

big data is a colleciton of data that is huge in volume, yet growing exponentially with time, 
data with so large  traditional data management tools can store it or process it 

trasecioal data base has problem of scallablity 
in big data need to foucs on scallibality, storage,  data losess , parallel compution 



5 V's of BigData
- Volume:  This refers to the sheer quantity of data, which is typically enormous. It can range from terabytes to petabytes and even exabytes of data 

- Velocity: This refers to the speed at which new data is generated and the speed at which data moves around. With the growth of the Internet and smart devices, data is being generated continuously, in real time, from various sources.
    - Real time (Streams) (bank transaciton, social media)
    - Near time (taking some buffer window)
    - Batch (when real time is not needed then use batch) (always have clearcut use case from ) 

- Variety: Structured , Unstructured, semistructured
- Veracity: This refers to the quality of the data, which can vary greatly. Veracity allows us to deal with uncertainty or imprecision, which is often an issue with many forms of big data.Authenticity of data
- Value : This is the ability to turn data into value. This is becoming the most important V of Big Data because it's important that businesses make a return on their investment in big data and data analytics.


Distributed compution

comudity hardware - machine who has ram, cpu etc basically processing powere

cluster - colleciton of comudity hardware

Vertical scaling

Horizontla scaling (eg. micro service)




## Hadoopp 

Hadoop Distributed File System (HDFS)

Hadoop is an open-source software framework for storing and processing big data in a distributed fashion on large clusters of commodity hardware. Essentially, it accomplishes two tasks: massive data storage and faster processing.


1. need infrastructre  : cluster 
2. stored data in distributed manner : Map- reduce
3. prallel processing 

YARN: to manage resources: manage memory, cpu

local file systme do not support distibuted file system 




Hadoop Architecture 
Layer 1: Storage Layer (HDFS)
Layer 2: Resource Management Layer (YARN)
Layer 3: Appliction Layer e.g. MapReduce , Spark, etc. 

Spark can use Yarn and HDFS, and spark only have processing capability no storeage 



Properties of Hadoop 
Hadoop only support batch processing and no realtime processing 

Scalability
COst- effectiveness
flexibility
Fault Tolerance 
Data Locality 
Simplicity 
Open-source


Hadoop CLuster: 
: master slave archicture 

Master (Name Node - Resource Manager)

Slave 
Data Node - Node Manager - Map Reduce


Key terminologies and Componests of HDFS

HDFS file system logically look at data split it and store in multiple system

>hdfs -put src_file destinaiton 



