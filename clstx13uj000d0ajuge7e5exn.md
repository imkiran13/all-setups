---
title: "Mastering RBAC (Role-Based Access Control) in Jenkins"
datePublished: Tue Feb 20 2024 05:19:09 GMT+0000 (Coordinated Universal Time)
cuid: clstx13uj000d0ajuge7e5exn
slug: mastering-rbac-role-based-access-control-in-jenkins

---

### Introduction

In real-world Jenkins setups, security is paramount. RBAC (Role-Based Access Control) provides a robust solution to restrict access and define specific permissions for users. This guide walks you through setting up RBAC in Jenkins, creating users, installing the Role-based Authorization Strategy plugin, configuring security settings, and managing and assigning roles.

### Step 1: Creating Users

**Navigate to Dashboard &gt; Manage Jenkins &gt; Manage Users.**

1. Create users, for example, Ramesh and Suresh.
    

### Step 2: Installing RBAC Plugin

1. Go to Dashboard &gt; Manage Jenkins &gt; Manage Plugins.
    
2. In the "Available" tab, search for "Role-based Authorization Strategy" and install it.
    

### Step 3: Configuring Security

**Go to Dashboard &gt; Manage Jenkins &gt; Configure Global Security.**

1. Under **Authorization**, select **Role-Based Authorization Strategy**.
    
2. Save the configuration.
    

### Step 4: Managing and Assigning Roles

1. Go to Dashboard &gt; Manage Jenkins &gt; Manage and Assign Roles.
    
2. Manage roles, creating, for example:
    
    * Role 1: "fresher" with permissions limited to "read."
        
    * Role 2: "exp" with admin permissions.
        
3. Assign roles accordingly.
    

### Step 5: Testing RBAC Setup

1. Open a new browser window or use incognito mode.
    
2. Log in with the created users, Ramesh and Suresh.
    
    * Ramesh, with admin access and experience, should be able to build pipelines.
        
    * Suresh, with read-only access and as a fresher, should not be able to build or run pipelines.
        

### Conclusion

Implementing RBAC in Jenkins enhances security by allowing you to define granular permissions for users. By creating roles and assigning them specific permissions, you ensure that users have access only to what is necessary for their roles. This approach not only enhances security but also streamlines and optimizes user interactions with the Jenkins environment.