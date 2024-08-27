# Data Engineering 3.0 with Azure
 
Pre-Read Material-

Python

Linux

Docker Fundamentals & Installation- 
https://www.youtube.com/watch?v=jPdIRX6q4jA&list=PLy7NrYWoggjzfAHlUusx2wuDwfCrmJYcs


Github fundamentals:
https://youtu.be/8JJ101D3knE

Quick setting up:

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



MySQL workbench setup windows- 
https://youtu.be/8JJ101D3knE



basic DSA is required from Leetcode


incremental data refresh in snowflacks and databricks