---
title: "Terraform Day 03 - Dependencies, Variables, TFVars and Create Before Destroy"
datePublished: Mon Dec 09 2024 08:24:59 GMT+0000 (Coordinated Universal Time)
cuid: cm4groo80000t08jsc7r8cgxx
slug: terraform-day-03-dependencies-variables-tfvars-and-create-before-destroy

---

Today, we'll dive into **dependencies in Terraform** and cover two main topics:

1. **Implicit and Explicit Dependencies**
    
2. **Variables and TFVars**
    

## Dependencies in Terraform

Terraform automatically handles resource dependencies in two ways:

### 1\. Implicit Dependencies

An **implicit dependency** occurs when one resource refers to the attribute of another resource. For example, when creating a VPC and then an Internet Gateway, the Internet Gateway doesn't inherently know that it must wait for the VPC to be created. However, when you reference the VPC ID in the Internet Gateway resource, Terraform understands that the VPC must be created first.

* **Example:**  
    When you declare a VPC, its ID is generated only after it is created. Any resource, like a subnet or Internet Gateway, that references this VPC ID creates an implicit dependency.
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733822291250/678305ed-8521-4612-849e-0649bfc62900.png align="left")

### 2\. Explicit Dependencies

Sometimes, implicit dependencies aren’t enough. For example, if we want the **S3 bucket** to be created only after the VPC is created, we need to use explicit dependencies. This is done using the `depends_on` argument in Terraform.

* **Example:**  
    A **NAT Gateway** should only be created after a **Route Table** has been established. If the NAT Gateway is created before the route table, it won’t function as expected. This is where **explicit dependencies** come into play using `depends_on`.
    

### Task Example: VPC, and S3 Bucket

* First, we’ll create a **VPC** and an **S3 bucket**. Since there's no direct dependency between the VPC and the S3 bucket, Terraform may create the S3 bucket first.
    
* To enforce order, we’ll explore how to use `depends_on` to make sure that resources like the **NAT Gateway** and **S3 bucket** are created in the correct sequence.
    

First, we create a [`main.tf`](http://main.tf) file for the VPC and an [`s3.tf`](http://s3.tf) file for the S3 buckets.

#### [`main.tf`](http://main.tf) (VPC)

```plaintext
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "Vpc-Terra"
    Service = "Terraform"
  }
}
```

#### [`s3.tf`](http://s3.tf) (S3 Buckets)

```plaintext
resource "aws_s3_bucket" "bucket1" {
  bucket = "terraform-bucket1-example"
  tags = {
    Name = "Terraform-Bucket1"
  }
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "terraform-bucket2-example"
  tas = {
    Name = "Terraform-Bucket2"
  }
}

resource "aws_s3_bucket" "bucket3" {
  bucket = "terraform-bucket3-example"
  tags = {
    Name = "Terraform-Bucket3"
  }
}
```

In this setup, Terraform will deploy the VPC and S3 buckets in parallel because no dependency exists between these resources.  
Run `terraform init` `terraform plan` `terraform apply` to provision resources

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733824703378/6d12eb26-835e-45d5-aafa-f57d91a94bd5.png align="center")

To ensure that the S3 bucket is created **after** the VPC, we’ll add explicit dependencies using the `depends_on` argument.

#### Updated [`s3.tf`](http://s3.tf) With Dependencies

```plaintext
resource "aws_s3_bucket" "bucket1" {
  bucket = "terraform-bucket1-example"
  depends_on = [aws_vpc.main]
  tags = {
    Name = "Terraform-Bucket1"
  }
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "terraform-bucket2-example"
  depends_on = [aws_vpc.main]
  tags = {
    Name = "Terraform-Bucket2"
  }
}

resource "aws_s3_bucket" "bucket3" {
  bucket = "terraform-bucket3-example"
  depends_on = [aws_vpc.main]
  tags = {
    Name = "Terraform-Bucket3"
  }
}
```

---

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733825173649/dd0521ff-a0c4-470d-b0c1-8f54f847284d.png align="center")

### Explanation of `depends_on`

1. `depends_on` ensures the explicit dependency order between resources.
    
2. In this case, the S3 buckets depend on the VPC (`aws_vpc.main`), so Terraform will:
    
    * Create the VPC first.
        
    * Then deploy the S3 buckets sequentially.  
        

---

## Variables and TFVars

### Variables

Variables allow us to easily change values without editing the code directly. This makes managing infrastructure more flexible and reusable.

### TFVars

Terraform variable values can be stored in separate `.tfvars` files, helping to:

* Keep the code clean.
    
* Manage sensitive data or multiple environments efficiently
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733837629696/b5464fb2-2776-46c4-8dca-5d1755d5f0cc.png align="center")
    
    .
    

### Removing Lock Files

Remember to clean up all `terraform.tfstate.lock` files before redeploying to avoid locking issues.

---

## Create Before Destroy

When replacing resources, Terraform often follows the **create before destroy** pattern. This ensures minimal downtime by creating a replacement resource before destroying the original.

* **Example:**  
    When updating a resource like a **Key Pair** or upgrading a component, Terraform will first create the new key, then destroy the old one after the new one is functional.
    

### Task: Example Deployment

1. Deploy the resource.
    
2. Run `terraform` apply and observe the changes. (Copy the output to a Notepad for reference.)
    
3. ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733839974848/7c0f3feb-225c-44a8-84b0-e0e19c81f5a7.png align="center")
    
4. Deploy the resource.
    
5. Add an additional name to the key\_name and reapply the changes to see how Terraform manages updates.
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733840349037/2a3874e0-1def-414e-a908-b9403162623d.png align="center")
    
      
    

---

## Prevent Destroy

Use `prevent_destroy` to safeguard critical resources. This is especially useful for resources like databases or sensitive buckets where destruction could cause significant issues

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733838570265/88fca891-ef23-4cda-bf72-e5ba084bcc24.png align="center")

---

By the end of this session, you’ll have a deeper understanding of how Terraform handles dependencies, the flexibility of variables, and the best practices for managing infrastructure deployment and updates.