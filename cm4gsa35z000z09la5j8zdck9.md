---
title: "Terraform Day 9: Terraform Modules with GitLab"
datePublished: Mon Dec 09 2024 08:41:38 GMT+0000 (Coordinated Universal Time)
cuid: cm4gsa35z000z09la5j8zdck9
slug: terraform-day-9-terraform-modules-with-gitlab
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1734516474755/ad8bd264-e7cd-4624-b5b0-2a7ae0af9a90.webp
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1734516485178/d9981f40-b46e-496e-a6c6-fe193af4bffb.webp

---

Complete Source file here : [https://gitlab.com/saikiranpi1/modules-gitlab.git](https://gitlab.com/saikiranpi1/modules-gitlab.git)

```plaintext
# Terraform - GitLab Integration

This repository contains instructions and YAML configurations for integrating Terraform with GitLab CI/CD, allowing for efficient infrastructure management and deployment.

## Table of Contents
- [Overview](#overview)
- [Getting Started](#getting-started)
- [GitLab CI Configuration](#gitlab-ci-configuration)
- [Using tfenv](#using-tfenv)
- [Installing GitLab Runner](#installing-gitlab-runner)
- [Deploying an Ubuntu Server](#deploying-an-ubuntu-server)
- [Cleaning Up](#cleaning-up)
- [Troubleshooting](#troubleshooting)
- [Conclusion](#conclusion)

## Overview

This project demonstrates how to set up Terraform with GitLab CI/CD using YAML for configuration. We will focus on tasks such as pushing code to GitLab, setting up CI/CD variables, and deploying infrastructure.

## Getting Started

1. **Create a new GitLab project**:
   - Go to your GitLab dashboard and click on "New Project."
   - Select "Public" and create the project.

2. **Push your Terraform code**:
   ```bash
   git init
   git add .
   git commit -m "Infra"
   git remote add origin <your-repo-url>
   git push origin master
```

## GitLab CI Configuration

1. **Access CI/CD Settings**:
    
    * Navigate to your project, then go to `Settings` &gt; `CI/CD`.
        
2. **Upload Secure Files**:
    
    * Under the "Secure Files" section, upload your PEM file.
        
3. **Add CI/CD Variables**:
    
    * Scroll to "Variables" and click "Add."
        
    * Add the following masked variables:
        
        * `AWS_ACCESS_KEY`
            
        * `AWS_SECRET_KEY`
            
4. **Set Up a New GitLab Runner**:
    
    * Navigate to `Runners` and select "New project runner."
        
    * Choose "Linux" and set the following:
        
        * **Tags**: `terraform,AWS`
            
        * **Description**: A brief description of your runner.
            
        * **Timeout**: 600 seconds.
            
    * Click "Create Runner."
        

## Using tfenv

To manage different Terraform versions easily, we will use `tfenv`. Follow these steps:

1. **Install tfenv**:
    
    * Follow the instructions available on the [tfenv GitHub page](https://github.com/tfutils/tfenv).
        
2. **Install the Required Terraform Version**:
    
    ```plaintext
    sudo apt install unzip
    tfenv list-remote  # Lists all available versions
    tfenv install 1.5.5 # Installs the specified version
    ```
    

## Installing GitLab Runner

1. **Install GitLab Runner**:
    
    * Open your console and follow the installation commands provided on the [GitLab Runner page](https://docs.gitlab.com/runner/install/).
        
2. **Register the Runner**:
    
    * Enter the token and name for the runner, choose "shell" as the executor.
        
3. **Modify Your Code and Push**:
    
    * Make minor changes to your code and push it. This should trigger the CI/CD pipeline.
        
4. **Run Commands as gitlab-runner**:
    
    ```plaintext
    cat /etc/passwd
    sudo rm -r /home/gitlab-runner/.bash_logout
    su - gitlab-runner  # Switch to gitlab-runner user
    ```
    

## Deploying an Ubuntu Server

Log into the server and deploy the necessary infrastructure using your Terraform scripts.

## Cleaning Up

To destroy the infrastructure, run:

```plaintext
terraform destroy -auto-approve
```

You can use **Checkov**, a free tool, to scan your Terraform code for security issues:

```plaintext
apt install -y python3-pip
```

## Troubleshooting

If you encounter errors:

* Check the GitLab CI/CD pipeline logs for error messages.
    
* Google any error codes for potential solutions.
    

## Conclusion

This setup provides a streamlined approach to managing infrastructure with Terraform in a GitLab CI/CD environment. Feel free to customize the configurations as needed to fit your specific requirements.

For further assistance, refer to the [official Terraform documentation](https://www.terraform.io/docs/index.html) or [GitLab CI/CD documentation](https://docs.gitlab.com/ee/ci/).