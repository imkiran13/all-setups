---
title: "Scheduling and Automating Builds in Jenkins"
datePublished: Mon Feb 19 2024 14:01:35 GMT+0000 (Coordinated Universal Time)
cuid: clst093jz000809lfhi6aglkw
slug: scheduling-and-automating-builds-in-jenkins

---

### Introduction

Efficient job scheduling is the backbone of a streamlined development pipeline in Jenkins. In this guide, we'll walk through the essential steps of utilizing CronJobs, Poll SCM, Webhooks, Throttle Builds, and Remote Build Triggers.

### Understanding CronJob Syntax

1. **Cron Syntax Basics:**
    
    * The cron syntax "\* *"* represents minutes, hours, date, month, and day, separated by spaces.
        
    * Each asterisk signifies a wildcard, allowing for flexibility in scheduling.
        
    * Important note: This operates on server time, typically in UTC.
        
2. **Breakdown of Stars:**
    
    * \*: minutes
        
    * \*: hours
        
    * \*: date
        
    * \*: month
        
    * \*: day (0=sun 1=mon ----)
        
3. **Example:**
    
    * "5 11 8 9 5" translates to 11:05 AM on September 8, 2023 (a Friday).
        

### Creating a CI Job with Cron

1. **Navigate to Build Triggers:**
    
    * Go to your Jenkins job configuration and find the "Build Triggers" section.
        
2. **Select "Build periodically":**
    
    * Choose the "Build periodically" option to set up a scheduled build.
        
3. **Input Cron Expression:**
    
    * Enter the desired Cron expression (e.g., "\* *"*).
        
    * **Note:** This method doesn't check for code changes and may create unnecessary build files.
        

### Poll SCM for Code Changes

1. **Configure Poll SCM:**
    
    * In Build Triggers, choose "Poll SCM" to trigger builds only when the code changes.
        
    * Set a time limit for the system to check for modifications.
        
2. **Set Cron Expression:**
    
    * Input a Cron expression for Poll SCM (e.g., "\* *"*).
        
    * **Limitation:** Builds are dependent on code changes within the specified time, potentially leading to wasted builds.
        

### Leveraging Webhooks for Instantaneous Builds

1. **Configure Webhooks in GitHub:**
    
    * In your GitHub repository settings, navigate to webhooks.
        
    * Add a webhook with the Payload URL pointing to your Jenkins server.
        
2. **Jenkins Configuration:**
    
    * In the Jenkins CI Job, enable "GitHub hook trigger for GITScm polling" under Build Triggers.
        
    * This ensures builds are triggered immediately upon code commit.
        

### Throttle Builds for Controlled Performance

1. **Create a Throttle Build Job:**
    
    * Generate a job and navigate to "Throttle builds" in Jenkins.
        
    * Set the maximum number of builds and the time period to restrict builds per interval.
        

### Triggering Builds Remotely

1. **Enable Remote Build Trigger:**
    
    * To initiate builds remotely, configure the "Trigger build remotely" option in your Jenkins job.
        
    * Hit the provided URL to start the build when you're away from your primary development setup.
        

### Conclusion

Mastering Jenkins job scheduling empowers developers to create a seamless and efficient development pipeline. By strategically using CronJobs, Poll SCM, Webhooks, Throttle Builds, and Remote Build Triggers, teams can ensure optimal resource utilization and minimize downtime in their development workflows.