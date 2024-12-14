---
title: "Terraform Day 5: Enabling TF_LOG and Working with Sensitive Information"
datePublished: Mon Dec 09 2024 08:30:41 GMT+0000 (Coordinated Universal Time)
cuid: cm4grw099000m09ma30ma8gzh
slug: terraform-day-5-enabling-tflog-and-working-with-sensitive-information
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1734178748299/24c748f6-218a-4cb9-8de2-6a6010b3bd7b.webp
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1734178761793/d43e4e49-1398-43af-aa9a-748101344283.webp

---

In this Blog, we explore how to enable logging in Terraform using environment variables, how to handle sensitive information such as passwords, and how to integrate AWS Secrets Manager for securely storing sensitive data. We also demonstrate deploying an RDS MySQL instance with Terraform.

## Topics Covered

1. **Enabling TF\_LOG for Debugging**
    
2. **Working with Sensitive Information**
    
3. **Using AWS Secrets Manager with Terraform**
    
4. **Deploying RDS MySQL Instance**
    

## Enabling TF\_LOG

Terraform provides the `TF_LOG` environment variable for controlling log verbosity. You can choose from different levels like `TRACE`, `DEBUG`, `INFO`, `WARN`, and `ERROR`.

### Steps to Enable TF\_LOG

**1\. Set TF\_LOG for Detailed Trace Logs**  
To enable detailed trace logging:

**PowerShell:**

```plaintext
$env:TF_LOG = "TRACE"
terraform apply --auto-approve
```

**Bash:**

```plaintext
export TF_LOG="TRACE"
terraform apply --auto-approve
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733929636722/b4070129-895b-433c-a48b-25e4561cb195.png align="center")

This level logs every action, providing a complete picture of the Terraform execution process.

---

**2\. Set TF\_LOG for Error-Level Logging**  
For logging only errors:

**PowerShell:**

```plaintext
$env:TF_LOG = "ERROR"
terraform apply --auto-approve
```

**Bash:**

```plaintext
export TF_LOG="ERROR"
terraform apply --auto-approve
```

This is useful when you only want to capture critical issues without unnecessary verbosity.

---

**3\. Write Logs to a File**  
To save the logs for future reference or debugging, you can direct them to a file:

**PowerShell:**

```plaintext
$env:TF_LOG = "TRACE"
$env:TF_LOG_PATH = "./logs/terraform.log"
terraform apply --auto-approve
```

**Bash:**

```plaintext
export TF_LOG="TRACE"
export TF_LOG_PATH="./logs/terraform.log"
terraform apply --auto-approve
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733930160432/777f3055-ec19-45f0-8e91-f46b042ecda1.png align="center")

The logs will be written to `terraform.log` in the specified directory (`./logs`), ensuring you don't lose critical debugging information

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733930441969/78a9dc0e-e1fe-441e-b839-c73e9c1eaf53.png align="center")

.

---

#### **Log Levels in TF\_LOG**

Terraform supports various log levels for different use cases:

* **TRACE**: Detailed logs for debugging.
    
* **DEBUG**: Logs for in-depth insights into operations.
    
* **INFO**: General logs to understand the flow.
    
* **WARN**: Logs for warnings during operations.
    
* **ERROR**: Logs for critical errors only.
    

## Handling Sensitive Information

When working with sensitive data like usernames and passwords, it is important to avoid hardcoding them in the Terraform scripts. Instead, use variables marked as `sensitive`.

### Example

In your [`variables.tf`](http://variables.tf):

```plaintext
variable "username" {
  type      = string
  sensitive = true
}

variable "password" {
  type      = string
  sensitive = true
}
```

### Storing Passwords Securely with AWS Secrets Manager

To securely store and retrieve sensitive information like passwords, you can use AWS Secrets Manager.

2. **Generate a random password:**
    
    ```plaintext
    resource "random_password" "db_password" {
      length           = 16
      special          = true
      override_special = "_!%^"
    }
    ```
    
3. **Store the password in AWS Secrets Manager:**
    
    ```plaintext
    resource "aws_secretsmanager_secret" "db_secret" {
      name = "test-db-password"
    }
    
    resource "aws_secretsmanager_secret_version" "db_secret_version" {
      secret_id     = aws_secretsmanager_secret.db_secret.id
      secret_string = random_password.db_password.result
    }
    ```
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733933786380/ba5e9385-3a5e-4627-b8e6-165ddb1062a1.png align="left")
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733933547667/74969895-f1bf-4598-9beb-72f3adbd1276.png align="center")

## Deploying RDS MySQL Instance

### Steps:

1. **Retrieve the password when deploying RDS:**
    
    ```plaintext
    data "aws_secretsmanager_secret" "db_secret" {
      name = "test-db-password"
    }
    
    data "aws_secretsmanager_secret_version" "db_secret_version" {
      secret_id = aws_secretsmanager_secret.db_secret.id
    }
    ```
    
2. **Create a subnet group:**
    
    ```plaintext
    resource "aws_db_subnet_group" "test_subnet_group" {
      name = "test-db-subnet-group"
      subnet_ids = [
        aws_subnet.subnet1-public.id,
        aws_subnet.subnet2-public.id,
        aws_subnet.subnet3-public.id,
      ]
      tags = {
        Name = "Test DB subnet group"
      }
    }
    ```
    
3. **Deploy the RDS instance:**
    
    ```plaintext
    resource "aws_db_instance" "test_db_instance" {
      identifier           = "testdb"
      allocated_storage    = 20
      storage_type         = "gp2"
      engine               = "mysql"
      engine_version       = "8.0.39"
      instance_class       = "db.t3.micro"
      username             = "adminuser"
      password             = data.aws_secretsmanager_secret_version.db_secret_version.secret_string
      publicly_accessible  = true
      db_subnet_group_name = aws_db_subnet_group.test_subnet_group.id
    }
    ```
    

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733933634404/46a61ed9-506d-447d-be2e-779f8f7a0c02.png align="center")

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733933731541/b0b1f0eb-4483-43a3-8e3c-1d39069a8ba0.png align="center")

###   
Connecting to RDS via MySQL Workbench:

1. In AWS Console, go to **RDS &gt; Databases &gt; testdb** and copy the **endpoint**
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733933862218/e5951795-603f-4570-9418-effe882033c1.png align="center")
    
    .
    
2. In **MySQL Workbench**, use:
    
    * Hostname: `<copied endpoint>`
        
    * Username: adminuser  
        make sure port 3306 is open in security Group
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733934050846/e30e073c-87e5-4a3b-9f16-29624d30ed32.png align="center")
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733934374929/72f70aff-acbd-42dc-91ea-0f7636dc30e2.png align="center")
        
    * Password: Fetch from **AWS Secrets Manager**.
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733931249851/e5b2ae0d-11bb-4cd7-a64e-85769edfee58.png align="left")
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733937594520/d63b8085-5bf5-4124-9952-39156820ed05.png align="left")
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733937689738/4fcef605-245e-4b0f-8796-937fbcd11270.png align="center")
        
          
        Connected successfully
        

### Destroy the Infrastructure

After testing, remember to clean up:

```plaintext
terraform destroy --auto-approve
```

## Interview Tip: Handling Sensitive Information

When asked how to handle sensitive information in Terraform, you can explain that Terraform can integrate with AWS Secrets Manager to securely store and retrieve sensitive data. Sensitive variables should be defined in Terraform to avoid exposing sensitive information directly in the code.