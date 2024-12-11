---
title: "Terraform Day 02: Provider Block ,Resource Block , S3 backend , Data Source , Remote Data Source Backend"
datePublished: Mon Dec 09 2024 08:09:02 GMT+0000 (Coordinated Universal Time)
cuid: cm4gr46c0000009laag9dhkqi
slug: terraform-day-02-provider-block-resource-block-and-s3-backend-1
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1733814111214/567ac69b-e429-47ea-af13-bf3f246610ee.webp
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1733814135502/45ae3503-d244-4ff8-9fdb-6a051197028a.webp
tags: terraform-state, terraform-cloud, terraform-providers, terraform-aws-infrastructureascode-provisioning-automation-cloudcomputing, terraformbackend

---

Infrastructure as Code (IaC) has revolutionized the way we manage cloud resources. In this blog, we’ll dive into Terraform’s fundamentals and explore its core concepts, comparing it with Cloud Native Tools (CNT) like AWS CloudFormation (CFT), Azure Resource Manager (ARM), and GCP Deployment Manager. We’ll also demonstrate practical Terraform code examples, focusing on AWS.

[Code used in the blog](https://github.com/imkiran13/Terraform-single-instance.git)

## Tools Overview

* **AWS:** CloudFormation (CFT)
    
* **Azure:** Azure Resource Manager (ARM)
    
* **GCP:** Deployment Manager
    

### Key Differences between CNT (CFT, ARM) and Terraform

| Feature | CFT & ARM | Terraform |
| --- | --- | --- |
| **Language** | JSON or YAML (all configs in one file) | HashiCorp Configuration Language (HCL) |
| **Complexity** | Learning JSON/YAML is difficult | HCL is simpler and modular |
| **Cloud Compatibility** | AWS (CFT), Azure (ARM) only | Multi-cloud (AWS, Azure, GCP) |
| **Module Support** | No | Yes, with reusable modules |
| **Workspace Support** | No | Yes, supports multiple workspaces |
| **Dry-Run Capability** | Limited | `terraform plan` for effective dry-run |
| **Importing Resources** | Complex in AWS, not available in ARM | Simple with `terraform import` |

## Terraform and Other HashiCorp Tools

Terraform is a cloud-agnostic tool, enabling multi-cloud resource management with a unified configuration language. Other HashiCorp tools include:

* **Packer:** Image automation
    
* **Consul:** Service discovery and cluster management
    
* **Vault:** Secure secrets management
    
* **Nomad:** Workload orchestration (an alternative to Kubernetes)
    

## Getting Started with Terraform

### 1\. Main Configuration ([`main.tf`](http://main.tf))

The primary file where we define the cloud provider:

```plaintext
provider "aws" {
  region = "ap-south-1"
}

# Other resource definitions will follow...
```

> **Tip:** Avoid hard-coding credentials. Use `aws configure` after installing the AWS CLI.

### 2\. Create Your First VPC ([`vpc.tf`](http://vpc.tf))

Terraform refers to any cloud resource as a **resource**. Below is an example of creating a VPC and Internet Gateway:

```plaintext
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My-VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "My-Internet-Gateway"
  }
}
```

Run `terraform init` `terraform plan` `terraform apply` to provision resources

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733755575115/58bad258-3af0-4a54-bad6-79eb88f9996c.png align="center")

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733755629973/e8d78268-b7e6-4d7c-9cc2-1237be061508.png align="center")

### 3\. Using Data Sources

Data sources fetch information about existing resources in your cloud environment. For example, fetching a VPC by its id:

```plaintext
data "aws_vpc" "Test-Vpc" {
  id = var.vpc_id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.Test-Vpc.id
}
```

Existing VPC on aws console without internet gateway

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733756441825/6da8ae74-8b5e-4d16-8051-10f6ee2a078e.png align="center")

we can attach internet gateway to existing vpc using data source

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733757059239/d624df8d-eeaf-4403-bc36-eb56d00dced8.png align="center")

Enter terraform apply and check aws vpc console for changes

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733757144019/d5efefad-7552-41bf-bf4a-d88f971b4c50.png align="center")

### **4\. Remote State Management**

Terraform generates a **state file** after deployment. Use remote state for managing infrastructure across projects:

```plaintext
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraformbucket1212"
    key    = "Base-infra.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "default" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name  = "terraform-aws-testing"
    Owner = "kiran"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "terraform-aws-igw"
  }
}

resource "aws_subnet" "subnet1-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Terraform_Public_Subnet1-testing"
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Terraform_Public_Subnet2-testing"
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "Terraform_Public_Subnet3-testing"
  }
}

resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "Terraform_Main_table-testing"
  }
}

resource "aws_route_table_association" "terraform-public" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terraform-public.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

> Initialize the backend with `terraform init`.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733819001345/7c7761c2-21c2-4bb2-9c25-52c8c7c64d87.png align="center")

### **5.Remote Data Source Backend**

Terraform can fetch data from remote backends, such as S3 or other Terraform configurations, using `terraform_remote_state`.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733820254032/e16f9c7b-1fce-44e9-8b8b-592a53e47a73.png align="center")

we can see new state file created based on previous state file of our infra setup Base-infra.tf configuration

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733820286053/e44ea333-0023-43b8-bcfc-fc445caed20c.png align="center")

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733820597378/d8c2bfce-4113-493e-8ad4-562840b5cfdc.png align="center")

## Sample Workflow

1. **Write Configuration:** Create resource files (e.g., [`vpc.tf`](http://vpc.tf), [`ec2.tf`](http://ec2.tf)).
    
2. **Initialize:** Run `terraform init` to set up the environment.
    
3. **Plan:** Run `terraform plan` to preview changes.
    
4. **Apply:** Run `terraform apply` to provision resources.
    
5. **State Management:** Use remote state for large infrastructures.
    

## Additional Resources

* **AWS Resources:** VPCs, Internet Gateways, Subnets, Security Groups, EC2 instances.
    
* **Data Sources:** Reuse existing resources effectively.
    
* **Remote State Management:** Ensure consistency across environments.
    

## Conclusion

Terraform provides unparalleled flexibility and multi-cloud support compared to CNT tools like CloudFormation and Azure Resource Manager. It simplifies infrastructure management with modules, reusable configurations, and robust state management.

Start your Terraform journey today and experience the power of IaC!