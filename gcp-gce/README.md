# Quick Deployment of a Website or Service

This repository provides a **Terraform configuration** and an **initialization script** for quickly deploying a website or service on an GCP GCE instance.

## Prerequisites

Before you run the Terraform configuration, you need to make a project in your GCP account and enable the Compute Engine API in it.

Refer to the [Terraform Google Provider documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials) for instructions on how to link your Google Cloud Platform credentials with Terraform.

## What's Included

The **Terraform configuration** sets up the following resources on AWS:

- An GCE instance with a e2-small instance type, running on the us-central1 region.
- A key pair for SSH access to the GCE instance.
- A security group that allows inbound traffic on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS), and allows all outbound traffic.
- An volume of 20GB attached to the GCE instance.

The **initialization script** (`init.sh`) is run on the GCE instance when it starts. It does the following:

- Updates the package lists for upgrades and new package installations.
- Installs Docker and its dependencies.
- Installs Nginx, a popular web server.
- Installs Certbot for managing SSL/TLS certificates.
- Writes a sample Nginx configuration file that sets up a reverse proxy to a service running on port 3000.
- Installs Git and configures it to use the rebase strategy when pulling.

With these resources and configurations, you can quickly deploy a website or service on GCP. The website or service would be accessible via HTTP or HTTPS, and you would be able to SSH into the GCE instance for management tasks.