---
title: "Jenkins: Automating Continuous Integration and Deployment"
datePublished: Mon Feb 19 2024 13:49:31 GMT+0000 (Coordinated Universal Time)
cuid: clssztldf00000al0ff8j3ksk
slug: jenkins-automating-continuous-integration-and-deployment

---

### Introduction

Jenkins, a leading CI/CD tool, revolutionizes software development by automating the processes of continuous integration (CI) and continuous deployment (CD). In this guide, we'll explore the fundamentals of Jenkins, its setup, and integration with Git and Maven for streamlined development workflows.

### Understanding CI/CD

* **Continuous Integration (CI):** Integrating code changes into a shared repository frequently, followed by automated builds and tests to detect errors early.
    
* **Continuous Deployment (CD):** Automatically deploying code changes to production environments after passing through CI.
    

### Jenkins Overview

* **Open Source:** Jenkins is free and open-source, allowing for community-driven contributions and enhancements.
    
* **Platform Independence:** Jenkins is built on Java, making it compatible with various operating systems.
    
* **Plugin Ecosystem:** Jenkins offers a vast array of plugins for seamless integration with other tools and technologies.
    

### Setting Up Jenkins

### Prerequisites

* EC2 instance with port 8080 open for Jenkins access.
    

### Installation Steps

1. **Install Git, Java, and Maven:**
    
    ```plaintext
    sudo apt install git openjdk-8-jre maven -y
    ```
    
2. **Add Jenkins Repository and Install:**
    
    ```plaintext
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
      https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt install openjdk11-jre -y
    sudo apt update
    sudo apt install jenkins
    ```
    
3. **Restart Jenkins Service:**
    
    ```plaintext
    systemctl start jenkins.service
    systemctl status jenkins.service
    ```
    
4. **Access Jenkins:** Copy the public IP of your EC2 instance and access Jenkins in your browser using `public-ip:8080`.
    
5. **Initial Admin Password:** Retrieve the initial admin password using:
    
    ```plaintext
    cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
    
6. **Install Plugins and Create User:** Install recommended plugins and create a user for Jenkins login.
    

### Integrating Git and Maven with Jenkins

1. **Create a New Jenkins Job:**
    
    * Name: NETFLIX JOB
        
    * Type: Freestyle
        
    * Click "OK"
        
2. **Configure Source Code Management:**
    
    * Choose Git
        
    * Repository URL: [`https://github.com/devopsbyraham/jenkins-java-project.git`](https://github.com/devopsbyraham/jenkins-java-project.git)
        
3. **Define Build Steps:**
    
    * Add Build Step &gt; Execute Shell
        
    * Define shell commands for building and testing your project.
        

### Conclusion

Jenkins simplifies CI/CD pipelines, enabling teams to automate software delivery processes and accelerate development cycles. By integrating with Git and Maven, Jenkins facilitates seamless code management and deployment. Embrace Jenkins to streamline your development workflows and enhance team collaboration. Happy automating!