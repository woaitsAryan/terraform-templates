# DynamoDB(NoSQL DB) and DAX(In-Memory Cache) Provisioning 

This repository contains Terraform code to set up a DynamoDB table with a DAX (DynamoDB Accelerator) cluster on AWS. 

## Features

- Provisions a DynamoDB table with autoscaling enabled. The read capacity scales from 1 to 5 units based on demand.
- Creates a small DAX cluster to provide in-memory caching for the DynamoDB table, improving read performance.
- Sets up an IAM role that grants a user full access to the DynamoDB table and DAX cluster.
- Enables point-in-time recovery for the DynamoDB table, allowing you to restore the table to any point in the last 35 days.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- An AWS account and your AWS credentials configured locally.

## Usage

To use this code, follow these steps:

1. Ensure you have Terraform installed on your machine. If not, you can download it from the [official Terraform website](https://www.terraform.io/downloads.html).

2. Open your terminal and clone this repository by running the following command:

    ```bash
    git clone https://github.com/woaitsAryan/terraform-templates.git
    ```
3. Navigate to the aws-s3 directory in the cloned repository:
    
    ```bash
     cd aws-dynamodb
    ```
4. Run the following command to initialize Terraform:

    ```bash
    terraform init
    ```
5. Apply the Terraform configuration:

    ```bash
    terraform apply
    ```

You will be prompted to enter the name of the db and the dax cluster, and a region. After entering these values, Terraform will provision the resources.

To destroy the resources, run the following command:


    terraform destroy