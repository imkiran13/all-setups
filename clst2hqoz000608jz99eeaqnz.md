---
title: "Understanding Jenkins Pipelines: A Comprehensive Guide"
datePublished: Mon Feb 19 2024 15:04:17 GMT+0000 (Coordinated Universal Time)
cuid: clst2hqoz000608jz99eeaqnz
slug: understanding-jenkins-pipelines-a-comprehensive-guide

---

Jenkins Pipelines play a pivotal role in orchestrating software delivery workflows, providing a step-by-step execution of processes with interconnected events. In this blog post, we'll delve into the essence of pipelines, the syntax they employ, and the two main types: Scripted and Declarative Pipelines.

### Understanding Jenkins Pipelines

At its core, a pipeline is a visual representation of the sequence of events involved in the software development lifecycle. It outlines the journey from code creation to deployment, bringing clarity and automation to the entire process.

### Key Concepts

* **Pipeline:** The overarching structure that delineates the entire workflow.
    
* **Agent:** The designated machine where the pipeline will run.
    
* **Stages:** Logical segments that divide the pipeline into distinct phases.
    
* **Stage:** A specific step or phase within a pipeline.
    
* **Steps:** Individual actions or commands executed within a stage.
    

### Pipeline Types

1. **Scripted Pipeline:**
    
    * Utilizes the Groovy scripting language.
        
    * Offers a high degree of flexibility and control.
        
    * Ideal for intricate and conditional workflows.
        
2. **Declarative Pipeline:**
    
    * Simplifies pipeline syntax for easier readability.
        
    * Implements a domain-specific language (DSL) for concise script creation.
        
    * Provides visualizations of the process execution.
        

### Declarative Pipeline Examples

#### Single Stage Pipeline

```plaintext
pipeline {
    agent any
    
    stages {
        stage('abc') {
            steps {
                sh 'touch file2'
            }
        }
    }
}
```

#### Multi-Stage Pipeline

```plaintext
pipeline {
    agent any
    
    stages {
        stage('abc') {
            steps {
                sh 'touch file1'
            }
        }
        stage('efg') {
            steps {
                sh 'touch file2'
            }
        }
    }
}
```

### CI Pipeline Example

```plaintext
pipeline {
    agent any 
    
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
        stage('artifact') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
```

### Pipeline as Code Examples

#### Single-Stage Pipeline as Code

```plaintext
pipeline {
    agent any
    
    stages {
        stage('one') {
            steps {
                git 'https://github.com/devopsbyraham/jenkins-java-project.git'
                sh 'mvn compile'
                sh 'mvn test'
                sh 'mvn clean package'
            }
        }
    }
}
```

#### Multi-Stage Pipeline as Code

```plaintext
pipeline {
    agent any
    
    stages {
        stage('one') {
            steps {
                git 'https://github.com/devopsbyraham/jenkins-java-project.git'
                sh 'mvn compile'
            }
        }
        stage('two') {
            steps {
                sh 'mvn test'
                sh 'mvn clean package'
            }
        }
    }
}
```

#### Single-Shell Pipeline as Code

```plaintext
pipeline {
    agent any
    
    stages {
        stage('one') {
            steps {
                git 'https://github.com/devopsbyraham/jenkins-java-project.git'
                sh '''
                mvn compile
                mvn test
                mvn package
                mvn install
                mvn clean package
                '''
            }
        }
    }
}
```

In conclusion, Jenkins Pipelines, whether scripted or declarative, empower developers by visualizing and automating the intricate steps involved in software delivery. The flexibility offered by scripted pipelines and the readability of declarative pipelines make them indispensable tools in modern DevOps practices.