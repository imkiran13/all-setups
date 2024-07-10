#!/bin/bash
# Launch an instance with SonarQube on port 9000 with t2.medium instance type

# Update package list and install necessary packages
sudo apt-get update
sudo apt-get install -y wget unzip openjdk-11-jdk

# Download and extract SonarQube
cd /opt/
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
sudo unzip sonarqube-8.9.6.50800.zip

# Create sonar user and set permissions
sudo useradd sonar
sudo chown sonar:sonar sonarqube-8.9.6.50800 -R
sudo chmod 777 sonarqube-8.9.6.50800 -R

# Switch to sonar user
sudo su - sonar -c "/opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start"

echo "SonarQube installation is complete."
echo "You can access SonarQube on port 9000."
echo "Default username is 'admin' and password is 'admin'."
