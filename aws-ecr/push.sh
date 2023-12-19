#!/bin/bash

GREEN='\u001b[32;1m'
CYAN='\u001b[36;1m'
NC='\033[0m' 

echo -e "${CYAN}---------------------------------------------------------"
echo -e "AWS ECR Docker Image Push Script"
echo -e "This script will guide you through the process of pushing a Docker image to an AWS ECR repository."
echo -e "Made by Aryan Bharti"
echo -e "---------------------------------------------------------${NC}"

echo -e "Please enter the AWS region:${NC}"
read region

echo -e "Please enter your AWS account ID:${NC}"
read awsID

if ! grep -q "$awsID.dkr.ecr.$region.amazonaws.com" ~/.docker/config.json; then
    aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $awsID.dkr.ecr.$region.amazonaws.com
fi

echo -e "Please enter the repository name:${NC}"
read repo_name

aws ecr create-repository \
        --repository-name $repo_name \
        --region $region > /dev/null

mapfile -t images < <(docker images --format "{{.Repository}}" | grep -v "<none>")

for i in "${!images[@]}"; do
    echo -e "$((i+1)). ${images[$i]}${NC}"
done

echo -e "Which image do you want to push?${NC}"
read image_num

selected_image=${images[$((image_num-1))]}

docker tag $selected_image $awsID.dkr.ecr.$region.amazonaws.com/$repo_name

docker push $awsID.dkr.ecr.$region.amazonaws.com/$repo_name

echo -e "${GREEN}---------------------------------------------------------"
echo -e "The Docker image has been successfully pushed to the ECR repository."
echo -e "---------------------------------------------------------${NC}"