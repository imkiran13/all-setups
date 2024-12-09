---
title: "Terraform Day 5: Enabling TF_LOG and Working with Sensitive Information"
datePublished: Mon Dec 09 2024 08:30:41 GMT+0000 (Coordinated Universal Time)
cuid: cm4grw099000m09ma30ma8gzh
slug: terraform-day-5-enabling-tflog-and-working-with-sensitive-information

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

1. **Set TF\_LOG for detailed trace logs:**
    
    ```plaintext
    $env:TF_LOG = "TRACE"
    terraform destroy
    ```
    
2. **Set TF\_LOG for error-level logging:**
    
    ```plaintext
    $env:TF_LOG = "ERROR"
    terraform destroy
    ```
    
3. **Write logs to a file:**
    
    ```plaintext
    $env:TF_LOG = "TRACE"
    $env:TF_LOG_PATH = "./logs/terraform.log"
    terraform destroy
    ```
    

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

1. **Generate a random password:**
    
    ```plaintext
    resource "random_password" "master" {
      length           = 16
      special          = true
      override_special = "_!%^"
    }
    ```
    
2. **Store the password in AWS Secrets Manager:**
    
    ```plaintext
    resource "aws_secretsmanager_secret" "password" {
      name = "test-db-password"
    }
    
    resource "aws_secretsmanager_secret_version" "password" {
      secret_id     = aws_secretsmanager_secret.password.id
      secret_string = random_password.master.result
    }
    ```
    
3. **Retrieve the password when deploying RDS:**
    
    ```plaintext
    data "aws_secretsmanager_secret_version" "password" {
      secret_id = aws_secretsmanager_secret.password.id
    }
    
    resource "aws_db_instance" "default" {
      identifier           = "testdb"
      allocated_storage    = 10
      storage_type         = "gp2"
      engine               = "mysql"
      engine_version       = "5.7"
      instance_class       = "db.t2.medium"
      username             = "dbadmin"
      password             = data.aws_secretsmanager_secret_version.password.secret_string
      publicly_accessible  = true
      db_subnet_group_name = aws_db_subnet_group.default.id
    }
    ```
    

## Deploying RDS MySQL Instance

### Steps:

1. **Create a subnet group:**
    
    ```plaintext
    resource "aws_db_subnet_group" "default" {
      name       = "main"
      subnet_ids = [
        aws_subnet.subnet1-public.id,
        aws_subnet.subnet2-public.id,
      ]
      tags = {
        Name = "My DB subnet group"
      }
    }
    ```
    
2. **Deploy the RDS instance:**
    
    ```plaintext
    resource "aws_db_instance" "default" {
      identifier         = "testdb"
      allocated_storage  = 10
      engine             = "mysql"
      engine_version     = "5.7"
      instance_class     = "db.t2.medium"
      name               = "mydb"
      username           = "dbadmin"
      password           = data.aws_secretsmanager_secret_version.password.secret_string
      publicly_accessible = true
      db_subnet_group_name = aws_db_subnet_group.default.id
    }
    ```
    

### Connecting to RDS via MySQL Workbench:

1. In AWS Console, go to **RDS &gt; Databases &gt; testdb** and copy the **endpoint**.
    
2. In **MySQL Workbench**, use:
    
    * Hostname: `<copied endpoint>`
        
    * Username: `dbadmin`
        
    * Password: Fetch from **AWS Secrets Manager**.
        

### Destroy the Infrastructure

After testing, remember to clean up:

```plaintext
terraform destroy
```

## Interview Tip: Handling Sensitive Information

When asked how to handle sensitive information in Terraform, you can explain that Terraform can integrate with AWS Secrets Manager to securely store and retrieve sensitive data. Sensitive variables should be defined in Terraform to avoid exposing sensitive information directly in the code.