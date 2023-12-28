
# S3(Storage) Bucket Provisioning

This repository contains Terraform code for provisioning an AWS S3 bucket with specific lifecycle rules and an IAM role for secure access. It also enables S3 versioning.

## Features

1. **S3 Bucket Provisioning**: Creates an AWS S3 bucket for data storage.

2. **Lifecycle Rules**: Sets up lifecycle rules to automatically transition data to cost-effective storage classes after a certain period. The rules are as follows:
    - After 60 days, data is moved to the Standard-IA storage class.
    - After 90 days, data is moved to Glacier.
    - For older versions of data, the transitions occur after 30 days to Standard-IA and 60 days to Glacier.

3. **IAM Role**: Creates an IAM role with access to the S3 bucket. This role can be attached to any IAM user who needs access to the bucket, ensuring secure access management.

4. **S3 Versioning**: Enables versioning on the S3 bucket, allowing preservation, retrieval, and restoration of every version of every object in the bucket.

## Usage

To use this code, follow these steps:

1. Ensure you have Terraform installed on your machine. If not, you can download it from the [official Terraform website](https://www.terraform.io/downloads.html).

2. Open your terminal and clone this repository by running the following command:

    ```bash
    git clone https://github.com/woaitsAryan/terraform-templates.git
    ```
3. Navigate to the aws-s3 directory in the cloned repository:
    
    ```bash
    cd aws-s3
    ```
4. Run the following command to initialize Terraform:

    ```bash
    terraform init
    ```
5. Apply the Terraform configuration:



    ```bash
    terraform apply
    ```

You will be prompted to enter the name of the S3 bucket and a region. After entering these values, Terraform will provision the resources.

To destroy the resources, run the following command:


    terraform destroy
