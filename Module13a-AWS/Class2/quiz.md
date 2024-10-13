1. **Which of the following AWS services is a managed message queue service?**  
   - **Answer**: SQS

2. **Which service is best suited for sending one-to-many notifications?**  
   - **Answer**: SNS

3. **How does Lambda integrate with SQS?**  
   - **Answer**: SQS can trigger a Lambda function.

4. **What is a visibility timeout in SQS?**  
   - **Answer**: The time a message remains hidden in the queue after being read.

5. **Which AWS service allows for the decoupling of microservices, distributed systems, and serverless applications?**    -- what does decopling mean here? 
   - **Answer**: SQS

6. **In SNS, what do you create to send the same message to multiple subscribers?**  
   - **Answer**: Topic

7. **What are Lambda Layers primarily used for?**  
   - **Answer**: Sharing common code and libraries

8. **If you want to trigger a Lambda function directly from an SQS message, what should you set up?**  
   - **Answer**: SQS event source

9. **How many times will AWS Lambda attempt to process a batch of messages from an SQS queue by default?**  
   - **Answer**: Thrice

10. **In SNS, what is the format for sending messages for a particular protocol?**  
    - **Answer**: Message structure

11. **Which AWS service supports FIFO (First-In-First-Out) delivery?**  
    - **Answer**: SQS

12. **Which of the following services can be a subscriber to an SNS topic?**  
    - **Answer**: check this from AWS console

13. **Lambda Layers can be shared across:**  
    - **Answer**: Both a) and b) (Multiple AWS accounts, Multiple AWS regions)

14. **An SQS message can be up to:**  
    - **Answer**: 256 KB

15. **Which statement about SNS is true?**  
    - **Answer**: Can deliver messages to AWS Lambda

16. **Which type of SQS queue guarantees the order of messages?**  
    - **Answer**: FIFO Queue

17. **Which service is best suited for direct point-to-point communication?**  
    - **Answer**: SQS

18. **What's a primary use case for Lambda Layers?**  
    - **Answer**: Sharing libraries and other function dependencies

19. **Which of the following is NOT an SNS endpoint type?**  
    - **Answer**: DynamoDB (endpoint are : SMS, HTTPS, Email-JSON)

20. **In which scenario would you use long polling with SQS?**  
    - **Answer**: To get messages as soon as they're available