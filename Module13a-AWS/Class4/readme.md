

#Athena

table was geting created 

Creating a partitioned tables 



MSCK REPAIR TABLE;

above command scans a file system such as Amazon s3 for hive compaitable partitions



upload the csv file in s3 bucket


above can be taken care in AWS crawler in AWS glue, to create a metadata 



todo: read data from s3 and dump into redshift

glue crawler checks if there is any changes are in the table , if there are then glue job runs and uplod to redshift



### AWS Redshift
it is a dataware housing service (apache hive build on top of hadoop, snowflake entrprice level datahousing service , bigquery is also datawarehousing service)
Redshift follows the MPP: massive prallel processing


difference of different warehouse is at time of system design, their the understing of archicture and their core capability becomes the main facot to take desision to select the warehouse


Redshift architectre



