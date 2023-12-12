# Quick Deployment of a Website or Service

This repository provides a **Terraform configuration** and an **initialization script** for quickly deploying a website or service on an AWS EC2 instance.

## Prerequisites

Before you run the Terraform configuration, you can set your own AWS region where you want your resources to be created. You can do this in the provider block of your Terraform configuration:

```terraform
provider "aws" {
    region = "your-region"
}
```

Replace your-region with the region where you want your resources to be created (e.g., us-east-1).

Also, you need to authenticate Terraform to use AWS. Follow the guide on the [Terraform AWS Provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables) to set up the necessary environment variables.

## What's Included

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