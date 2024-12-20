---
title: "Exploring OWASP Dependency Check in Jenkins: A Step-by-Step Guide"
datePublished: Tue Feb 20 2024 05:38:23 GMT+0000 (Coordinated Universal Time)
cuid: clstxpues000109l6g906h72w
slug: exploring-owasp-dependency-check-in-jenkins-a-step-by-step-guide

---

### Overview

OWASP Dependency Check is a crucial tool in the realm of software composition analysis, aiding in the identification of project dependencies with known vulnerabilities. This guide provides step-by-step instructions on setting up OWASP Dependency Check in Jenkins for efficient vulnerability detection.

### Installation

1. Open Jenkins and navigate to the Jenkins home page.
    
2. Click on "Manage Jenkins" in the left-hand sidebar.
    
3. Select "Manage Plugins" from the options.
    
4. In the "Available" tab, search for "OWASP Dependency-Check Plugin" in the filter box.
    
5. Check the checkbox next to the plugin and click on the "Install without restart" button.
    
6. Once the installation is complete, go back to the Jenkins home page.
    

### Setting up OWASP Dependency Check in Jenkins

1. Click on "New Item" in the left-hand sidebar to create a new Jenkins job.
    
2. Enter a name for your job and select the type of job you want to create (e.g., Freestyle project or Pipeline).
    
3. Configure the job as per your requirements (e.g., source code management, build triggers, etc.).
    
4. Scroll down to the "Build" section and click on the "Add build step" dropdown.
    
5. Select "Invoke OWASP Dependency-Check" from the dropdown.
    
6. Configure the plugin settings according to your needs, specifying the path to your project, any additional arguments, and choosing the appropriate OWASP Dependency-Check installation.
    
7. Save the job configuration.
    
8. Before running the job, ensure you've set up the desired OWASP Dependency-Check installation in Jenkins (Go to "Manage Jenkins" &gt; "Global Tool Configuration").
    

### Installation Options for OWASP Dependency Check

**Option 1: Downloading the Standalone JAR**

* Go to the OWASP Dependency Check releases page.
    
* Download the latest version of the standalone JAR file (dependency-check.jar).
    
* Ensure you have Java 8 or higher installed on your system.
    
* Run the tool using the following command:
    
    ```plaintext
    java -jar dependency-check.jar --project <project-name> --scan <path-to-project>
    ```
    

**Option 2: Using Package Managers**

#### Maven

* Add the following plugin to your pom.xml file:
    
    ```plaintext
    <build>
      <plugins>
        <plugin>
          <groupId>org.owasp</groupId>
          <artifactId>dependency-check-maven</artifactId>
          <version>INSERT_VERSION_HERE</version>
          <executions>
            <execution>
              <goals>
                <goal>check</goal>
              </goals>
            </execution>
          </executions>
        </plugin>
      </plugins>
    </build>
    ```
    
* Run `mvn dependency-check:check` to analyze your project.
    

Usage

Once installed, run OWASP Dependency Check against your project to identify vulnerabilities:

**For the standalone JAR:**

```plaintext
java -jar dependency-check.jar --project <project-name> --scan <path-to-project>
```

**For Maven:**

```plaintext
mvn dependency-check:check
```

Make sure to replace `<project-name>` with your project's name and `<path-to-project>` with the project's directory.

### Configuration

OWASP Dependency Check offers various configuration options. Refer to the Configuration Guide for detailed information.

### Reporting

OWASP Dependency Check generates comprehensive reports about identified vulnerabilities. Reports can be found at:

* For the standalone JAR: `<path-to-project>/target/dependency-check-report.html`
    
* For Maven: `<path-to-project>/target/dependency-check-report.html`
    
* For Gradle: `<path-to-project>/build/reports/dependency-check-report.html`
    

Open the HTML report in your web browser to view vulnerability details.

### Resources

* [OWASP Dependency Check GitHub Repository](https://github.com/jeremylong/DependencyCheck)
    
* [OWASP Dependency Check Official Webs](https://github.com/jeremylong/DependencyCheck)[ite](https://owasp.org/www-project-dependency-check/)
    

### [Jenkins Pipeline Integration](https://github.com/jeremylong/DependencyCheck)

```plaintext
pipeline {
    agent any
    
    tools {
        jdk 'jdk11'
        maven 'maven3'
    }
    
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    
    stages {
        // ... Previous stages ...

        stage('OWASP Dependency Check') {
            steps {
                dependencyCheck additionalArguments: '--scan target/', odcInstallation: 'owasp'
            }
        }

        stage('Publish OWASP Dependency Check Report') {
            steps {
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'target',
                    reportFiles: 'dependency-check-report.html',
                    reportName: 'OWASP Dependency Check Report'
                ])
            }
        }

        // ... Subsequent stages ...
    }
}
```

Feel free to customize the pipeline according to your specific project structure and needs.