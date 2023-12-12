# Terraform Templates

Welcome to the Terraform Templates Repository! This repository is a collection of Terraform templates designed for various use cases, created with the aim of learning and demonstrating Terraform's capabilities.

## Instructions

Each directory in this repository contains a different Terraform template. Each template has its own README file with specific instructions and details about what the template does. Please read these README files to understand the purpose and functionality of each template. Note that these templates are designed according to my personal preferences and use cases.

## How do I run these templates?

Follow these steps to run the Terraform templates:

1. **Install Terraform**: If you haven't installed Terraform yet, you can do so by following the instructions on this [link](https://developer.hashicorp.com/terraform/install).

2. **Navigate to the Template Directory**: Use the `cd` command to navigate into the directory of the template you want to run. For example:

    ```bash
    cd /path/to/template
    ```

3. **Set Up Your Environment Variables**: Each template directory contains a `.env.sample` file. Copy the contents of this file into a new file named `.env` in the same directory, and replace the placeholder values with your actual required credentials. Then run:
    ```bash
    source .env
    ```
4. **Initialize Terraform**: Run the following command to download the necessary provider plugins for Terraform:

    ```bash
    terraform init
    ```

5. **Validate the Configuration**: Run the following command to check for any errors in the configuration:

    ```bash
    terraform validate
    ```

6. **Apply the Configuration**: If the configuration is valid, run the following command to create the resources defined in the configuration:

    ```bash
    terraform apply
    ```

7. **Destroy the Resources**: When you're done with the resources, you can destroy them by running the following command:

    ```bash
    terraform destroy
    ```
