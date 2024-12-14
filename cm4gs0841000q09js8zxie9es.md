---
title: "Terraform Day 7: Terraform Functions Part: 2"
datePublished: Mon Dec 09 2024 08:33:58 GMT+0000 (Coordinated Universal Time)
cuid: cm4gs0841000q09js8zxie9es
slug: terraform-day-7-terraform-functions-part-2
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1734178939373/3a008da4-a75c-4f2e-bfbe-39744ceb2de1.webp

---

This Blog demonstrates the usage of various Terraform functions such as `lookup`, `count`, and `condition`, along with implementing file provisioners (`remote-exec`, `local-exec`). The goal is to dynamically manage infrastructure using variables, conditional logic, and provisioning tasks.

## Project Structure

* [`ec2.tf`](http://ec2.tf): Main file to create EC2 instances.
    
* [`variables.tf`](http://variables.tf): Define variables such as AMIs, instance type, keyname, and environment.
    
* `terraform.tfvars`: Assign values to variables such as AMI IDs for different regions and the environment.
    
* [`null.tf`](http://null.tf): Implements `null_resource` to run scripts without recreating instances.
    
* [`userdata.sh`](http://userdata.sh): Script to install software on EC2 instances after they are created.
    

## Terraform Functions Overview

### 1\. AMI Lookup

The `lookup` function helps dynamically retrieve AMI IDs based on the region.

Example:

```plaintext
variable "amis" {
  type = map(string)
}

# In terraform.tfvars
amis = {
  us-east-1 = "ami-0abcd1234efgh5678"
  us-east-2 = "ami-0wxyz1234mnop5678"
}

# In ec2.tf
ami = lookup(var.amis, var.aws_region)
```

This setup allows us to deploy EC2 instances using region-specific AMIs. For example, AMIs in `us-east-1` may not work in `us-east-2`.

### 2\. Instance Count with Subnet Mapping

We declare three subnets, and each subnet must map to one EC2 instance. By using `count`, we can define how many instances to create based on the length of subnets.

```plaintext
count = length(var.public_cidr_block)

subnet_id = element(var.subnets, count.index)
```

### 3\. Conditional Deployment

Using a condition, we can decide how many instances to create based on the environment.

```plaintext
count = var.environment == "Prod" ? 3 : 1
```

This means if the environment is `Prod`, 3 instances are created; otherwise, 1 instance is created.

## Provisioners

### File Provisioning with `remote-exec`

We use provisioners to apply scripts after EC2 instances are created without recreating the instances.

* **User Data**: Initially, the user data script is passed during instance creation.
    
* **Provisioners**: To avoid recreating instances for every change, we use `null_resource` to run scripts or commands on existing instances.
    

Example:

```plaintext
resource "null_resource" "cluster" {
  count = length(var.public_cidr_block)
  
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("path/to/key.pem")
      host     = aws_instance.example.public_ip
    }
    inline = [
      "sudo bash /tmp/script.sh"
    ]
  }
}
```

### Tainting Resources

If we need to recreate a resource, we can use Terraform's `taint` feature. Marking a resource as "tainted" forces Terraform to recreate it during the next apply.

Example:

```plaintext
terraform taint null_resource.cluster
```

This marks the resource as needing recreation, allowing the new script to be applied without affecting the rest of the infrastructure.

## Commands

```plaintext
terraform init      # Initialize Terraform
terraform fmt       # Format the code
terraform validate  # Validate the configuration
terraform apply     # Apply the configuration
```

### Taint Example

```plaintext
terraform taint null_resource.cluster
terraform apply
```

## Next Steps

* Explore **Terraform Modules** for better structuring and reuse of code.
    

## Interview Tips

**What is taint in Terraform?** Taint marks a resource for recreation. You can manually taint a resource using the `terraform taint` command, causing Terraform to destroy and recreate it during the next `apply`. Conversely, you can "untaint" a resource to prevent it from being recreated.