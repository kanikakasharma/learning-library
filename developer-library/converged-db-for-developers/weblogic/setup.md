# Oracle Weblogic

## Introduction

To showcase how the eShop application is developed on JDeveloper and deployed on WebLogic, we need to have the following setup done.

•	Make sure the database is up and running on the local machine 

•	Make sure the Listener is started and connected to the converged database on the local machine

•	Set the environment variables needed to start the WebLogic 

•	Get the application code to build it on JDeveloper


## Before You Begin

Add the steps needed to start and verify the listener and database
For starting WebLogic 14c:

• Open a terminal on the instance

• Click on the Terminal Icon

• Make sure you have logged on as Oracle user

**Note** As OPC user, type the command  “sudo su – oracle”.
Ignore this if you are already logged in as Oracle user.

• Navigate to scripts folder under weblogic workshop workspace folder

````
<copy>
cd /u01/middleware_demo/scripts/
</copy>
````

• Set the environment variables by sourcing the profile file setWLS14Profile.sh

````
<copy>
./ setWLS14Profile.sh
</copy>
````

• Change directory to weblogic $DOMAIN_HOME/bin

````
<copy>
cd $DOMAIN_HOME/bin
</copy>
````

• Start the weblogic 14c server on the system

````
<copy>
nohup ./startWebLogic.sh &
</copy>
````

**Import the Application Code**

Import the eShop application code from git repository. 

GIT tool has been already installed on the appliance

````
<copy>
cd /u01/middleware_demo

git clone https://url_to_be_decided_soon
</copy>
````

## Acknowledgements

- **Authors** - Balasubramanian Ramamoorthy, Dhananjay Kumar, Pradeep Chandramouli
- **Contributors** - Nishanth Kaushik,Kanika Sharma,Srinivas Pothukuchi,Arvind Bhope
- **Team** - North America AppDev Specialists
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2021
- **Expiration Date** - June 2021


## Issues?
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.

      