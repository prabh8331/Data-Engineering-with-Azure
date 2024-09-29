
**1. What does S3 stand for in AWS?**

- **Correct Answer**: **Simple Storage Service**  
  - **Reasoning**: S3 is short for Amazon Simple Storage Service, designed for scalable object storage.

---

**2. Which AWS service allows you to run code without provisioning or managing servers?**

- **Correct Answer**: **Lambda**  
  - **Reasoning**: AWS Lambda lets you run code without worrying about servers, scaling, or infrastructure management. You only pay for execution time.

---

**3. Which consistency model does S3 follow after a successful write of a new object?**

- **Correct Answer**: **Read-after-write Consistency**  
  - **Reasoning**: For new objects, S3 provides read-after-write consistency, meaning you can immediately retrieve the object after it’s written.

---

**4. What is the default storage class in S3?**

- **Correct Answer**: **STANDARD**  
  - **Reasoning**: S3's default storage class is STANDARD, which is designed for frequently accessed data with low latency.

---

**5. Which AWS service is used to monitor AWS Lambda?**

- **Correct Answer**: **CloudWatch**  
  - **Reasoning**: Amazon CloudWatch is used to monitor and log AWS Lambda invocations, errors, and performance metrics.

---

**6. How are Lambda functions priced?**

- **Correct Answer**: **Per 100ms of execution**  
  - **Reasoning**: AWS Lambda charges based on the number of requests and the duration, measured in 100ms increments.

---

**7. What is the maximum execution time for an AWS Lambda function?**

- **Correct Answer**: **15 minutes**  
  - **Reasoning**: The maximum timeout for an AWS Lambda function is 15 minutes per invocation.

---

**8. Which of the following can be a trigger for Lambda?**

- **Correct Answer**: **S3 bucket notification**  
  - **Reasoning**: Lambda can be triggered by S3 bucket events such as object uploads, enabling serverless workflows in response to file changes in S3.

---

**9. In S3, what is a pre-signed URL?**

- **Correct Answer**: **A URL that gives temporary access to a private object**  
  - **Reasoning**: A pre-signed URL provides temporary access to private objects in S3, useful for controlled access without changing bucket permissions.

---

**10. Which S3 feature allows automatic object expiration?**

- **Correct Answer**: **Object Lifecycle Policies**  
  - **Reasoning**: Lifecycle policies in S3 allow you to set rules for automatic object expiration or transition to cheaper storage classes.

---

**11. Which is NOT a valid Lambda runtime?**

- **Correct Answer**: **PHP**  
  - **Reasoning**: AWS Lambda supports many runtimes like Python, Ruby, and Go, but PHP is not one of the officially supported runtimes.

---

**12. How many S3 bucket names can be globally unique?**

- **Correct Answer**: **Only 1**  
  - **Reasoning**: S3 bucket names must be globally unique across all AWS accounts.

---

**13. Which AWS service can be used to create a pipeline for deploying code to Lambda?**

- **Correct Answer**: **AWS CodePipeline**  
  - **Reasoning**: AWS CodePipeline automates the steps required to release software changes, including deploying code to Lambda.

---

**14. What is the maximum default storage limit for an S3 bucket?**

- **Correct Answer**: **Unlimited**  
  - **Reasoning**: There is no limit on the total storage capacity of an S3 bucket, but individual objects can be up to 5 TB.

---

**15. What is the maximum default deployment package size for Lambda?**

- **Correct Answer**: **100 MB**  
  - **Reasoning**: AWS Lambda's deployment package size limit is 100 MB when uploading directly, though you can use S3 for larger packages.

---

**16. Which storage class is suitable for infrequently accessed data in S3?**

- **Correct Answer**: **ONEZONE_IA**  
  - **Reasoning**: S3 ONEZONE_IA (One Zone-Infrequent Access) is a low-cost storage class for infrequently accessed data stored in a single availability zone.

---

**17. What does the AWS Lambda "cold start" refer to?**

- **Correct Answer**: **The start of a function after a period of inactivity**  
  - **Reasoning**: A cold start occurs when Lambda initializes a new execution environment after a period of inactivity, which can introduce latency.

---

**18. Which AWS service can be used for transforming large amounts of data before saving them to S3 or analyzing them in S3?**

- **Correct Answer**: **Lambda**  
  - **Reasoning**: AWS Lambda can process and transform incoming data from S3, making it suitable for light to medium transformations in real-time.

---

**19. Which of the following is NOT a valid S3 storage class?**

- **Correct Answer**: **MULTI_REGION**  
  - **Reasoning**: There is no S3 storage class called MULTI_REGION. S3 offers storage classes like STANDARD, DEEP_ARCHIVE, and ONEZONE_IA, but not this.

---

**20. What can you use to control access to S3 buckets and objects?**

- **Correct Answer**: **All of the above**  
  - **Reasoning**: Access control to S3 buckets can be managed through bucket policies, IAM roles, and Access Control Lists (ACLs), depending on your needs.

---

This refined version provides more detailed reasoning behind each correct answer, making it easier to understand the key AWS concepts.