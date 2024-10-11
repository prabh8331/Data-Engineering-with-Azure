sudo apt update
sudo apt install zip

## without depencency 
cd lambda_test/
zip lambda_function.zip lambda_function.py

# list down files in zip
unzip -l lambda_function.zip

# unzip
unzip lambda_test.zip

aws lambda get-function --function-name lambda_test

aws lambda update-function-code \
    --function-name lambda_test \
    --zip-file fileb://lambda_function.zip

## with depencency 
cd lambda_with_dependency/lambda_function/
sudo apt install python3-pip
pip3 install requests -t .

zip -r ../lambda_function.zip .

aws lambda update-function-code --function-name lambda_test --zip-file fileb://lambda_function.zip


## with layer
-- I have made change in above code only (manually in aws console ui, so no need to uplaod code) and added a new library in import, now I want to package this library and then add it in layer

cd lambda_layer/
mkdir pytz_layer
cd pytz_layer
mkdir python

pip3 install pytz -t python/

zip -r pytz_layer.zip python

unzip -l pytz_layer.zip

--- manually from aws console
Lambda--> Layer -->  Create Layer --> name = pytz_layer --> Upload the pytz_layer.zip file --> arch = x86_64 --> runtime = python 3.12 
Lambda--> Functions --> lambda_test --> code --> add layer --> Custom layer --> pytz_layer --> version = 1 

now if we run the code it will run

we can use this lambda layer in multiple lambda functions 
and in one function we can use multiple layer 



-- from cli 

aws lambda publish-layer-version \
    --layer-name pytz_layer2 \
    --description "A layer with the pytz library" \
    --zip-file fileb://pytz_layer.zip \
    --compatible-runtimes python3.12

arn:aws:lambda:ap-south-1:339713016962:layer:pytz_layer2:1

aws lambda update-function-configuration \
    --function-name lambda_test \
    --layers arn:aws:lambda:ap-south-1:339713016962:layer:pytz_layer2:1

aws lambda update-function-configuration \
    --function-name lambda_test \
    --layers arn:aws:lambda:ap-south-1:339713016962:layer:pytz_layer:1 \
    arn:aws:lambda:ap-south-1:339713016962:layer:pytz_layer2:1    


it is easy to add aws defaul layers using ui
Lambda --> add layer --> AWS layer --> aws layer = AWSSDKPandas-Python312 --> version = 13