---
title: "DevOps Software Installations on Ubuntu"
datePublished: Mon Feb 19 2024 07:49:42 GMT+0000 (Coordinated Universal Time)
cuid: clssmyvgl000s09jrc6iw7ds6
slug: devops-software-installations-on-ubuntu

---

### Introduction

Setting up a DevOps environment involves installing various software components to create a robust infrastructure. This blog will guide you through the installation of web servers, application servers, and databases on an Ubuntu system, covering essential commands and configurations.

### **Web Server Installation**

1. **Apache2 on Ubuntu:**
    
    ```plaintext
    sudo apt update
    sudo apt install apache2 -y
    cd /var/www/html
    sudo git clone https://github.com/CleverProgrammers/pwj-netflix-clone.git
    sudo mv pwj-netflix-clone/* .
    sudo apt purge apache2* -y
    ```
    
2. **Nginx on Ubuntu:**
    
    ```plaintext
    sudo apt update
    sudo apt install nginx -y 
    cat /etc/nginx/nginx.conf 
    cat /var/log/nginx/access.log
    ```
    

### **Application Server Installation**

Java, a versatile programming language and computing platform, has played a pivotal role in shaping today's digital landscape. This blog will guide you through the installation of Java on an Ubuntu system, providing essential commands and a simple example to get you started.

**Why Install Java?**

1. Many applications and websites rely on Java for their functionality. The Java Virtual Machine (JVM) is a key component, seamlessly running Java applications. Let's dive into the installation process.
    
    **Installation Commands:**
    
    1. Switch to the superuser to perform administrative tasks:
        
        ```plaintext
        sudo su -
        ```
        
    2. Update the package list:
        
        ```plaintext
        sudo apt-get update -y
        ```
        
    3. Install the default Java Runtime Environment (JRE):
        
        ```plaintext
        sudo apt-get install default-jre -y
        ```
        
    4. Install the default Java Development Kit (JDK):
        
        ```plaintext
        sudo apt-get install default-jdk -y
        ```
        
    5. Check the Java version to confirm the installation:
        
        ```plaintext
        java -version
        ```
        
    6. Install Vim, a text editor, for configuration:
        
        ```plaintext
        sudo apt install vim -y
        ```
        
    7. Open the configuration file for Java:
        
        ```plaintext
        sudo vim /etc/profile.d/jdk11.sh
        ```
        
    8. Add the following lines to set the JAVA\_HOME and update the PATH:
        
        ```plaintext
        export JAVA_HOME="/usr/lib/jvm/jdk-11.0.10"
        export PATH="$PATH:${JAVA_HOME}/bin"
        ```
        
    9. Reboot the system to apply the changes:
        
        ```plaintext
        reboot
        ```
        
    10. Verify the PATH and JAVA\_HOME:
        
        ```plaintext
        echo $PATH
        echo $JAVA_HOME
        ```
        
    
    **Example: Hello, World! in Java**
    
    Let's create a simple Java program to ensure everything is set up correctly.
    
    ```plaintext
    class Simple {
        public static void main(String[] args) {
            System.out.println("Hello, World!"); 
        }
    }
    ```
    
    1. Compile the Java program:
        
        ```plaintext
        javac Simple.java
        ```
        
    2. Execute the compiled program:
        
        ```plaintext
        java Simple
        ```
        
    
    **Python Installation on Ubuntu**  
    
    **Why Install Python?**
    
    Python is widely used for various applications, including web development, data analysis, machine learning, and more. Installing Python on your system allows you to harness the power of this versatile language.  
    
    **Installation Commands**
    
    1. Update the package list:
        
        ```plaintext
        sudo apt-get update -y
        ```
        
    2. Install Python 3:
        
        ```plaintext
        sudo apt-get install python3 -y 
        ```
        
    3. Install Python package manager (pip):
        
        ```plaintext
        sudo apt install python3-pip -y
        ```
        
    4. Install NumPy and Pandas using pip:
        
        ```plaintext
        pip install NumPy
        pip install Pandas
        ```
        
    
    **Running a Basic Python Program:**
    
    1. Access the Python environment:
        
        ```plaintext
        python3
        ```
        
        This will take you to the Python interactive shell where you can write and execute Python code.
        
    2. Write a simple Python program:
        
        ```plaintext
        print("hi")
        ```
        
    3. To exit from the Python interactive shell, type:
        
        ```plaintext
        exit()
        ```
        
    
    Example: Hello, World! in Python
    
    Let's create a simple Python script to print "Hello, World!"
    
    ```plaintext
    # Save this code in a file, e.g., hello.py
    print("Hello, World!")
    ```
    
    To run the script:
    
    ```plaintext
    python3 hello.py
    ```
    
    **Node.js Installation on Ubuntu**
    
    **Why Install Node.js?**
    
    Node.js allows developers to use JavaScript for both client-side and server-side scripting. It is widely used for building scalable network applications and is an essential tool in modern web development.
    
    **Installation Commands:**
    
    1. Install Node.js using the package manager:
        
        ```plaintext
        sudo apt install nodejs -y
        ```
        
        Alternatively, you can use the following commands to install the latest version:
        
        ```plaintext
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
        sudo apt-get install -y nodejs
        ```
        
    2. Verify the installation by checking the Node.js version:
        
        ```plaintext
        node -v
        ```
        
        This should display the installed Node.js version.
        
    
    **Running a Basic Node.js Script:**
    
    1. To run a basic Node.js script, use the following command:
        
        ```plaintext
        nodejs
        ```
        
        This takes you to the Node.js interactive shell.
        
    2. Write a simple Node.js script:
        
        ```plaintext
        console.log("Hello, World!");
        ```
        
        This will print "Hello, World!" to the console.
        
    3. To exit the Node.js interactive shell, type:
        
        ```plaintext
         code.exit
        ```
        
    
    Example: Hello, World! in Node.js
    
    Let's create a simple Node.js script to print "Hello, World!"
    
    ```plaintext
    // Save this code in a file, e.g., hello.js
    console.log("Hello, World!");
    ```
    
    To run the script:
    
    ```plaintext
    bashCopy codenodejs hello.js
    ```
    

### **Database Server Installation**

1. **ArangoDB Installation:**
    
    ```plaintext
    echo 'deb https://download.arangodb.com/arangodb34/DEBIAN/ /' | sudo tee /etc/apt/sources.list.d/arangodb.list
    wget -q https://download.arangodb.com/arangodb34/DEBIAN/Release.key -O- | sudo apt-key add -
    sudo apt update -y
    sudo apt -y install apt-transport-https
    sudo apt -y install arangodb3
    sudo systemctl start arangodb3
    sudo systemctl status arangodb3
    vim /etc/arangodb3/arangod.conf
    # Copy private IP of the instance
    systemctl restart arangodb3
    sudo arangosh
    ```
    
2. **MySQL Installation:**
    
    ```plaintext
    wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
    sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
    percona-release setup ps80
    sudo apt install percona-server-server -y
    mysql -u root -p
    ```
    

### Conclusion

This comprehensive guide provides step-by-step instructions for installing essential DevOps software on an Ubuntu system. Whether you're setting up web servers, application servers, or databases, following these commands and configurations will pave the way for a robust and efficient DevOps environment. Happy coding!