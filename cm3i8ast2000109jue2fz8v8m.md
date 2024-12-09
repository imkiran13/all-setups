---
title: "Setting Up a CI/CD Pipeline for a Spring Boot Application on AWS"
datePublished: Fri Nov 15 2024 04:18:09 GMT+0000 (Coordinated Universal Time)
cuid: cm3i8ast2000109jue2fz8v8m
slug: setting-up-a-cicd-pipeline-for-a-spring-boot-application-on-aws
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1731645009354/7e20a0cf-eeed-42ab-ab70-66ae8723955b.png
tags: aws, ecs, springboot, cicd-jenkins-goal

---

This tutorial guides you through setting up a CI/CD pipeline to deploy a Dockerized Spring Boot application to AWS. We’ll create a Dockerfile, build an image, push it to AWS Elastic Container Registry (ECR), and deploy it using AWS Elastic Container Service (ECS).

## Prerequisites

* AWS CLI and Docker installed
    
* An AWS account with appropriate permissions
    
* A GitHub repository (repo link used in this example: [AWS CI/CD Repo](https://github.com/imkiran13/aws-cicd.git))
    

## Step 1: Create a Dockerfile

In the root of your project, create a `Dockerfile` for the Spring Boot application. This file tells Docker how to package your application.

```plaintext
# Use the official OpenJDK 17 image from Docker Hub
FROM openjdk:17

# Set working directory inside the container
WORKDIR /app

# Copy the compiled Java application JAR file into the container
COPY ./target/course-service.jar /app

# Expose the port the Spring Boot application will run on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "course-service.jar"]
```

## Step 2: Create an ECR Repository

In the AWS Management Console:

1. Go to **Amazon ECR**.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcehQPZVuMheRZOtjpiCnP95ez_uzmy0vuDoiWh8hvVYKSL95dIypylnrmBhz2FhPMycO7cxKLijux3ZHnVMMBK2f3OUMZrIr-5sttsQToVMsNeFQ-e4c5CJqk5KbxesyUY4HSdnEnuBm2sFH44_6GX9KID?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
2. Click **Create Repository**.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcPGnyusw8yVR2ULn2S9ILtecF9a796h7A3LYmexFk3p3csgFSMg8vhmtQMGdVEPt0EMXSLPgTV4uWb7v5D5M4wg72zgIxy17f8iETnwCjcfw0xoovz0PNFn2g8PprGI_DiiYSoI6-OHM3qbrE89ACxnUI?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
3. Enter a name for your repository (e.g., `springboot-app`).
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXePorXUYZpCOAmJ0wb2hN9ba6LhGjlJkHo7vB9UiLiEGUa1DBqXYL0MoU41ihGmQ3xPkmMbXP-jt4e1wyvucxDNZ9J3rUxTnBeKmCk5NpRYpZiTYDMbmzWWjYXs8FsDCX2A9rqmqJikpAowxXmQZrQMDQA-?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
4. Select visibility as **Private** and click **Create Repository**.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfA8qNuKrZGYjsHZ-sPyoZ-SZ5i_p9s2Nh7FISHC8cnUPqjpSZ30xcbWsdz9pi0UueQ7PNe-KN14intxNtBEeGg8ESExb3Fc7d1XH8Xv5aXL2Y8y1Jc1OllWipk1Mmd4yr6Nws2ZZ4Wki0Nj34Qvv7lOAsh?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    

Note down the repository URI (e.g., `471112792443.dkr.ecr.ap-south-1.amazonaws.com/springboot-app`), which will be used in the build configuration.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc00Nfv5GtEl6y2797Dxw20yW49kMtjHmnSnp7LmRPUvnDUVcBdcFBpDA713SLcnAe0BdTRYWPITl_EXZcbRQ3F0GQURHVCioI0fpengMB8FP4Xz2aSNtPLzpMVpOewyzYQ-d2QGMcMwfWhltsEFRBfINMl?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")

## Step 3: Create a Buildspec File

The `buildspec.yml` file is used by AWS CodeBuild to define build commands and phases. Place this file in the root of your project.

```plaintext
version: 0.2

phases:
  pre_build:
    commands:
      - mvn clean install
      - echo Logging in to Amazon ECR...
      - aws --version
      - REPOSITORY_URI=471112792443.dkr.ecr.ap-south-1.amazonaws.com/springboot-app
      - aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $REPOSITORY_URI
      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
      - IMAGE_TAG=build-$(echo $CODEBUILD_BUILD_ID | awk -F":" '{print $2}')
  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t $REPOSITORY_URI:latest .
      - docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker images...
      - docker push $REPOSITORY_URI:latest
      - docker push $REPOSITORY_URI:$IMAGE_TAG
      - echo Writing image definitions file...
      - printf '[{"name":"course-service","imageUri":"%s"}]' $REPOSITORY_URI:$IMAGE_TAG > imagedefinitions.json
      - echo Writing image definitions file...
      - DOCKER_CONTAINER_NAME=springboot-app
      - printf '[{"name":"%s","imageUri":"%s"}]' $DOCKER_CONTAINER_NAME $REPOSITORY_URI:$IMAGE_TAG > imagedefinitions.json
      - echo $DOCKER_CONTAINER_NAME
      - echo printing imagedefinitions.json
      - cat imagedefinitions.json

artifacts:
  files:
    - imagedefinitions.json
    - target/course-service.jar
```

### Explanation

* **Pre-Build**: Installs dependencies, logs into ECR, and sets up variables for image tags.
    
* **Build**: Builds the Docker image and tags it.
    
* **Post-Build**: Pushes the Docker image to ECR and creates an `imagedefinitions.json` file for deployment.
    

## Step 4: Create a CodeBuild Project for CI

1. Go to **AWS CodeBuild**.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc5IOwrYT2yTtBiaNJ2UU_8ErAPpMZoYQAxkb0VHBmwsKsO_DTm5vyd6t8chHaJ2oz_wpx-EzZTp-i_-k3d90yb5x6YuOoeq1HX9novZtBgTMZupLaUQaZ8zG5n6SO1Oi0mHL4NVp9eqrKo1ozrgaA9HIdV?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
2. Click **Create Project**.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe4qhdcMtjaHQiv4xYAzrqPeHmjwhifAqX-AVuf7NKfIf3feQ8WCwjoG5tquS1B5R-Vw1oqxo15mtSgLYKb7fZqDIUB-mfUzlEey8dGAYs6c5V0YbYzSx6CzDtEVbKU92tZ4blwCNoqCOU264isUMEHCcUU?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
3. Set the project name and select **GitHub** as the source, connecting your repository.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeW0RxqjQmKjiRUV8alDerIE-kOhzI8XjSfENrj3xdN2E1i5UKPHjrZHUmYIUUEd3RNr30msyml8UkTiubf_qE4W2Lk15HsYCP0ojdtMhOVVumDGYPyCh7bV9hP51OIFGd5g1rG2K7jep4e_sL4yETg1VTx?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
4. Choose **Managed Image** as the environment and select an image with Docker support (e.g., `aws/codebuild/standard:5.0`).
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeV0N8cUqVJrzeFwai3fg53q-_CExsc9hRXDa_uOuxcv3wFub77EgF9Xj7fmK3ehJKcpNPyLF3ZgtmYqZNvL1AjHZxX6JTr8NTe1BWEmp6z02g-yLZsjQBYfaDRzCJ-A6v8sEok1saimZ1mkTPPUx5hJOg?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
5. Add the necessary environment variables and specify `buildspec.yml` as the build configuration.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeZ6fHsO-yeGw7TpNnDjoloHp5T4ZbYYk0N8bSAmLVyj4Hy-wfRSvN5CridK1H7Hxqj5a0mvMkFBbkplswoeGMJUrxiF0uhkjBbL2xbv8pIyKFvzaK7Z7PgVoiEiHnxofMDl6-xLLfxONTF8YjVY-WT5RTM?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    
6. Under **Artifacts**, select `imagedefinitions.json`.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdvr9GQNG7Yi4GsWnJUWbnGUmSJmc_Hv4plQL9lH8If_VdGs4RkBK5FIgDLfo_y2L4oDdOvcE4mN8OXEZQI_3WHnHm33HEvj4Juei6wmz7aT4xCNF_CIiNo5ZtPiqhytyEuJhuIEQfzqMJGlyUwto28UiDU?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")
    

CodeBuild will build your Docker image and push it to ECR each time code is pushed to GitHub.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe3Q50UNCmwx246Am2ozg3vIwmvm2xzS2vAotnMXNApb5HdHL6lnq_G7ywmL-EV1aLpS0onRierQNjRfHs6Y4OX1isCF-GNbQVXaomXQFYZLUIUa9bEh_4eW__sHholNwIeZ3Rao66aUikhYa_qteJqeOo?key=dxQNjcik2gdDS-kb2cG3AMgS align="left")

## Step 5: Deploy the Application Using AWS ECS

1. In **ECS**, create a new cluster.
    
2. Create a task definition with your container configuration.
    
3. Set the image to the ECR image URI generated by CodeBuild.
    
4. Define your service and deploy it.
    

## Step 6: Test the Deployment

Navigate to the ECS service URL and add `/swagger-ui/index.html` to access the Swagger UI of your deployed application.

Example URL:

```plaintext
http://65.0.69.103:8080/swagger-ui/index.html
```

## Step 7: Trigger the CodeBuild Pipeline Manually

Make a minor change in your GitHub repository and push it. The CodeBuild project should automatically trigger, rebuild, and push the updated Docker image.

### Verify Webhook

To test if the webhook is set up correctly, make a code change, commit, and push. The pipeline should start automatically, deploying the latest version to ECS.