---
title: "Jenkins Parameters, Port Configuration, and Issue Resolution"
datePublished: Mon Feb 19 2024 13:59:02 GMT+0000 (Coordinated Universal Time)
cuid: clst05twj000609lf3yfw77io
slug: jenkins-parameters-port-configuration-and-issue-resolution

---

### Introduction

Jenkins offers powerful features like parameterization, allowing developers to customize and configure jobs with specific inputs. In this guide, we'll explore different parameter types, change Jenkins port settings, and address common issues related to server crashes and job deletion.

### Jenkins Parameters

Parameters enable flexibility and customization in Jenkins jobs. Here are some common parameter types:

* **Choice:** For selecting options from a list (e.g., environments: dev, test, uat, prod).
    
* **String:** For passing single-line inputs.
    
* **Multi-line String:** To pass multi-line inputs.
    
* **Boolean:** For true or false options.
    
* **File:** To handle file inputs.
    

### Example Configuration

1. Create a CI job.
    
2. Configure &gt; This project is parameterized.
    
3. Add Parameter &gt; Choice &gt; Name: `env`, Choices: `dev,test,uat,prod`.
    

### Additional Notes

* For multiple options, use the "Choice" parameter.
    
* String, Multi-line String, Boolean, and File parameters offer specific use cases.
    

### Changing Jenkins Port

To change the default port (8080) of Jenkins, follow these steps:

1. Edit the Jenkins service file:
    
    ```plaintext
    sudo vim /usr/lib/systemd/system/jenkins.service
    ```
    
2. Change the port number (e.g., from 8080 to 8090).
    
3. Reload systemd and restart Jenkins:
    
    ```plaintext
    sudo systemctl daemon-reload
    sudo systemctl restart jenkins
    ```
    
4. Verify the status:
    
    ```plaintext
    sudo systemctl status jenkins
    ```
    

### Passwordless Login and Build Limits

### Passwordless Login

If you forget your Jenkins password:

1. Edit the Jenkins configuration file:
    
    ```plaintext
    sudo vim /var/lib/jenkins/config.xml
    ```
    
2. Set `<useSecurity>false</useSecurity>`.
    
3. Restart Jenkins:
    
    ```plaintext
    sudo systemctl restart jenkins.service
    ```
    

### Changing Build Limits

1. Dashboard &gt; Manage Jenkins &gt; Nodes &gt; Built-in Node &gt; Configure.
    
2. Adjust the number of executors (e.g., set to 3).
    
3. Save the configuration.
    

### Issue Resolution: Restoring Deleted Jobs

1. Dashboard &gt; Manage Jenkins &gt; Plugins &gt; Available Plugins &gt; Job Configuration History &gt; Install.
    
2. Return to the top page.
    

Now, you can try to delete a job, and Jenkins will retain a history of job configurations, allowing you to restore deleted jobs.

### Conclusion

Understanding Jenkins parameters, configuring port settings, and addressing common issues ensures a smooth and customized CI/CD pipeline. Jenkins' flexibility and robust features make it an invaluable tool for automating software development workflows. Keep exploring and enhancing your Jenkins setup for optimal results. Happy automating!