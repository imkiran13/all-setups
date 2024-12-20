---
title: "Mastering Jenkins Variables: A Comprehensive Guide"
datePublished: Tue Feb 20 2024 05:10:53 GMT+0000 (Coordinated Universal Time)
cuid: clstwqhbd000008jucko6bmxz
slug: mastering-jenkins-variables-a-comprehensive-guide

---

## **Introduction**

In Jenkins, variables play a crucial role in customizing and enhancing your pipeline workflows. This guide will explore different types of variables—User Defined, Global, and Jenkins Environment Variables—and provide examples of how to assign and use them effectively within your Jenkins pipelines.

### User Defined Variables

### Local Variables (Inside Job)

```plaintext
groovyCopy codepipeline {
    agent any 
    
    environment {
        name = "kiran"
        city = "satara"
    }
    stages {
        stage('one') {
            steps {
                echo "Hello! My name is $name, and I'm from $city"
            }
        }
    }
}
```

### Global Variables (Outside Job)

```plaintext
groovyCopy codepipeline {
    agent any 
    environment {
        name = "kiran"
        city = "satara"
    }
    stages {
        stage('one') {
            steps {
                echo "Hello! My name is $name, and my city is $city"
            }
        }
    }
}
```

### Jenkins Environment Variables

These variables change dynamically based on the build.

**Passing Variables in Pipeline**

```plaintext
groovyCopy codepipeline {
    agent any 
    
    environment {
        name = "kiran"
        loc = "satara"
    }
    stages {
        stage('one') {
            steps {
                echo "Hello! My name is $name, and I'm from $loc"
                sh 'env' // Displays Jenkins environment variables
            }
        }
    }
}
```

### Conclusion

Understanding and effectively using variables in Jenkins pipelines are essential skills for optimizing and customizing your CI/CD workflows. Whether it's user-defined local or global variables or dynamic Jenkins environment variables, leveraging them strategically enhances the flexibility and efficiency of your Jenkins pipelines. Mastering these variable types will empower you to tailor your pipelines to specific needs, providing a robust and adaptable automation environment.