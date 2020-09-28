# Start Services

## Introduction

This lab will show you how to setup tunneling for VNC, start VNC Server and connect to remote VNC session. Also, this lab will show steps to start the database instance, listener, Weblogic server and JDeveloper IDE. In this lab we will also import the eSHOP JEE Code to JDeveloper IDE.

Estimated Time: 15 Minutes

## Objectives

- Start VNC Server
- Configure Tunneling for VNC access
- Download & Install VNC Client OR use Chrome VNC Plugin
- Connect to remote VNC Server
- Start the Oracle Database and Listener
- Start Weblogic Server


## Prerequisites

• Lab 1: Generate SSH Key - Cloud Shell 

• Lab 2: Setup Compute Instance


## Step 1: Login to ConvergedDB Compute instance

code needs to be copy

## Step 2: Start the Database and Listener 

code needs to eb copy 


## Step 3: Start the WebLogic service and VNC Service

1. Under **Domain Structure** tab on left hand side, expand **Service**

2. Click on **Data Sources**  Click on New and select **Generic Data Source**

![](./images/weblogic_console_create_ds.png " ")

3. Fill the values as below and click **Next** button

Name: jsonxmlds

JNDI Name: convergeddb.jsonxmlds

![](./images/create_jsonxmlds.png " ")

4. For **Database Driver** select the default value of **Oralce’s Driver (Thin) for Service Connections; Versions: Any.** Click **Next**

![](./images/create_jsonxmlds_driver.png " ")

5. In the next screen do not change any values.  Let the default selections prevail.  Click **Next**

![](./images/create_jsonxmlds_options.png " ")

6. Under the **Connection Properties** screen provide the following values. Click **Next** 

- Database Name: JXLPDB

- Host Name: localhost

- Port: 1521

- Database User Name: appxml

- Password: Oracle_4U

- Confirm Password: Oracle_4U

![](./images/create_jsonxmlds_connection_properties.png " ")

7. Click on **Test Configurtion** to confirm the connection.  Once you see a successful connection, Click **Next**

![](./images/create_jsonxmlds_test_connection.png " ")

8. In the **Select Target** screen, select the checkbox against **AdminServer**. Click **Finish**

![](./images/create_jsonxmlds_select_target.png " ")

9. Navigate back to **Preferences**, **WLST Script Recording** tab. Click **Control** tab. Click on **Stop Recording** button

![](./images/datasource_recording_stop.png " ")

Now we have successfully recorded how a datasource can be created from WebLogic Admin Console

## Step 4: Setup PuTTY 

WebLogic Scripting tool is used to do all administrative actions which can be done using administrative console on a command prompt.

In this step we will edit the recorded script a little to connect to the required AdminServer, change the parameters like data source name, other connection parameters and execute the script from command line.

1. Open a **Terminal** in the VNC desktop.
   
2. Edit the recorded commands in /u01/middleware_demo/scripts/createDS.py using the command

````
<copy>
gedit /u01/middleware_demo/scripts/createDS.py
</copy>
````

3. Remove the line with keyword “setEncrypted(“ or comment it by adding “#” as the first character of the line - before the keyword “setEncrypted”

````
<copy>
#setEncrypted('Password', 'Password_1592840128546',
'/u01/middleware_demo/scripts/createDSConfig',
'/u01/middleware_demo/scripts/createDSSecret')
</copy>
````

4. Instead of setEncrypted() function, we can set the password for the datasource connection using the setPassword() command in WLST.  Write the below line in place of line containing “setEncrypted” 

````
<copy>
cmo.setPassword(“Oracle_4U”)
</copy>
````

5. Click on the **Menu** icon on the right hand side of the gedit window.  Click **Find and Replace** option

![](./images/edit_wlst_script.png " ")

6. Find and Replace all occurrence of “jsonxmlds” with “spatialgraphds”

7. Find and Replace the username for database connection “appxml” with “appspat”

8. Find and Replace the PDB name “JXLPDB” with “SGRPDB”

9. Click **Save** button and **Close** gedit window

## Step 5: Install VNC Client and Connect

1. Use the existing **Terminal**  or Open a new **Terminal** on VNC desktop to execute commands 
  
2. Navigate to folder where the edited datasource create script exits

````
<copy>
cd /u01/middleware_demo/scripts
</copy>
````

3. Source the lab profile file (DOT SPACE PATH)

````
<copy>
. /u01/middleware_demo/scripts/setWLS14Profile.sh
</copy>
````

4. Source the setDomainEnv.sh to set all WebLogic and WLST paths

````
<copy>
sh $DOMAIN_HOME/bin/setDomainEnv.sh
</copy>
````

5. Execute the java command below to run the WLST script to create the second datasource “spatialgraphds”

````
<copy>
java weblogic.WLST createDS.py
</copy>
````

6. Navigate to folder /u01/middleware_demo/converge-java/utilities

````
<copy>
cd /u01/middleware_demo/converge-java/utilities
</copy>
````

7. Execute the java command below to run the WLST script to create datasource connecting to PDB apppdb where the eShop data is stored

````
<copy>
java weblogic.WLST createAppDataSourceSGR.py

java weblogic.WLST createAppDataSourceJXL.py
</copy>
````


## Acknowledgements

- **Authors** - Pradeep Chandramouli,Nishanth Kaushik
- **Contributors** - Kanika Sharma,Laxmi,Balasubramanian Ramamoorthy
- **Team** - North America AppDev Specialists
- **Last Updated By** - Kay Malcolm, Director, Database Product Management, June 2021
- **Expiration Date** - June 2021


## Issues?
Please submit an issue on our [issues](https://github.com/oracle/learning-library/issues) page. We review it regularly.

      