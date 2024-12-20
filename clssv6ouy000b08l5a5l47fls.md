---
title: "Resolving Merge Conflicts, Cherry-Picking, and Key Interview Questions"
datePublished: Mon Feb 19 2024 11:39:44 GMT+0000 (Coordinated Universal Time)
cuid: clssv6ouy000b08l5a5l47fls
slug: resolving-merge-conflicts-cherry-picking-and-key-interview-questions

---

### **Understanding Merge Conflicts in Git**

Merge conflicts occur when Git attempts to combine changes from different branches that modify the same file in different ways. Resolving conflicts requires manual intervention. Here's a brief guide on resolving conflicts:

1. **Identify Conflicts:**
    
    * When merging branches with conflicting changes, Git marks the conflicted areas in the affected files.
        
2. **Manually Resolve:**
    
    * Open the conflicted file(s) in your code editor.
        
    * Locate and resolve the conflicting sections, keeping the changes you want.
        
3. **Mark as Resolved:**
    
    * After manual resolution, mark the conflicts as resolved using:
        
        ```plaintext
        git add <conflicted_file>
        ```
        
4. **Complete Merge:**
    
    * Continue the merge process:
        
        ```plaintext
        git merge <branch_name>
        ```
        

### **Cherry-Picking Specific Commits**

Cherry-picking allows you to apply specific commits from one branch to another. It is useful when you want to merge specific changes without merging an entire branch. Use the following command:

```plaintext
git cherry-pick <commit_id>
```

This applies the changes introduced by the specified commit to your current branch.

### **Git Show and Commit History**

The `git show` command helps you inspect the details of a specific commit or the changes introduced by it. For example:

```plaintext
git show <commit_id>
```

To view the commit history, you can use:

```plaintext
git log --patch     # Display changes for each commit
git log --stat      # Display concise statistics for each commit
```

### **Reverting Merges**

If you need to undo a merge, you can use the `git revert` command. It creates a new commit that undoes the changes introduced by the specified merge commit:

```plaintext
git revert <merge_commit_id>
```

### **Interview Questions**

1. **What is Git and why use it?**
    
    * Git is a distributed version control system used to track changes in source code during software development, facilitating collaboration among multiple contributors.
        
2. **Explain the stages of Git.**
    
    * The three stages are Working Directory, Staging Area, and Repository. Changes progress from the working directory to the staging area and then to the repository.
        
3. **Difference between CVCS and DVCS?**
    
    * Centralized Version Control System (CVCS) has a central repository, while Distributed Version Control System (DVCS) allows each user to have a complete copy of the repository.
        
4. **How to check commits in Git?**
    
    * Use `git log` to view commit history.
        
5. **Explain branches.**
    
    * Branches in Git are independent lines of development that allow for parallel work on different features or fixes.
        
6. **What is .gitignore?**
    
    * `.gitignore` is a file specifying patterns of untracked files that Git should ignore.
        
7. **Difference between git pull vs git push?**
    
    * `git pull` fetches changes from a remote repository and merges them into the current branch, while `git push` sends local changes to a remote repository.
        
8. **Difference between git pull vs git fetch?**
    
    * `git pull` fetches changes and merges them, whereas `git fetch` fetches changes but does not merge them.
        
9. **Difference between git merge vs git rebase?**
    
    * `git merge` combines changes from different branches, creating a new commit, while `git rebase` moves or combines a sequence of commits to a new base commit.
        
10. **Difference between git merge vs git cherry-pick?**
    
    * `git merge` combines all changes from one branch into another, while `git cherry-pick` applies specific commits from one branch to another.
        
11. **Difference between git clone vs git pull?**
    
    * `git clone` copies a repository to create a local copy, while `git pull` fetches changes from a remote repository and merges them.
        
12. **Difference between git clone vs git fork?**
    
    * `git clone` creates a local copy of a repository, while `git fork` creates a personal copy of a repository on a platform like GitHub.
        
13. **Difference between git revert vs git restore?**
    
    * `git revert` creates a new commit that undoes changes, while `git restore` discards changes in the working directory.
        
14. **What is a merge conflict, and how do you resolve it?**
    
    * A merge conflict occurs when Git cannot automatically merge changes. To resolve, manually edit the conflicted file, mark as resolved with `git add`, and complete the merge.
        
15. **What is git stash?**
    
    * Git stash is a feature to temporarily hide changes that are not yet committed, allowing you to switch branches or perform other operations without committing incomplete changes.