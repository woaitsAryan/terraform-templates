# Quick Deployment of a Website or Service using a VM(EC2) 

This repository provides a **Terraform configuration** and an **initialization script** for quickly deploying a website or service on an AWS EC2 instance.

## Features

The **Terraform configuration** sets up the following resources on AWS:

- An EC2 instance with a t2.micro instance type, running on the us-east-1 region.
- A key pair for SSH access to the EC2 instance.
- A security group that allows inbound traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS), and allows all outbound traffic.
- An EBS volume of 20GB attached to the EC2 instance.

The **initialization script** (`init.sh`) is run on the EC2 instance when it starts. It does the following:

- Updates the package lists for upgrades and new package installations.
- Installs Docker and its dependencies.
- Installs Nginx, a popular web server.
- Installs Certbot for managing SSL/TLS certificates.
- Writes a sample Nginx configuration file that sets up a reverse proxy to a service running on port 3000.
- Installs Git and configures it to use the rebase strategy when pulling.

With these resources and configurations, you can quickly deploy a website or service on AWS. The website or service would be accessible via HTTP or HTTPS, and you would be able to SSH into the EC2 instance for management tasks.

## Usage

To use this code, follow these steps:

1. Ensure you have Terraform installed on your machine. If not, you can download it from the [official Terraform website](https://www.terraform.io/downloads.html).

2. Open your terminal and clone this repository by running the following command:

```bash
    git clone https://github.com/woaitsAryan/terraform-templates.git
```
3. Navigate to the aws-s3 directory in the cloned repository:
    
```bash
     cd aws-ec2
```
4. Run the following command to initialize Terraform:

```bash
    terraform init
```
5. Apply the Terraform configuration:

```bash
    terraform apply
```

You will be prompted to enter the name of the EC2 instance and a region. After entering these values, Terraform will provision the resources.

To destroy the resources, run the following command:

```bash
    terraform destroy
```