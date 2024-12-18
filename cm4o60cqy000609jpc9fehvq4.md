---
title: "Deploying A MERN Stack To-Do App on AWS: A Step-by-Step Guide"
datePublished: Sat Dec 14 2024 12:40:21 GMT+0000 (Coordinated Universal Time)
cuid: cm4o60cqy000609jpc9fehvq4
slug: deploying-a-mern-stack-to-do-app-on-aws-a-step-by-step-guide
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1734179981097/9b82b20b-de1a-40e1-b2d9-ebc61450f568.png
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1734180009180/a370a3b3-a900-4031-a997-e6250ba85ce1.png

---

## Table of Contents

1. [Project Overview](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#project-overview)
    
2. [Prerequisites](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#prerequisites)
    
3. [Steps](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#steps)
    
    * [Step 0 Prepare Prerequisites](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#step-0-prepare-prerequisites)
        
    * [Step 1 Configure the backend](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#step-1-configure-the-backend)
        
    * [Step 2 Test the Backend code with Postman](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#step-2-test-the-backend-code-with-postman)
        
    * [Step 3 Create the frontend](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#step-3-create-the-frontend)
        
    * [Step 4 Create the React Components](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#step-4-create-the-react-components)
        
    * [Step 5 Run the app](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#step-5-run-the-app)
        
4. [Conclusion](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/mern-stack.md#conclusion)
    

## Project Overview

The MERN stack is a popular web development framework that combines four technologies: MongoDB, Express.js, React and Node.js. This stack allows developers to build robust, scalable web applications using Javascript accross both the client and server sides.

The application we will be deploying is a single-page application (SPA), a to-do app having dynamic content.It can be used to add to-do items, display and delete to-do content.

## Prerequisites

* AWS account
    
* AWS CLI
    
* Basic knowledge of React, Node.js, Express.js
    
* Basic knowledge of Linux
    

## Steps

## Step 0 Prepare Prerequisites

* Launch an EC2 instance named `mern-server`. We will be using an ubuntu instance LTS 24.04.
    

[![mern-server created on aws](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/mern%20server%20created.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/mern%20server%20created.png)

* SSH into the server from your local machine or development environment
    

```plaintext
ssh -i /path/to/key ubuntu@[public-IP]
```

[![ssh into mern-server](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/ssh%20into%20mern-server.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/ssh%20into%20mern-server.png)

## Step 1 Configure the backend

* Update and upgrade the ubuntu instance:
    

```plaintext
sudo apt update -y && sudo apt upgrade -y
```

* Install Node.js and npm on the server:
    

```plaintext
sudo apt install -y nodejs npm
```

* Check node and npm version
    

```plaintext
node -v
npm -v
```

[![node and npm version](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/node%20and%20npm%20version.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/node%20and%20npm%20version.png)

#### Set up application code

* First, we will create a new directory for the To-do app project and verify its creation with the `ls` command:
    

```plaintext
mkdir Todo && ls
```

[![make Todo dir](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/make%20Todo%20dir.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/make%20Todo%20dir.png)

* Change directory to the newly created directory:
    

```plaintext
cd Todo
```

* Initialise the project by running:
    

```plaintext
npm init
```

[![npm init](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/npm%20init.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/npm%20init.png)

Press enter/return key to accept the default values. Finally enter `yes` to accept.

This command creates a new `package.json` file within our folder that contains the application code and the dependencies it requires to run.

[![npm init accept default values](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/npm%20init%20accept%20default%20values.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/npm%20init%20accept%20default%20values.png)

The content of the package.json is similar to the image below:

[![content of the package.json](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/package.json%20content.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/package.json%20content.png)

* Install Expressjs and the dotenv module Expressjs is a framework for Node.js. It helps to simplify development. We will install it with npm:
    

```plaintext
npm install express dotenv
```

[![image install express dotenv](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/install%20express%20dotenv.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/install%20express%20dotenv.png)

[![listing after express dotenv](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/listing%20after%20express%20dotenv.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/listing%20after%20express%20dotenv.png)

Create the `index.js` file which is the entry point of the application:

```plaintext
vi index.js
```

We will write the following code into the `index.js` file. Open the file with an editor of choice and enter the code:

```plaintext
// Importing dependencies
const express = require('express');
require('dotenv').config();

// Creates the express app
const app = express();

// Setting the port
const port = process.env.PORT || 5000;

// CORS configuration
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

// Routes handling
app.use((req, res) => {
  res.send('Welcome to Express');   
});

// Starting the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
```

The code sets up a simple web server using Node.js and Express.js. Comments have been included in the code to provide explanations of each sections. When a request is made to the server, CORS headers are added to the response. Irrespective of the request URL or method, the server reponds with, "Welcome to Express". The server listens on the specified port or defaults to 5000 if the port is not provided.

Save the file.

To test our server, we will run:

```plaintext
node index.js
```

The image below shows the running server.

[![node server running on port 5000](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/server%20running%20on%20port%205000.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/server%20running%20on%20port%205000.png)

Note the port the server is running on and open the port in the security group with the following command:

Retrieve the groupId of the security group by running the following command:

```plaintext
aws ec2 describe-security-groups --query "SecurityGroups[*].{ID:GroupId,Name:GroupName}"
```

Retrieve groupId for a specific security group

```plaintext
aws ec2 describe-security-groups --group-names "my-security-group" --query "SecurityGroups[*].GroupId" --output text
```

Create an ingress rule for the port from anywhere `0.0.0.0/0`

```plaintext
aws ec2 authorize-security-group-ingress --group-id [GroupId] --protocol tcp --port [port] --cidr 0.0.0.0/0
```

Alternatively, set the security group ingress via the AWS console.

Retrieve your server's public IP with the instance metadata

```plaintext
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/public-ipv4
```

Next, access your server's public IP in your browser:

```plaintext
http://[public-ip]:5000
```

[![image: Welcome to Express browser](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Welcome%20to%20Express%20browser.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Welcome%20to%20Express%20browser.png)

**Hints/ Troubleshooting** :

* If you get "ERR\_SSL\_PROTOCOL\_ERROR" , check that you are running the application of http not https.
    
* When you run `node index.js` you will not be able work on that terminal, resolve this by ssh into the instance on another terminal. Alternatively, run the server with the ampersand symbol to run it in the background: `node index.js &`
    

* **Routes** Our to-do app will be able to perform the following three actions which will be associated with specific endpoints.
    

1. Create a new task
    
2. Display list of all tasks
    
3. Delete a completed task
    

We will be using standard HTTP request methods: **POST**, **GET**. **DELETE**

We will create `routes` that will define the endpoints that the to-do app requires.

In a new terminal,create a folder called `routes` and `cd` into it.

```plaintext
mkdir routes && cd routes
```

We will create a file named `api.js` inside the folder, opening it with an editor of choice.

```plaintext
vi api.js
```

Enter the following code:

```plaintext
// Import Express and Create a router
const express = require('express');
const router = express.Router();

// Define routes

// Handles GET requests to retrieve a list of todos
router.get('/todos', (req, res, next) => {
  // Return the result as a JSON array
});

// Handles POST requests to create a new todo
router.post('/todos', (req, res, next) => {
  // Return the result as a JSON array
});

// Handles DELETE requests to delete a todo by ID
// `:id` is a route parameter, passed in the URL
router.delete('/todos/:id', (req, res, next) => {
  // Return the result as a JSON array
});

// Export the Router
module.exports = router;
```

The above code defines an Express.js router for handling CRUD (Create, Read, Delete) operations on our `to-do` app. Comments are included in the code to explain the functionality. To use this router, you would typically import it in your main server file and use it like this:

```plaintext
const todoRoutes = require('./api');
app.use('/api', todoRoutes);
```

**Model** We will create a model since our app is using Mongodb, a NoSQL database. A model makes a javascript applications interactive. The model will be used to define the database schema. A schema is a layout of how the database will be constructed. We will install `mongoose` to create a schema and a model. `mongoose` is a node.js package that makes working with mongodb easier. it is an Object Data Modeling (ODM) library for MongoDB and Node.js

Install mongoose inside the `Todo` folder:

```plaintext
cd Todo && npm install mongoose
```

Create a `models` directory, `cd` into it and create a file named `todo.js` within the folder:

```plaintext
mkdir models && cd models && vi todo.js
```

Enter the following code into the `todo.js` file:

```plaintext
// Import mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema; // retrieves the mongoose schema constructor

// Defines the todo schema
const TodoSchema = new Schema({
  action: {
    type: String,
    required: [true, 'The todo text field is required']
  }
});

// Create model for todo
const Todo = mongoose.model('todo', TodoSchema);

// exports the todo model to be used in other parts of the app.
module.exports = Todo;
```

The code defines a mongoose model for our todo app in a MongoDB database. Comments are included in the code to explain its functionality.

Since our MongoDB models has been set up, we need to update the `routes` in the `api.js`

Delete the previous content of the `api.js` file and enter the following:

```plaintext
// Import Dependencies 
const express = require('express');
const router = express.Router();
const Todo = require('../models/todo');

router.get('/todos', (req, res, next) => {
  Todo.find({}, 'action') // finds all the documents, selecting only the action field 
    .then(data => res.json(data))
    .catch(next);
});

router.post('/todos', (req, res, next) => {
  if (req.body.action) {
    Todo.create(req.body)
      .then(data => res.json(data))
      .catch(next);
  } else {
    res.json({
      error: "The input field is empty"    
    });
  }
});

router.delete('/todos/:id', (req, res, next) => {
  Todo.findOneAndDelete({"_id": req.params.id})
    .then(data => res.json(data))
    .catch(next);
});

module.exports = router;
```

This code sets up a RESTful API for a todo application, allowing clients to:

* Retrieve all todos (GET /todos)
    
* Create a new todo (POST /todos)
    
* Delete a specific todo (DELETE /todos/:id)
    

It interacts with the MongoDB database using the Mongoose model we defined earlier. The routes now have actual implementations, unlike in the previous version where they were empty.

* **MongoDB Database** We will use mongoDB to store our data. We will use a database as a service solution that used to be called `mLab`. `mLab` was a popular cloud database service for MongoDB, but it has since been acquired by MongoDB and merged into `MongoDB Atlas`, their cloud-based service. Since mLab no longer offers services independently, the process for creating a free MongoDB cluster now involves using `MongoDB Atlas`.
    

Sign up for `MongoDB Atlas`. Once signed in you will be taken to the `MongoDB Atlas dashboard`. And then, the **Deploy your cluster page**

[![image: mongodb atlas dashboard](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/MongoDB%20atlas%20dashboard.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/MongoDB%20atlas%20dashboard.png)

[![image: mongodb atlas deploy your cluster page](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Deploy%20ur%20cluster.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Deploy%20ur%20cluster.png)

Or follow the steps below:

* Create a New Project: Click on **New Project** to create a new project where your cluster will reside. Name the project and click "**Next**".
    

[![image: Create a project](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Create%20a%20project.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Create%20a%20project.png)

[![image mern stack project creation](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/mern%20stack%20project%20creation.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/mern%20stack%20project%20creation.png)

* Create a Free Cluster: In the newly created project, click "**Build a Cluster**", Choose "**Shared Clusters**" and select the "**Free tier**" (M0 cluster).You have options to configure the cloud provider (Choose AWS) and the region closest to you. Ensure you select the regions that have free tier available. We will choose the option of allowing access to the MongoDB database from anywhere.This is ideal for testing cases. \[Note that stricter maeasures should be applied for production environment\]. Also change the time of deleting entry from 6hours to 1 week.
    

[![image: Create a Cluster](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Create%20a%20cluster.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Create%20a%20cluster.png)

[![image: Deploy your Cluster](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Deploy%20ur%20cluster.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Deploy%20ur%20cluster.png)

Click on "**Create your deployment**", will show the image below:

[![image: Connect to todo app cluster](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Connect%20to%20%20todo%20app%20cluster.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Connect%20to%20%20todo%20app%20cluster.png)

Note that, I have covered personal details,

From the pop-up you can set up your Network Access and Database user.

* Set up MongoDB User: Click "**Database Access**" and then Click "**Add New Database User**". Choose "**Password**" for the authentication method and set the username and password.
    

[![Database Access](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Database%20Access.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Database%20Access.png)

[![Database Access 2](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Database%20Access%202.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Database%20Access%202.png)

I used a weak password for testing purposes. It is ideal to use strong passwords for production environments.

* Set IP Whitelist: This allows your local machine or application to connect to MongoDB Atlas cluster. Click "**Network Access**", then click "**Add IP Address**". You can allow access from anywhere by entering `0.0.0.0/0`. This is ideal for testing cases. \[Note that stricter maeasures should be applied for production environment\].
    

[![image: Network access](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Network%20Access.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Network%20Access.png)

[![image: Network access from Anywhere](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Network%20Access%20from%20anywhere.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Network%20Access%20from%20anywhere.png)

* Choose a connection method: After setting the database user and network access, Close the pop-up. On the dashboard, click "**Get connection string**". Then click "**Done**"
    
    ![image Get connection string 1](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Get%20connection%20string.png align="left")
    

[image Get connection string 2](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Get%20connection%20string%202.png)

Copy the connection string for use in the application:

It is in the following format:

```plaintext
mongodb+srv://username:<db_password>@todo-app-cluster.vj1ly.mongodb.net/?retryWrites=true&w=majority&appName=todo-app-cluster
```

Note that the UI may differ. But the process of configuration remains largely the same.

* **Creating an Environment variable file** In our `index.js` we specified a `process.env` to access environment variables. Hence, we need to create the file named `.env` as follows in the `todo` directory and add the connection string:
    

```plaintext
vim .env
```

Add the connection string similar to the below:(Preferably get the connection string on the mongo Atlas dashboard)

```plaintext
DB = mongodb+srv://username:<db_password>@todo-app-cluster.vj1ly.mongodb.net/?retryWrites=true&w=majority&appName=todo-app-cluster
```

Next we will update the index.js to reflect the use of the `.env` so that Node.js can connect to the database. Simply delete the existing content of the file and add the following code:

```plaintext
const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const routes = require('./routes/api');
const path = require('path');
require('dotenv').config();

const app = express();

const port = process.env.PORT || 5000;

// Connect to the Database
mongoose.connect(process.env.DB, { 
  useNewUrlParser: true,
  useUnifiedTopology: true 
})
.then(() => console.log(`Database connected successfully`))
.catch(err => console.log(err));

// Since mongoose promise is depreciated, we override it with node's promise
mongoose.Promise = global.Promise;

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.use(bodyParser.json());

app.use('/api', routes);

app.use((err, req, res, next) => {
  console.log(err);
  next();
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
```

This code sets up a RESTful API for a todo application, allowing clients to:

* Retrieve all todos (GET /todos)
    
* Create a new todo (POST /todos)
    
* Delete a specific todo (DELETE /todos/:id)
    

It interacts with the MongoDB database using the Mongoose model we defined earlier. The routes now have actual implementations, unlike in the previous version where they were empty. To use this router in your main application, you would typically do something like:

```plaintext
const todoRoutes = require('./routes/api');
app.use('/api', todoRoutes);
```

This would make the routes accessible under the `/api` path, so the full paths would be `/api/todos` for GET and POST, and `/api/todos/:id` for DELETE.

We will start the Node.js server:

```plaintext
node index.js
```

[![Image: Database Connected successfully](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Database%20connected%20successfully.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Database%20connected%20successfully.png)

## Step 2 Test the Backend code with Postman

We will test the backend code by using Restful API. We will use Postman to test our API.

Install postman on your machine or use the web version.

I will be using the web version as it provides equal functionality. Also, because I am using a cloud IDE.

* Visit [Postman website](https://web.postman.co/) and sign up or sign in to your account.
    

[![postman dashboard](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/postman%20dashboard.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/postman%20dashboard.png)

* In Postman Web, create a new request by clicking "**Send an API Request**".
    
* Input the endpoint you want to test in the URL field. (A)
    
* Set the method by clicking on the dropdown. (B)
    
* set the body if necessary. (C) To set the body, click on the body tab below the URL field &gt;&gt; Select raw &gt;&gt; add the task in json format. For example:
    

```plaintext
{
  "action": "take out trash"
}
```

[![Image post into the body](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/post%20to%20the%20body.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/post%20to%20the%20body.png)

* Set the Headers: (D)
    

Key: value (Content-type: application/json)

[![Image postman dashboard labelled](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/postman%20labelled.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/postman%20labelled.png)

(E) shows example result of the test on the POST request. The 200 OK status code means that the request was successful.

It is important to test all the endpoints:

Testing the HTTP GET request to display a list of tasks, we get the following:

[![Get request](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Get%20request.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Get%20request.png)

Testing the HTTP DELETE request to test how to deleting an existing task:

[![Delete request by Id](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Delete%20request%20by%20id.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Delete%20request%20by%20id.png)

if we check the GET endpoint again , we see that we are left with two tasks instead of three.

[![Get after Delete](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Get%20after%20Delete.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Get%20after%20Delete.png)

## Step 3 Create the frontend

We will create a user interface for a web client to interact with the to-do app via API.

First scaffold the app with the `create-react-app` command. Run the following command in the `Todo` directory:

```plaintext
npx create-react-app client
```

This command creates a new folder in the `Todo` directory called `client` where we will add all the react code.

We will install the dependencies needed

* install `concurrently`
    

```plaintext
npm install concurrently --save-dev
```

The command runs multiple commands simultaneously

* install `nodemon`
    

```plaintext
npm install nodemon --save-dev
```

This is used to run and monitor the server. nodemon restarts and load new changes automatically if there is any change in the code.

Next, we will edit the `package.json` folder within our `Todo` directory to contain the following code: Replace the `"scripts"` section with the following:

```plaintext
"scripts": {
"start": "node index.js",
"start-watch": "nodemon index.js",
"dev": "concurrently \"npm run start-watch\" \"cd client && npm start\""
},
```

[![replace this script section](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/replace%20this%20script%20section.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/replace%20this%20script%20section.png)

[![with this script](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/with%20this%20script.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/with%20this%20script.png)

* **Configure proxy in** `package.json` We will configure proxy in `package.json`
    

change directory to the `client` folder:

```plaintext
cd client
```

Open the `package.json` file:

```plaintext
vim package.json
```

Add the key value pair:

```plaintext
"proxy": "http://localhost:5000"
```

Including the proxy configuration makes it possible to access the application directly from the browser by calling the server url `http://localhost:5000` rather than always including the entire path `http://localhost:5000/api/todos`

Navigate to the Todo directory and run:

```plaintext
npm run dev
```

The app will run on `localhost:3000`, the default port for react app.

Hint: Open security group port to allow TCP port `3000`.

[![image react app running](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/React%20app%20running.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/React%20app%20running.png)

## Step 4 Create the React Components

React makes use of reusable components which makes code modular. We will have two stateful components and one stateless component for the `todo` app.

Change directory to the `src` folder from the `todo` directory:

```plaintext
cd client/src
```

Create a folder called `components` and cd into it

```plaintext
mkdir components && cd components
```

We will create three files namely: `Input.js`, `ListTodo.js` `Todo.js`

In the `input.js`, enter the following code:

```plaintext
import React, { Component } from 'react';
import axios from 'axios';

class Input extends Component {
  state = {
    action: ""
  };

  addTodo = () => {
    const task = { action: this.state.action };

    if (task.action && task.action.length > 0) {
      axios.post('/api/todos', task)
        .then(res => {
          if (res.data) {
            this.props.getTodos();
            this.setState({ action: "" });
          }
        })
        .catch(err => console.log(err));
    } else {
      console.log('input field required');
    }
  };

  handleChange = (e) => {
    this.setState({
      action: e.target.value
    });
  };

  render() {
    let { action } = this.state;
    return (
      <div>
        <input type="text" onChange={this.handleChange} value={action} />
        <button onClick={this.addTodo}>add todo</button>
      </div>
    );
  }
}

export default Input;
```

This React component, Input, enables users to add new Todo items. It features a text input field and an "Add Todo" button, validating non-empty text input. Upon submission, it sends a POST request to /api/todos using Axios, refreshing the Todo list by calling the getTodos prop function. The component's state manages the input value, resetting it after successful submission. It's designed to interact with a RESTful API and is exported for use in larger Todo applications.

To make use of `Axios`, a Promise based HTTP client for the browser and node.js, cd into the client and run `npm install axios` or `yarn add axios`

```plaintext
cd ../../ # or cd client Depending on your current location on the terminal 

npm install axios
```

Change to the components directory:

```plaintext
cd src/components
```

Open the `ListTodo.js` with a text editor:

```plaintext
vim ListTodo.js
```

Paste the code below into the file:

```plaintext
import React from 'react';

const ListTodo = ({ todos, deleteTodo }) => {
  return (
    <ul>
      {todos && todos.length > 0 ? (
        todos.map((todo) => (
          <li key={todo._id} onClick={() => deleteTodo(todo._id)}>
            {todo.action}
          </li>
        ))
      ) : (
        <li>No todo(s) left</li>
      )}
    </ul>
  );
};

export default ListTodo;
```

This component is designed to display and manage a list of Todo items, allowing users to delete individual items.

Then add the following code to the Todo.js file:

```plaintext
import React, { Component } from 'react';
import axios from 'axios';

import Input from './Input';
import ListTodo from './ListTodo';

class Todo extends Component {
  state = {
    todos: []
  };

  componentDidMount() {
    this.getTodos();
  }

  getTodos = () => {
    axios.get('/api/todos')
      .then(res => {
        if (res.data) {
          this.setState({
            todos: res.data
          });
        }
      })
      .catch(err => console.log(err));
  };

  deleteTodo = (id) => {
    axios.delete(`/api/todos/${id}`)
      .then(res => {
        if (res.data) {
          this.getTodos();
        }
      })
      .catch(err => console.log(err));
  };

  render() {
    const { todos } = this.state;

    return (
      <div>
        <h1>My Todo(s)</h1>
        <Input getTodos={this.getTodos} />
        <ListTodo todos={todos} deleteTodo={this.deleteTodo} />
      </div>
    );
  }
}

export default Todo;
```

This React code defines a Todo component that manages a Todo list application. It fetches Todo items from a RESTful API on mount, displays them using the ListTodo component, and allows users to add new items via the Input component. The component also handles deleting Todo items by sending a DELETE request to the API and updating the list. The getTodos function is used to refresh the list after adding or deleting items, ensuring the UI stays synchronized with the API data.

We will open the `App.js` file located in `src`. Change directory to the `src` directory and enter the following:

```plaintext
import React from 'react';

import Todo from './components/Todo';
import './App.css';

const App = () => {
    return (
        <div className="App">

            <Todo />
        </div>
    );
    
}

export default App;
```

This code defines the main App component, which serves as the entry point for the application. It imports the Todo component and renders it within a div element with the class "App". The Todo component is responsible for managing a Todo list, and this App component provides a container for it. The application's CSS styles are also imported from App.css. Overall, this code sets up the basic structure for the Todo list application.

Still in the src directory , we will open the `App.css` and paste the following `css` code:

```plaintext
vi App.css
```

```plaintext
.App {
    text-align:center;
    font-size: calc(10px + 2vmin);
    width: 60%;
    margin-left: auto;
    margin-right: auto;
}

input {
    height: 40px;
    width: 50%;
    border: none;
    border-bottom: 2px #101113 solid;
    background: none;
    font-size: 1.5rem;
    color: #787a80;
}

input:focus {
    outline: none;
}

button {
    width: 25%;
    height: 45px;
    border: none;
    margin-left: 10px;
    font-size: 25px;
    background: #101113;
    border-radius: 5px;
    color: #787a80;
    cursor: pointer;

}

button:focus {
    outline:none;
}

ul {
    list-style: none;
    text-align: left;
    padding: 15px;
    background: #171a1f;
    border-radius: 5px;

}

li {
    padding: 15px;
    font-size: 1.5rem;
    matrgin-bottom: 15px;
    background: #282c34;
    border-radius: 5px;
    overflow-wrap: break-word;
    cursor: pointer;
}

@media only screen and (min-width: 300px) {
    .App {
        width: 80%;
    }
}

input {
    width:100%
}

button {
    width:100%;
    margin-top: 15px;
    margin-left: 0;
}

@media only screen and (min-width: 640px) {
    .App {
        width: 60%;
    }
}

input {
    width: 50%;
}

button {
    width: 30%;
    margin-left: 10px;
    margin-top: 0;
}
```

In the src directory, also open the `index.css` and enter the following css code:

```plaintext
body {
    margin: 0;
    padding: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen", "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    box-sizing: border-box;
    background-color: #282c34;
    color: #787a80;
  }
  
  code {
    font-family: source-code-pro, Menlo, Monaco, Consolas, "Courier New", monospace;
  }
```

## Step 5 Run the app

Cd into `Todo` directory run:

```plaintext
cd ../..
npm run dev
```

We will be able to view the app running on port 3000 as shown below. we will observe that the app has listed already, what we used in the postman tests. The todo list app is functional!

[![Image: Functional todo list app](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/raw/main/MERN-STACK/images/Functional%20to-do%20list%20%20app.png align="left")](https://github.com/laraadeboye/Steghub-Devops-Cloud-Engineer/blob/main/MERN-STACK/images/Functional%20to-do%20list%20%20app.png)

## Conclusion

This project demonstrates the complete deployment process of a MERN stack to-do application on AWS. From setting up the backend with Node.js and Express.js, to integrating MongoDB Atlas for database storage, and finally deploying the React-based frontend, this guide covers the essential steps for developing and deploying a dynamic single-page application (SPA). The final product allows users to add, view, and delete tasks, leveraging AWS infrastructure for scalability and security.