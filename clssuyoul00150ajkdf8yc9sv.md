---
title: "Mastering Git: A Guide to Configuration, Branches, and Essential Commands"
datePublished: Mon Feb 19 2024 11:33:31 GMT+0000 (Coordinated Universal Time)
cuid: clssuyoul00150ajkdf8yc9sv
slug: mastering-git-a-guide-to-configuration-branches-and-essential-commands
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1731606021594/c26d6841-235b-4575-b756-0fae9edfbeba.webp

---

Git, the distributed version control system, is a powerful tool that enables collaborative development and tracking of changes in source code. In this guide, we'll explore key aspects of configuring user information, working with branches, and essential Git commands.

### **Configuring User and Email**

Setting up your user and email information in Git is crucial for accurately attributing commits. Use the following commands to configure your user name and email:

```plaintext
git config user.name "kiran"
git config user.email "imkiran13@gmail.com"
```

It's important to note that these settings will be associated with new commits only.

### **Git Show and Git Log**

Understanding the history of your Git repository is essential. The `git show` command allows you to display information about a specific commit, while `git log` provides a comprehensive history of commits. Here's an example:

```plaintext
git log --oneline
git show <commit_id>
```

These commands provide insights into the commit history and the changes associated with a particular commit.

### **Branches in Git**

Branching is a fundamental concept in Git, allowing developers to work on different features or fixes concurrently. The default branch is usually named "master." Here are some essential branch-related commands:

```plaintext
git branch                   # List branches
git branch movies            # Create a branch named 'movies'
git checkout movies          # Switch to the 'movies' branch
git checkout -b dth          # Create and switch to 'dth' branch
git branch -m old new         # Rename a branch
git branch -D recharge        # Delete a branch
```

Remember that the default branch is created upon the initial commit.

### **Git Pull**

Use `git pull` to fetch and merge changes from a remote repository into your current branch. For example:

```plaintext
git pull origin recharge
git checkout recharge

PROCESS:
git branch movies
git checkout movies
touch movies{1..5}
git add movies*
git commit -m "dev-1" movies*
```

This ensures your local branch is updated with changes from the remote repository.

### **Pushing Code to GitHub**

After making changes locally, it's time to push your code to a remote repository on GitHub. Here's a basic workflow:

Make sure to add a remote repository using:

```plaintext
git remote add origin https://github.com/nayakdebasish091/paytm.git
```

```plaintext
git push origin movies       # Push the 'movies' branch to GitHub
```

### **Token Generation for GitHub**

GitHub now requires a personal access token (PAT) for authentication. Follow these steps to generate a token:

1. Go to GitHub Settings &gt; Developer settings &gt; Personal access tokens.
    
2. Click "Generate new token."
    
3. Provide a name and select the required permissions.
    
4. Generate the token and keep it secure, as it will be visible only once.
    

### **Git Ignore and Restore**

The `.gitignore` file allows you to specify files that Git should ignore. For instance:

```plaintext
touch java{1..5}
vim .gitignore
j* -- > :wq
git status
```

This prevents Git from tracking files matching the specified pattern.

Use `git restore` to untrack staged files:

### **Recovering Deleted Files**

Git allows the restoration of tracked (staged) files. If a file is accidentally deleted, follow these steps:

Note: we can restore only tracked files(staged one).

```plaintext
# Assuming the file was staged before deletion
touch kiran
git status
git add
git status
git restore --staged kiran
git status
git restore kiran
```

Mastering these Git commands and concepts empowers developers to efficiently manage their codebase, collaborate seamlessly, and maintain a robust version control workflow. Whether configuring user information, working with branches, or utilizing essential commands, Git provides a flexible and powerful environment for version control.