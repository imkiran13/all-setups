---
title: "Setting Up Tomcat for Jenkins Deployment: A Comprehensive Guide"
datePublished: Tue Feb 20 2024 05:25:05 GMT+0000 (Coordinated Universal Time)
cuid: clstx8q5p000f0ajx023t83e6
slug: setting-up-tomcat-for-jenkins-deployment-a-comprehensive-guide

---

### Tomcat Setup

1. Download Tomcat:
    
    ```plaintext
    wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.83/bin/apache-tomcat-9.0.83.tar.gz
    ```
    
2. Extract Tomcat:
    
    ```plaintext
    tar -zxvf apache-tomcat-9.0.83.tar.gz
    ```
    
3. Configure `tomcat-users.xml`:
    
    ```plaintext
    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <user username="tomcat" password="12345" roles="manager-gui, manager-script"/>
    ```
    
4. Modify `context.xml`:
    
    ```plaintext
    vim apache-tomcat-9.0.83/webapps/manager/META-INF/context.xml
    # Delete lines 21 and 22
    ```
    
5. Start Tomcat:
    
    ```plaintext
    sh apache-tomcat-9.0.83/bin/startup.sh
    ```
    
6. Access Tomcat on the public IP: `http://<public-ip>:8080`
    
7. Change tomcat server port
    
    vim /root/apache-tomcat-9.0.80/conf/server.xml
    
    sh /root/apache-tomcat-9.0.80/bin/[startup.sh](http://startup.sh)
    
    sh /root/apache-tomcat-9.0.80/bin/[shutdown.sh](http://shutdown.sh)
    

### Jenkins Integration with Tomcat

1. In Jenkins, go to **Dashboard** &gt; **Manage Jenkins** &gt; **Credentials** &gt; **System** &gt; **Global credentials (unrestricted)**.
    
2. Add credentials for Tomcat (username and password).
    
3. Download Jenkins Tomcat Plugin:
    
    * **Dashboard** &gt; **Manage Jenkins** &gt; **Manage Plugins** &gt; **Available** &gt; Search for "Deploy to container" &gt; Install.
        
4. Configure Jenkins Job:
    

```plaintext
pipeline {
    agent {
        label 'slave1'
    }
    
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
                     -Dsonar.projectKey=project-netflix \
                     -Dsonar.host.url=http://52.47.193.26:9000 \
                     -Dsonar.login=54f6a0567ef5a12acda5eecee7ce51e0feb16bb1
                '''
            }
        }
        stage('artifact') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('deploy') {
            steps {
                deploy adapters:[
                    tomcat9(
                        credentialsId: 'your-tomcat-credentials-id',
                        path: '',
                        url: 'http://<public-ip>:8080/'
                        )
                    ],
                    contextPath: 'netflix',
                    war: 'target/*.war'
            }
        }
    }
}
```

### Troubleshooting Techniques

**1\. Server Level:**

* Check Console Output.
    
* Verify Maven and Java installations.
    
* Review dependencies.
    

**2\. Job Level:**

* Verify repository and branch configurations.
    
* Double-check syntax.
    
* Ensure plugins are correctly installed.
    

### Conclusion

Setting up Tomcat for Jenkins deployment enhances your continuous integration and deployment capabilities. By integrating the Tomcat server with Jenkins and using the Deploy to Container plugin, you can seamlessly deploy your Java applications. Troubleshooting techniques at both server and job levels ensure a smooth and reliable deployment process.