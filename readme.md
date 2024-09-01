# Data Engineering 3.0 with Azure
 
Pre-Read Material-

Python

Linux

Docker Fundamentals & Installation- 
https://www.youtube.com/watch?v=jPdIRX6q4jA&list=PLy7NrYWoggjzfAHlUusx2wuDwfCrmJYcs


Github fundamentals:
https://youtu.be/8JJ101D3knE

Quick setting up:

1. Windows with github and 2. Linux with github
Install git on windows:
https://git-scm.com/

```bash
# open git bash

git config --global user.name "prabh8331"
git config --global user.email "prabh8331@gmail.com"

ssh git and github setup
cd ~/.ssh
ssh-keygen -t ed25519 -C "prabh8331@gmail.com"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat id_ed25519.pub (copy)
go to github>settings>ssh and GPG keys > new ssh key > paste the key

ssh -T git@github.com

```
2. Windows with Linux

```bash


```





MySQL workbench setup windows- 
https://youtu.be/8JJ101D3knE




what interview qns others are getting:

basic DSA is required from Leetcode

incremental data refresh in snowflacks and databricks

SQL-
window's functions
common table expressions
how to create funciotn in SQL
stored proceedures - know the thoury
views
indexing
itterative and recursive (CTE)

kuberneeties are more part of Devops


nosql don't support ACID property
nosql we would want consisitcy 
nosql is best trafic , scalibility, parallel , analytical query


python - pandas, (numpy not required)
DSA (leetcode - 2 qns everyday)
system design is not needed but basic of datapipeline is needed
Scala


tockenization in oracle stream?

How to practice SQL
1. leetcode 
2. search case study in github

Azure fibric

DP203 certificate

after course can cover devops part

data modeling and data warehousing, datalakes, iceberge hudi
kubernities , devops etc.

in interview asking the ETL part, data processing part with respect to databricks 