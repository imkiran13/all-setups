---
title: "Terraform Day 04 - Terraform Workspaces for Multi-Environment Infrastructure"
datePublished: Mon Dec 09 2024 08:28:35 GMT+0000 (Coordinated Universal Time)
cuid: cm4grtb2j001o08l9g01s0atl
slug: terraform-day-04-terraform-workspaces-for-multi-environment-infrastructure

---

## Prerequisites

* Terraform installed on your local machine.
    
* AWS CLI configured with proper permissions.
    
* S3 bucket for state backend.
    
* DynamoDB table for state file locking.
    

## Infrastructure Overview

You will be deploying three environments:

* **Dev**: 3 Servers
    
* **UAT**: 3 Servers
    
* **Prod**: 3 Servers
    

Each environment will have its own Terraform `.tfvars` file to manage configuration differences like naming conventions.

## Step-by-Step Guide

### 1\. Clone the Base Infrastructure

Clone the base Terraform infrastructure and make the necessary changes to create multiple environments.

### 2\. Setup State Backend

Create an S3 bucket to store Terraform state files and configure it as a backend in your [`main.tf`](http://main.tf). Ensure that the bucket is set up before proceeding.

### 3\. Create Environment-Specific `.tfvars` Files

* Rename the existing `terraform.tfvars` to `dev.tfvars`.
    
* Create `uat.tfvars` and `prod.tfvars` with environment-specific changes (like naming conventions for servers).
    

### 4\. Initialize and Validate Terraform

```plaintext
terraform init
terraform validate
terraform fmt
```

### 5\. Apply Terraform Configuration

Deploy the infrastructure for each environment using the appropriate `.tfvars` file.

#### For Dev Environment:

```plaintext
terraform apply -var-file=dev.tfvars
```

#### For UAT Environment:

```plaintext
terraform workspace new uat
terraform apply -var-file=uat.tfvars
```

#### For Prod Environment:

```plaintext
terraform workspace new prod
terraform apply -var-file=prod.tfvars
```

### 6\. Managing State Files for Different Environments

Each environment requires a separate state file. If you use the same state backend without separating the state files, Terraform will attempt to apply changes across environments.

To manage state files for different environments, use Terraform workspaces:

```plaintext
terraform workspace new dev
terraform workspace new uat
terraform workspace new prod
```

Each workspace will create a separate folder in the S3 bucket to store the respective environment’s state file.

### 7\. Adding EC2 Instances

Modify the [`ec2.tf`](http://ec2.tf) file to add the EC2 instance configurations:

* Use different AMI IDs for each environment.
    
* Example of setting the server name:
    
    ```plaintext
    server_name = "${var.env}-Server-1"
    ```
    

### 8\. User Data Configuration

Add user data to the EC2 instances to update the web server’s index page:

```plaintext
#!/bin/bash
echo "Hello from ${var.env}" > /var/www/html/index.nginx-debian.html
```

### 9\. Switch Between Workspaces

To switch between environments, use the `terraform workspace` commands:

```plaintext
terraform workspace select dev
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

Repeat the process for UAT and Prod environments by selecting their respective workspaces.

### 10\. Check Public IPs of All Servers

After deployment, verify the public IP addresses of the servers in each environment.

### 11\. Clean Up (Destroy Infrastructure)

To destroy resources from each environment:

```plaintext
terraform workspace select prod
terraform destroy -var-file=prod.tfvars

terraform workspace select dev
terraform destroy -var-file=dev.tfvars

terraform workspace select uat
terraform destroy -var-file=uat.tfvars
```

### 12\. Delete Workspaces

Once the environments are destroyed, delete the workspaces:

```plaintext
terraform workspace delete dev
terraform workspace delete uat
terraform workspace delete prod
```

### 13\. DynamoDB for State Locking

To avoid state file conflicts, implement state locking using DynamoDB.

1. Create a [`dynamodb.tf`](http://dynamodb.tf) file:
    
    ```plaintext
    resource "aws_dynamodb_table" "terraform_locks" {
      name         = "terraform-state-lock"
      billing_mode = "PAY_PER_REQUEST"
      hash_key     = "LockID"
    
      attribute {
        name = "LockID"
        type = "S"
      }
    }
    ```
    
2. Apply the DynamoDB configuration:
    
    ```plaintext
    terraform apply
    ```
    
3. Add the DynamoDB state locking configuration to your backend in [`main.tf`](http://main.tf):
    
    ```plaintext
    backend "s3" {
      bucket         = "your-s3-bucket"
      key            = "path/to/terraform.tfstate"
      region         = "us-west-2"
      dynamodb_table = "terraform-state-lock"
    }
    ```
    

### 14\. Excluding DynamoDB from Terraform State

If you wish to manage DynamoDB outside of Terraform to prevent it from being destroyed, remove it from the state file:

```plaintext
terraform state rm aws_dynamodb_table.terraform_locks
```

### 15\. Push Code to GitHub

Once all the files are ready, push them to your GitHub repository:

```plaintext
git init
git add .
git commit -m "Initial commit for Terraform multi-environment setup"
git remote add origin https://github.com/your-username/terraform-multi-env.git
git push -u origin main
```

### 16\. Deploying the Infrastructure from GitHub

1. Clone the repository onto your local machine or remote instance:
    
    ```plaintext
    git clone https://github.com/your-username/terraform-multi-env.git
    ```
    
2. Run the Terraform commands to deploy the infrastructure:
    
    ```plaintext
    terraform init
    terraform plan -var-file=dev.tfvars
    terraform apply -var-file=dev.tfvars
    ```
    

---

## Conclusion

This project demonstrates how to manage multiple identical environments (Dev, UAT, Prod) using Terraform Workspaces, S3 for state management, and DynamoDB for state locking. Be sure to separate your environments' state files to avoid conflicts and manage infrastructure more effectively.

Feel free to explore, modify, and extend this setup for your own infrastructure needs.