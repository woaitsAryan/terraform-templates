# AWS ECR Docker Image Push Script

This is a bash script that pushes local Docker images to an Amazon Elastic Container Registry (ECR).

## Prerequisites

Before you can use this script, you need to have the following installed on your system:

- AWS CLI: This script uses the AWS CLI to interact with the AWS ECR. You can install it by following the instructions on the [official AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).
- Docker: This script uses Docker to manage images and containers. You can install it by following the instructions on the [official Docker documentation](https://docs.docker.com/get-docker/).

This script is designed to work on Unix systems (Linux/MacOS). If you're using Windows, you can run this script through Git Bash, MinGW, or Cygwin.

## Usage

To use this code, follow these steps:

1. Open your terminal and clone this repository by running the following command:

```bash
    git clone https://github.com/woaitsAryan/terraform-templates.git
```
2. Navigate to the aws-s3 directory in the cloned repository:
    
```bash
     cd aws-ecr
```
3. Run the script
```bash
    bash push.sh
```
    or you can try running the executable directly(mainly for Windows users):
    
```bash
    chmod +x push

    ./push
```

This will start the script, which will guide you through the process of pushing a Docker image to an AWS ECR repository.