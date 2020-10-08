# Oracle XML

## Introduction

In this lab we will walk through the SQL queries containing the built-in functions for XML datatype. We will create database table with xml datatype, insert sample data and create REST endpoint to access that XML data. We will also modify the code, re-build and re-deploy the code the observe the XML data type and its built-in functions. Will learn how a line item within the XML content stored in the database can be conditionally updated.

***Note***: You may not find any values in the drop down while trying to access XML data using this tool if XML data insertion is not complete.

*Estimated Time*: 30 Minutes

### **Prerequisites**

This lab assumes you have completed the following labs:
- Lab 1: Generate SSH Key - Cloud Shell
- Lab 2: Setup Compute Instance
- Lab 3: Start Services
- Lab 4: Deploy eSHOP Application
- Lab 5: Data type demonstrator tool

### **About XML**

XML(Extensible Markup Language) is used to store and transport data. XML data is known as self-describing or self-defining, meaning that the structure of the data is embedded with the data, thus when the data arrives there is no need to pre-build the structure to store the data; it is dynamically understood within the XML.

The basic building block of an XML document is an element, defined by tags. An element has a beginning and an ending tag. All elements in an XML document are contained in an outermost element known as the root element. XML can also support nested elements, or elements within elements. This ability allows XML to support hierarchical structures. Element names describe the content of the element, and the structure describes the relationship between the elements.

## Step 1: Connect JDeveloper to database

To show the ease of integration of ConvergedDB with Java applications to access and process data and to create REST endpoints in the Java application to access the different datatypes like JSON, XML and SPATIAL, we have a simple application installed along with the eSHOP application.

1.	Open JDeveloper in Studio Mode, if not open already

2.	Click on **Window** -> **Database** -> **Databases** to open the Databases Navigation tab on the Left-Hand side of the JDeveloper editor

    ![](./images/jdev_database_connection.png " ")

3.	Click on the green **+** icon under the **Databases** tab on Left-Hand side Navigation to “Create Database Connection”.
Provide values:

    - **Connection Name**: xml
    - **Connection Type**: Oracle(JDBC)
    - **Username**: appxml
    - **Password**: Oracle_4U
    - **Hostname**: localhost
    - **Service Name**: JXLPDB
  

    ![](./images/jdev_add_db_connection.png " ")

4.	Click on **Test Connection** and upon **Success!** message, Click OK.


## Step 2: Sample XML Data

1.	In the Menu bar, click on **SQL** dropdown and select **xml**

   ![](./images/jdev_sql_xml.png " ")

2.	A worksheet for connection **xml** opens up execute your query commands

   ````
<copy>
   CREATE TABLE XML_TYPE(doc XMLTYPE); 
</copy>
   ````

3.	Select the Text and Click on the Green **Play** Icon

4.	You will see the **Table Created** message in the **Script Output** section below

    ![](./images/jdev_create_xml_table.png " ")

5.	Right Click on **Tables (Filtered)** on Left-Hand side and click **Refresh** to see the table created
    
    ![](./images/jdev_xml_db_refresh.png " ")

6.	Once you see the table **XML_TYPE** on the left-hand side, In the worksheet, in a new line, key in   the query below
     ````
<copy>
   select * from xml_type;
   </copy>
    ````

7.	Select the query line and again click the green **Play** button to execute the query
to see no results

    ![](./images/jdev_xml_db_select_no_result.png " ")

8.	In the worksheet, execute the below Insert statement to create sample xml data into database table xml_type. Select the statement and click on the green **Play** Icon to execute the insert statement.  
    ````
<copy>
   insert into xml_type values ('<order><id>1</id><name>Java Developer 01</name><address><street>Oracle ParkWay</street><pincode>12345</pincode></address></order>');
   </copy>
    ````

    ![](./images/jdev_insert_xml.png " ")

## Step 3: Modify JEE code for XML

1.	Under the Projects in **Applications** tab on left Navigation, expand **converge** -> **Resources** and double click on **“applicationContext.xml”** to open the configuration xml to add the new datasource bean. Add the code below the **</bean>** tag of **converge.oracle.spatialAnalytics** and before ending **</beans>** tag 

    ````
<copy>
   <bean id="xmldsbean" class="org.springframework.jndi.JndiObjectFactoryBean">
   <property name="jndiName" value="convergeddb.jsonxmlds"/>
   </bean>

   </copy>
    ````

    ![](./images/jdev_xml_bean_add.png " ")

2.	Click on **Save** Button

3.	Similarly, open the **DBSource.java** file under **Projects** -> **converge** -> **Application Sources** -> **converge.dbHelper** by double clicking the file
 
    •	 Search for **getXMLDS** and navigate to the existing empty getXMLDS function. Copy and Paste the function **code** in the code file.  The java code for the function is as below  

     ````
<copy>
   public  Connection getXMLDS() throws SQLException {
	LOG.debug("Reached to get xml Connection");
	Connection con = null;
	ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
	xmlds = (DataSource) context.getBean("xmldsbean");

	try {
		con = xmlds.getConnection();
		con.setAutoCommit(false);
		LOG.info("Success connection");
	}catch(SQLException ex) {
		LOG.error(ex);
	}catch(Exception e) {
		LOG.error(e);
	}

	return con;
}
 </copy>
       ````


    ![](./images/jdev_xml_db_code_search.png " ")

    ![](./images/jdev_xml_db_code.png " ")

4.	Click on **Save** icon to save the file

It is assumed that names of the DataSource parameters, function names and JNDI names to be the same as mentioned in the workshop manual and have coded the XmlController.java and the XMLDao.java having the business logic to retrieve the xml datatype from the xml_type table from the Oracle Converged Database in the PDB JXLPDB. 

The logic is so designed that the tags <order><id></id></order> is mandatory with <id> to have a numeric value.

If you change any of it, the code may not compile and lead to errors.  Request you to stick to the naming conventions.

5.	Right Click on **Converge** under **Projects**

6.	Click on **Run Maven** -> **redeploy**

    ![](./images/jdev_xmlcode_redeploy.png " ")

7.	In the JDeveloper Log message area, you will see the successful redeployment

    ![](./images/jdev_xmlcode_redeploy_success.png " ")


## Step 4: Read XML in tool

1.	Open the Firefox browser and navigate to http://localhost:7101/resources/html/endPointChecker.html. OR You can use the bookmark **DataType-End Point Check Utility** under **ConvergedDB-Workshp in Bookmark Toolbar**

2.	Click on the drop-down to see the list of datatypes shown in workshop

3.	Select **XML** datatype and click on **Change View** button to change

    ![](./images/tool_xml_blank.png " ")

4.	You will see the only xml item inserted to the xml table with ID=1 listed in the dropdown to fetch the details

5.	Click on “Fetch” button select 1 from the dropdown
    
    ![](./images/tool_xml_fetch_id1.png " ")

6.	Navigate back to JDeveloper and open **XMLDao.java** under **converge** -> **Application Sources** -> **converge.controllers**s
    
    ![](./images/jdev_read_xml_code.png " ")

The results are obtained by using the query under READ_XML string in XMLDao.java which has a built in functions offered for xml type handling called **XMLCAST** and **XMLQUERY**.

**XMLQUERY** lets you query XML data in SQL statements. It takes an XQuery expression as a string literal, an optional context item, and other bind variables and returns the result of evaluating the XQuery expression using these input values. XQuery string is a complete XQuery expression, including prolog.

**XMLCAST** casts value\_expression to the scalar SQL datatype specified by datatype. The value\_expression argument is a SQL expression that is evaluated. The datatype argument can be of datatype NUMBER, VARCHAR2, and any of the datetime datatypes.


## Step 5: XML REST end-point
   
1.	In JDeveloper, open **XMLController.java** under **converge** -> **Application Sources** -> **converge.controllers**. Search for **fetchXML** and check the function code.  The request mapping is done as **/read/{id}**.  The base rest end point being **/xml** for the code declared at the class level. Also see **getXmlIds()** function fetching all data by ID with rest end point **/ids**.

    ![](./images/jdev_xml_rest_code.png" ")

2.	Open firefox or if already open, in other browser tab, open the URL http://localhost:7101/xml/read/1 Data is retrieved by the fetchXml() method in XmlController.java

    ![](./images/rest_id1_retrieve.png" ")

3.	To retrieve all IDs, Open the URL http://localhost:7101/xml/ids Data is retrieved by the **getXmlIds()** method in XmlController.java

    ![](./images/rest_retrieve_all_ids.png" ")


## Step 6: Insert XML data 

1.	Navigate back to **endpointchecker** tool to insert a xml record

2.	Paste the text below as content in the text area and click on green **Insert** button

  ````
 <copy>
   <order>
<id>2</id>
<name>Your Name</name>
<address>
<pincode>572102</pincode>
</address>
</order>

   </copy>
    ````

    ![](./images/tool_xml_insert.png" ")

3.	If your xml is not valid., the record will not be inserted.  Try it also

4.	The xml will be inserted and in the dropdown, you will see the newly added ID

    ![](./images/tool_xml_insert_success.png" ")


## Step 7: Update XML data

1.	Fetch the xml with ID 2 and try to update it

2.	In the **text box** next to **Delete** button specify the tag element you need to update and in the corresponding text box specify the value to which the tag item needs to be updated 

    example, update the pincode value by providing /order/address/pincode as first parameter and 0000000  as the value

    ![](./images/tool_xml_fetch_id2_and_update.png" ")

3.	Click on blue **Update** button to update record for **pincode**. You will see a confirmation message.    

    ![](./images/tool_xml_update_success.png" ")

4.	To confirm the update retrieve the xml with ID 2 using the **Fetch** button. Check the update pincode in data.

    ![](./images/tool_xml_fetch_id2_post_update.png" ")

5.	Navigate back to JDeveloper and open the XMLDao.java. Check the query under **UPDATE_XML** STRING

    ![](./images/jdev_update_xml_sql.png" ")

    The Query uses updateXML function which is pre-built in database to support updates to data of xml datatype.

    UPDATEXML takes as arguments an XMLType instance and an XPath-value pair and returns an XMLType instance with the updated value. If XPath\_string is an XML element, then the corresponding value\_expr must be an XMLType instance.


## Step 8: Delete XML data

1.	Navigate back to the xml endpointchecker tool and fetch the xml with ID 2 from the dropdown

2.	Click on **Delete**

    ![](./images/tool_xml_delete.png" ")

3.	You will see that the id 2 is disappeared from the dropdown and a deletion success message is seen

    ![](./images/tool_xml_delete_success.png" ")

    You have seen how easy it is to query the data points with in XML using the Oracle Converged Database’s built-in functions for XML datatype.

## Want to learn more
- [XML](https://docs.oracle.com/en/database/oracle/oracle-database/19/adjsn/index.html)

## Acknowledgements
- **Authors** - Pradeep Chandramouli, Nishant Kaushik
- **Contributors** - Kanika Sharma, Laxmi Amarappanavar, Balasubramanian Ramamoorthy
- **Team** - North America Database and AppDev Specialists
- **Last Updated By** - Kanika Sharma, Solution Engineer, Oracle Database, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.

