---
title: "Lamp Stack On Aws"
datePublished: Sat Dec 14 2024 12:29:14 GMT+0000 (Coordinated Universal Time)
cuid: cm4o5m25p000209kyd5fqbnjr
slug: lamp-stack-on-aws
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1734179284720/5e392316-adf3-4fe7-8bc8-577f65b0c9c5.webp
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1734179335485/742dbe27-7e1a-43c4-b9a0-1de7a88a1f84.webp

---

## Table of Content

1. [LAMP STACK ON AWS](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#lamp-stack-on-aws)
    
2. [What Problem does LAMP stack solve?](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#what-problem-does-lamp-stack-solve)
    
3. [Deploy a LAMP stack manually on AWS](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#deploy-a-lamp-stack-manually-on-aws)
    
    * [Steps 0 - Prepare prerequisites](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#steps-0---prepare-prerequisites)
        
    * [Step 1 - Install Apache and update the firewall](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#step-1---install-apache-and-update-the-firewall)
        
    * [Step 2 - Install MySQL](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#step-2---install-mysql)
        
    * [Step 3 - Install PHP](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#step-3---install-php)
        
    * [Step 4 - Configure Apache Virtual Host](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#step-4---configure-apache-virtual-host)
        
    * [Step 5 - Enable PHP on the website](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#step-5---enable-php-on-the-website)
        
    * [Step 6 - Create PHP script to test the configuration of PHP](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#step-6---create-php-script-to-test-the-configuration-of-php)
        
4. [Conclusion](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/manual-lamp-stack.md#conclusion)
    

## What Problem does LAMP stack solve?

The LAMP stack is a framework for hosting web applications. It is based on Linux as the operating system, Apache as the web server, MySQL as the Database and PHP as the scripting language. PHP can be substituted with Python or Perl.

It provides a comprehensive and reliable platform for building and hosting a wide range of web applications, from small personal websites to large-scale enterprise applications. Despite the emergence of new technologies, LAMP is still widely in use for web development because of it's proven reliability, cost effectiveness and versatility.

## Deploy a LAMP stack manually on AWS

### Steps 0 - Prepare prerequisites

* Create an AWS Account
    
* Spin up an Ubuntu OS EC2 instance on AWS
    

If successful, The console should display your EC2 instance running like this:

[![LAMP-server-console](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/LAMP-server-console.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/LAMP-server-console.png)

* Download the private key preferably to the `.ssh` directory and cd into the directory:
    

```plaintext
cd .ssh
```

* Change permissions for the private key file:
    

```plaintext
sudo chmod 0400 <private-key-name>.pem
```

* Connect to the ubuntu instance by running :
    

```plaintext
ssh -i <private-key-name>.pem ubuntu@<publi-ip-address>
```

[![SSH into LAMP](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/ssh-into-LAMP-server.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/ssh-into-LAMP-server.png)

[![SSH into LAMP-Successful login to lamp](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/successful-login-to-LAMP.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/successful-login-to-LAMP.png)

### Step 1 - Install Apache and update the firewall

Apache is the web server that serves our web content to the end user.

* Update the package list and install Apache
    

```plaintext
# Update package list
sudo apt update -y
sudo apt upgrade -y

# Install Apache web server
sudo apt install apache2 -y
```

* Adjust the firewall:
    

First check if the UFW is active with the following command:

```plaintext
sudo ufw status
```

if the `Status: inactive`, skip this step. Otherwise, allow apache traffic with the following command:

```plaintext
sudo ufw allow 'Apache Full'
```

* Next, verify that Apache is running:
    

```plaintext
sudo systemctl status apache2
```

[![IMAGE; apache-running](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/systemctl-apache2-running.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/systemctl-apache2-running.png)

* Access Apache locally with curl:
    

```plaintext
curl http://localhost:80
```

Running `curl http://127.0.0.1:80` gives the same result.

[![IMAGE: terminal- apache-server running](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/Terminal-apache-server-running.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/Terminal-apache-server-running.png)

Alternatively, you can access it on any web browser of your choice by checking the following address:

```plaintext
http://<EC2-instance-public-ip>:80
```

Note: To retrieve the public IP of your EC2 instance, visit the AWS management console or run the following command on the terminal:

```plaintext
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/public-ipv4
```

[![IMAGE: Retrieve public ip address](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/retriev-public-ip-address-termina-blue.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/retriev-public-ip-address-termina-blue.png)

When you view the web browser, what you see is similar to the image below:

[![IMAGE; Web-Apache-default page](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/Web-Apache-default-page.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/Web-Apache-default-page.png)

### Step 2 - Install MySQL

To be able store and manage data for our web application in a relational database, we will install MYSQL.

* Install mysql with apt
    

```plaintext
sudo apt install mysql-server -y
```

* Login to the MYSQL console by typing:
    

```plaintext
sudo mysql
```

This will connect mysql a the administrative database user root

[![IMAGE: mysql console](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/root-login-msql.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/root-login-msql.png)

Following best practice, it is recommended to run a security script that comes pre-installed with MYSQL to remove some insecure default settings and lock down access to the database system. Before we do this, we will set a password for the *root* user. For simplicity, we will use `password123@`. We will be using `mysql_native_password` as the default authentication method:

* Set MYSQL root user password:
    

```plaintext
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password123@';
```

[![IMAGE: root-login-mysql ](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/root-login-msql.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/root-login-msql.png)

* Exit the MYSQL shell:
    

```plaintext
exit
```

* Secure mysql installation by starting the interactive script:
    

Run the security script:

```plaintext
sudo mysql_secure_installation
```

Follow the following :

* VALIDATE PASSWORD COMPONENT is used to test password and improve security: For now, we will enter `Y` for `YES`. We should use stong unique passwords for database credentials.
    

[![IMAGE:validate-password-mysql ](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/validate-password-mysql.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/validate-password-mysql.png)

We are then prompted to choose from three levels of password validation policy. We will go with `1 = MEDIUM`. Note that the strong password setting is very strict and must comply with the stated rule as seen in the image above.

Next we will be asked to set password if the password we already set does not match the specification in the password validation policy.

Because the password we set already matches the specification, password creation is skipped as shown.

[![IMAGE: Password skipped for validation](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/pass-word-skipped-for-validation.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/pass-word-skipped-for-validation.png)

* Next we are asked to remove Anonymous Users?: Press `Y`.
    
* Disallow Root Login Remotely?: Press `Y`.
    
* Remove Test Database and Access to it?: Press `Y`.
    
* Reload Privilege Tables Now?: Press `Y`.
    

[![IMAGE: Answer-Yes-for-the-rest](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/answer-Yes-for-rest.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/answer-Yes-for-rest.png)

* Test if you are able to login to the MYSQL shell by typing:
    

```plaintext
sudo mysql -p
```

if successful, you should be able to login. You can exit the MySQL monitor by entering `exit`

[![IMAGE: test-mysql-login-again](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/test-mysql-login-again.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/test-mysql-login-again.png)

It is recommended to create dedicated users for each databases.

MySQL has been installed and we can proceed to install PHP.

### Step 3 - Install PHP

Now we install PHP to process code and to display dynamic content to the end user. We will install the `php` package, `php-mysql` which is a php module that php uses to communicate with MYSQL-based database; and `libapache2-mod-php` which enables Apache to handle PHP files.

* Run the following command to install the 3 necessary packages:
    

```plaintext
sudo apt install php libapache2-mod-php php-mysql
```

Core PHP packages will be automatically installed as dependencies.

We can also optionally install other php modules:

```plaintext
sudo apt install php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip -y
```

* Verify PHP installation by checking the version:
    

```plaintext
php -v
```

if php has been successfully installed, you will get an image similar to the one below:

[![IMAGE: php-verify-install](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/php-verify-install.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/php-verify-install.png)

Our LAMP is now succesfully installed and ready to be used. We will test our set up with as PHP script. We will follow best practice by setting up an Apache Virtual Host to hold our website files and folders. A virtual host allows us to serve multiple websites on one single host machine.

### Step 4 - Configure Apache Virtual Host

We will create a directory next to the default one at `/var/www/html`

* Create a directory named `lamp_project` as follows:
    

```plaintext
sudo mkdir /var/www/lamp_project
```

Currently, if you check the dircetory ownership using `ls -la /var/www/lamp_project`, it may be owned by root or another user.

[![Lamp owned by root](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/lamp-owned-by-root.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/lamp-owned-by-root.png)

* Next, we will set the correct permissions:
    

```plaintext
sudo chown -R $USER:$USER /var/www/lamp_project

```

* Create a new configuration file in apache's `sites-available` directory.
    

```plaintext
sudo vi /etc/apache2/sites-available/lamp_project.conf
```

Add the following to the configuration file:

```plaintext
<VirtualHost *:80>
    ServerName [your_project_name or domain_address]
    ServerAlias [www.your_project_name or www.yourdomain.com]
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/[your_project_name]
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

We will replace `[your_project_name or domain_address]` with `lamp_project` which is the name of our directory.

Though, including the `ServerAdmin` directive is a good practice for proper server administration and communication, it's not strictly required for the virtual host to function. If you don't want to specify an admin email, you can omit this line from your virtual host configuration without affecting the website's operation. In production environment, many organizations use role-based email addresses like `webmaster@yourdomain.com` for this purpose.

* Save the file by hitting `esc` key and `:wq`
    

The virtualhost configuration gives a directive to apache to serve `lamp_project` using `/var/www/lamp_project` as the web root directory.

* Enable the new virtual host:
    

```plaintext
sudo a2ensite lamp_project.conf #replace this with the name of your project file
```

For consistency we have appended the full name of the file. If we write it without `.conf`, it also works. In practice, Apache will first look for an exact match of the name of the file you provide. If it doesn't find an exact match, it will then look for a file with `.conf` appended.

* Disable Apache default website:
    

```plaintext
sudo a2dissite 000-default.conf
```

* Test the configuration file:
    

```plaintext
sudo apache2ctl configtest
```

* Reload Apache to ensure that the changes take effect:
    

```plaintext
sudo systemctl reload apache2
```

* Create an index.html file in the project root to test that the virtual host works as expected:
    

```plaintext
sudo echo 'HELLO LAMP from hostname' $(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/public-hostname) 'with public IP' $(TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/public-ipv4) > /var/www/lamp_project/index.html

```

Here we use the instance metadata to retrieve the hostname and public-IP of our instance. The [AWS Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html) is a great resource to find out details on how to use the instance metadata. The instance metadata categories are found [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html#instancedata-data-categories)

[![IMAGE: run-metadata-command-lamp](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/run-metadata-command-lamp.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/run-metadata-command-lamp.png)

* Visit your web browser and enter the public IP of your EC2 instance as shown:
    

```plaintext
http://[Public-IP]:80
```

[![IMAGE: ec2instance-webpage](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/ec2instance-webpage.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/ec2instance-webpage.png)

The output should show our server's public hostname (DNS name) and server's public IP address. We can also use access the website through the DNS name without mapping it to the port `80`

The `index.html` file can be kept as a placeholder until we replace it with our `index.php` file

### Step 5 - Enable PHP on the website

Apache has a default **DirectoryIndex** in which the `index.html` file takes precedence over an `index.php` file. The real life application of this is that the `index.html` file can be used as a temporary landing page to display an informative message to visitors especially during routine system maintenance. Once maintenance is aover, it is either renamed or removed, thereby bringing up the regular application page.

This default behaviour can be changed by editing the `/etc/apache2/mods-enabled/dir.conf` and changing the order in which the \`index.php is listed in the **DirectoryIndex** directive.

* To do this, run the command:
    

```plaintext
sudo vim /etc/apache2/mods-enabled/dir.conf
```

* In the file, bring index.php to the fore front as shown:
    

[![IMAGE: indexphp-at-the-front](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/indexphp-at-the-front.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/indexphp-at-the-front.png)

* Reload apache so that the changes take effect:
    

```plaintext
sudo systemctl reload apache2
```

### Step 6 - Create PHP script to test the configuration of PHP

* Create a new file named `index.php` in the custom project folder:
    

```plaintext
sudo vim /var/www/lamp_project/index.php
```

* Add the following text:
    

```plaintext
<?php
phpinfo();
```

* Save and close the file. then refresh the webpage. What you see is similar to the image below:
    

[![IMAGE: php-server-info](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/LAMP-STACK/images/php-server-info.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/LAMP-STACK/images/php-server-info.png)

The page provides useful info about your server from the perspective of php. this means php is installation is properly configured. The page contains sensitive info about your PHP environment and virtual machine. Hence, it should be removed with the command below:

```plaintext
sudo rm /var/www/lamp_project/index.php
```

## Conclusion

We successfully deployed a LAMP stack on AWS Cloud!