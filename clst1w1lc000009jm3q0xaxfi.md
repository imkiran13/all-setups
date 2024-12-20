---
title: "Jenkins Master-Slave Configuration and Linked Jobs"
datePublished: Mon Feb 19 2024 14:47:25 GMT+0000 (Coordinated Universal Time)
cuid: clst1w1lc000009jm3q0xaxfi
slug: jenkins-master-slave-configuration-and-linked-jobs

---

### Introduction

In Jenkins, configuring a master-slave setup helps distribute the build load, reducing strain on the Jenkins server. Slaves are additional servers that execute build jobs, and communication between the master and slaves occurs via SSH. This guide outlines the setup process for a master-slave architecture and introduces linked jobs for streamlined workflows.

### Setting Up a Jenkins Slave

### **Install Java and Required Tools**

On the slave server, install Java 11, Java 8, Git, and Maven:

```plaintext
sudo apt install openjdk-11-jre git maven openjdk-8-jre -y
```

### Configure the Slave Server

1. Go to the Jenkins master dashboard:
    
    * Dashboard &gt; Manage Jenkins &gt; Nodes & Clouds &gt; New Node.
        
2. Enter a node name (e.g., "abc") and select "Permanent Agent."
    
3. Configure the node settings:
    
    * Number of Executors: 3
        
    * Remote Root Directory: /tmp (output storage on the slave server)
        
    * Labels: swiggy (assign jobs to a specific slave)
        
    * Usage: Select the last option.
        
    * Launch Method: Select the last option.
        
    * Host: Enter the private IP of the slave server.
        
    * Credentials: Add Jenkins credentials with SSH username and private key.
        
    * Host Key Verification Strategy: Select the last option.
        
4. Save the configuration.
    

### Configuring Jobs on the Slave

1. In the Jenkins master dashboard, go to the job configuration:
    
    * Dashboard &gt; Job &gt; Configure.
        
2. Restrict where this job runs:
    
    * Label Expression: SLAVE1 (or the label assigned to the slave).
        
3. Save the configuration.
    

Repeat the same procedure for additional slaves if needed.

### Linked Jobs

Linked jobs in Jenkins allow the automation of sequential processes.

### Upstream Job

1. Create Job 1 (e.g., Netflix job).
    
2. Configure Job 1:
    
    * Post Build Actions &gt; Build other projects &gt; Name of Job 2 (e.g., Deployment job).
        
3. Save the configuration.
    

### Downstream Job

Job 2 (Deployment job) will automatically start after Job 1 completes.

**Note:** Linked jobs are typically used for continuous integration and deployment workflows.

### Conclusion

Configuring a Jenkins master-slave setup enhances scalability and performance by distributing build tasks across multiple servers. Utilizing linked jobs further streamlines continuous integration and deployment processes, allowing for efficient automation and collaboration in a DevOps environment. Experiment with these configurations to tailor them to your specific project requirements. Happy building!