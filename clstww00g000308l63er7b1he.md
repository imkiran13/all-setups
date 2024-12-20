---
title: "Harnessing Post-Build Actions in Jenkins Pipelines"
datePublished: Tue Feb 20 2024 05:15:11 GMT+0000 (Coordinated Universal Time)
cuid: clstww00g000308l63er7b1he
slug: harnessing-post-build-actions-in-jenkins-pipelines

---

Post-build actions in Jenkins pipelines enable you to perform specific tasks or take actions after the completion of a build. This guide explores the usage of post-build actions, particularly focusing on the "always," "success," and "failure" options.

### Jenkins Pipeline with Post-Build Actions

```plaintext
groovyCopy codepipeline {
    agent any 
    
    environment {
        name = "raham"
        loc = "hyderabad"
    }
    stages {
        stage('one') {
            steps {
                sh 'env'
            }
        }
    }
    post {
        always {
            echo "Post-build action: The build is done, regardless of success or failure."
            // Add additional post-build actions here
        }
        success {
            echo "Post-build action: This will execute only if the build is successful."
            // Add success-specific post-build actions here
        }
        failure {
            echo "Post-build action: This will execute only if the build fails."
            // Add failure-specific post-build actions here
        }
    }
}
```

### Explanation

* **always:**
    
    * The block within `always` will execute whether the build succeeds or fails.
        
    * Use this for actions that need to occur regardless of the build result.
        
* **success:**
    
    * The block within `success` will execute only if the build is successful.
        
    * Ideal for actions that should occur specifically when the build is successful.
        
* **failure:**
    
    * The block within `failure` will execute only if the build fails.
        
    * Useful for actions tailored to failure scenarios.
        

### Conclusion

Post-build actions provide a powerful mechanism to execute specific tasks after a Jenkins pipeline build. Whether you need actions to occur always, only on success, or only on failure, utilizing post-build actions enhances the flexibility and customization of your Jenkins pipeline workflows. Mastering these options allows you to tailor your automation to respond precisely to different build outcomes.