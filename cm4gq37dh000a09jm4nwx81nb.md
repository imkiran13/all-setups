---
title: "Terraform Day 01: Installation and Setup on Windows"
datePublished: Mon Dec 09 2024 07:40:17 GMT+0000 (Coordinated Universal Time)
cuid: cm4gq37dh000a09jm4nwx81nb
slug: terraform-day-01-installation-and-setup-on-windows

---

Infrastructure as Code (IaC) simplifies cloud resource management, and Terraform is one of the most powerful tools for this. In this guide, we will cover the installation and setup of Terraform, Git, and Visual Studio Code (VS Code) on a Windows system.

## Prerequisites

Before we begin, ensure you have the following:

* A Windows PC with admin access.
    
* A stable internet connection.
    

---

## Step 1: Install Terraform

Terraform is a command-line tool for automating infrastructure provisioning.

### 1\. Download Terraform

1. Go to the [Terraform Download Page](https://www.terraform.io/downloads).
    
2. Select the Windows version
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729736129/e8ffe923-4e71-4347-ad78-1f2343f11ef7.png align="center")
    
3. Download the ZIP file
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729767844/6536ebb7-aa47-4c17-a2b9-00e2c0825039.png align="center")
    
    .
    

### 2\. Install Terraform

1. Extract the ZIP file to a directory of your choice, e.g., C:\\Program Files\\Terraform
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729847321/67a00c73-f6c3-493b-a072-fc04d89196dd.png align="center")
    
    .
    
2. Add the directory to your system's PATH:
    
    * Search for "Environment Variables" in the Windows search bar.
        
    * Click on "Environment Variables."
        
    * Under "System Variables," find `Path` and click "Edit.
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729585666/14095940-af0b-47b7-8963-3b29c5321dd6.png align="center")
        
    * Add the path to the Terraform folder (e.g., `C:\Terraform`)
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729620583/ad7017e8-991f-40d5-813d-c7972ee5b271.png align="center")
        
        .
        
3. Open a new Command Prompt and type `terraform --version` to verify the installation
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729939804/70459586-e034-46b0-bc64-42c728b1fd84.png align="center")
    
    .
    

---

## Step 2: Install Git

Git is essential for version control and working with Terraform repositories.

### 1\. Download Git

1. Visit the [Git Official Website](https://git-scm.com/).
    
2. Download the Windows installer.
    

### 2\. Install Git

1. Run the installer and follow the prompts.
    
2. Choose default settings unless you have specific preferences.
    
3. Verify the installation by opening a Command Prompt and typing `git --version`
    
    ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729363456/d2261ef0-f5f6-4d23-af70-cbb1fa163c39.png align="center")
    
    .
    

---

## Step 3: Install Visual Studio Code (VS Code)

VS Code is a lightweight code editor ideal for working with Terraform configurations.

### 1\. Download VS Code

1. Go to the [VS Code Download Page](https://code.visualstudio.com/).
    
2. Download the Windows installer.
    

### 2\. Install VS Code

1. Run the installer and follow the prompts.
    
2. Install recommended options like "Add to PATH" and "Create a desktop shortcut."
    
3. Launch VS Code.
    

### 3\. Install Extensions

To optimize VS Code for Terraform:

1. Open VS Code and click on the Extensions icon in the sidebar.
    
2. Search for and install the following extensions:
    
    * **HashiCorp Terraform:** Provides syntax highlighting and IntelliSense for `.tf` files
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729224246/f814005d-852a-4b53-bcef-38f62826f2d9.png align="center")
        
        .
        
    * **Prettier - Code Formatter:** Ensures consistent formatting
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733729262992/7da386a4-fd87-41c0-b251-eddbd573b459.png align="center")
        
        .
        

---

## Step 4: Install the AWS CLI

1. #### For Windows:
    
    1. Download the AWS CLI installer from [AWS CLI Downloads](https://aws.amazon.com/cli/).
        
    2. Run the installer and follow the instructions
        
        ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733730875010/79f503d3-bbe1-4f29-bcbe-2979656c3e98.png align="center")
        
        .
        
    
2. **Verify Installation**
    
    Run the following command to verify the AWS CLI installation:
    
3. ```bash
      aws --version
    ```
    
4. ![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733731452696/11dc6a30-e1d7-4dbf-be0f-71e6aa12d26f.png align="center")
    
5. Configure AWS CLI
    
    * Set up your AWS credentials by running:
        
        ```plaintext
        aws configure
        ```
        
6. Provide the following details:
    
    * **Access Key ID:** Your AWS access key.
        
    * **Secret Access Key:** Your AWS secret key.
        
    * **Region:** The default region for your resources (e.g., `us-west-2`).
        
    * **Output Format:** Default is `json`.
        

---

## Step 5: Configure Your Workspace

1. Create a working directory for your Terraform projects, e.g., `C:\TerraformProjects`.
    
2. Initialize a Git repository in the directory:
    
    ```bash
    git init
    ```
    
3. Create your first Terraform file:
    
    * Open VS Code.
        
    * Create a new file named [`main.tf`](http://main.tf).
        
    * Add a basic provider configuration:
        
        ```plaintext
        provider "aws" {
          region = "us-west-2"
        }
        ```
        

---

## Verifying the Setup

1. Open a Command Prompt or VS Code Terminal.
    
2. Navigate to your working directory.
    
3. Run `terraform init` to initialize Terraform in the directory.
    
4. If successful, you’re ready to start building with Terraform!
    

## Conclusion

Setting up Terraform, Git, and VS Code ,AWS CLI on Windows is straightforward and sets the foundation for managing your cloud infrastructure efficiently. With these tools in place, you’re ready to start exploring Terraform’s capabilities. Happy coding!