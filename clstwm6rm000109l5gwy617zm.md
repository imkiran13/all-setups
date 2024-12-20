---
title: "Setting Up SonarQube for Code Quality Checks"
datePublished: Tue Feb 20 2024 05:07:33 GMT+0000 (Coordinated Universal Time)
cuid: clstwm6rm000109l5gwy617zm
slug: setting-up-sonarqube-for-code-quality-checks

---

### Introduction

SonarQube is a powerful tool designed to assess and improve code quality. It analyzes code for bugs, vulnerabilities, code duplications, and code smells across a multitude of programming languages. In this guide, we'll walk through the setup of SonarQube, including the installation, configuration, and integration into a Jenkins pipeline for continuous code quality checks.

### Setup

**Launching an Instance**

* **Instance Type:** t2.medium
    
* **Port:** 9000
    
* **Dependency:** Java-11
    

**Installation Script**

```plaintext
#! /bin/bash

# Launch an instance with 9000 and t2.medium
cd /opt/
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
sudo apt install unzip openjdk-11-jre -y
unzip sonarqube-8.9.6.50800.zip
sudo useradd -r sonarqube -s /bin/false
sudo chown sonarqube:sonarqube sonarqube-8.9.6.50800 -R
sudo chmod 777 sonarqube-8.9.6.50800 -R

# Add sonarqube to the system's PATH
echo "export PATH=\$PATH:/opt/sonarqube-8.9.6.50800/bin/linux-x86-64" | sudo tee -a /etc/profile
. /etc/profile

# Start SonarQube
sudo su - sonarqube -s /bin/bash -c "/opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start"

#echo "user=admin & password=admin"

after login -- > add project -- > manual -- > project key -- > netlfix -- > setup -- > token -- > netflix -- > generate -- > continue -- > maven 
```

### Jenkins Pipeline

```plaintext
pipeline {
    agent any
    
    stages {
        stage('checkout') {
            steps {
                git 'https://github.com/devopsbyraham/jenkins-java-project.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('code quality') {
            steps {
                sh '''
                mvn sonar:sonar \
                  -Dsonar.projectKey=netflix \
                  -Dsonar.host.url=http://13.38.32.159:9000 \
                  -Dsonar.login=3f017506d83cd334fba02ecf9db706c429ab5d38
                '''
            }
        }
        stage('artifact') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
```

### Jenkins Pipeline Execution on Slave

```plaintext
pipeline {
    agent {
        label 'slave1'
    } 
    // ...
    // Add your pipeline stages here
    // ...
}
```

## **Conclusion**

Setting up SonarQube for code quality checks enhances the development process by identifying and addressing issues early in the development lifecycle. Integrating SonarQube into a Jenkins pipeline ensures continuous monitoring and improvement of code quality, contributing to the creation of robust and reliable software.