# Introduction

## About Java EE ##

Java Platform, Enterprise Edition (Java EE) is the standard in community-driven enterprise software. Java EE is developed using the Java Community Process, with contributions from industry experts, commercial and open source organizations, Java User Groups, and countless individuals. Each release integrates new features that align with industry needs, improves application portability, and increases developer productivity.

The Java EE platform is designed to help developers create large-scale, multitiered, scalable, reliable, and secure network applications. A shorthand name for such applications is enterprise applications, so called because these applications are designed to solve the problems encountered by large enterprises.The benefits of an enterprise application are helpful, even essential, for individual developers and small organizations in an increasingly networked world.

The Enterprise Application Model

![](./images/enterprise_application_model.png " ")


Java EE servers host several application component types that correspond to the tiers in a multitiered application. The Java EE server provides services to these components in the form of a container.

Java EE containers are the interface between the component and the lower-level functionality provided by the platform to support that component. The functionality of the container is defined by the platform and is different for each component type. Nonetheless, the server allows the different component types to work together to provide functionality in an enterprise application.

## About Oracle WebLogic Server

Oracle WebLogic Server is a scalable, enterprise-ready Java Platform, Enterprise Edition (Java EE) application server. The WebLogic Server infrastructure supports the deployment of many types of distributed applications and is an ideal foundation for building applications based on Service Oriented Architectures (SOA). 

The WebLogic Server complete implementation of the Java EE 6.0 specification provides a standard set of APIs for creating distributed Java applications that can access a wide variety of services, such as databases, messaging services, and connections to external enterprise systems. End-user clients access these applications using Web browser clients or Java clients. It also supports the Spring Framework, a programming model for Java applications which provides an alternative to aspects of the Java EE model.

![](./images/weblogic_architecture.png " ")

In addition to the Java EE implementation, WebLogic Server enables enterprises to deploy mission-critical applications in a robust, secure, highly available, and scalable environment. These features allow enterprises to configure clusters of WebLogic Server instances to distribute load, and provide extra capacity in case of hardware or other failures.

WebLogic Server with same features of on-premise installation is also available on Oracle Cloud Infrastructure, as an option to be deployed on Azure IaaS, as Docker Images and also as WebLogic Operator for deployment on Kubernetes Clusters to help application modernization and support lightweight and largely scalable deployment options.

### Objectives

In this workshop, you'll gain first-hand experience of using data types beyond relational data - JSON, XML, Spatial and Graph.

You will walk through the different components of a JEE application, know how to use datasource in WebLogic, deploy an application from JDeveloper on to a linked WebLogic Server.  

You will also see how to create REST endpoints to present data over HTTP/HTTPS in JSON format and also see CRUD operations on different data types.

You will get experience of using ORDS end-point in Java Code and also see JDeveloper’s potential to be used as an IDE to connect to database and also develop JEE applications.

Once you complete your setup, the next labs in this workshop cover these individual data types, and the final lab consists of ORDS examples:

- Lab 4: eSHOP Application
- Lab 5: Data Type Demonstration Tool
- Lab6: JSON 
- Lab 7: XML
- Lab 8: SPATIAL
- Lab 9: Cross Data Type
- Lab 10: ORDS as Microservice

You will also download VNC Client, setup SSH tunnelling to consume the JDeveloper installed on the workshop instance.

### Prerequisites

- VNC Client, PuTTY tool 
- An Oracle Cloud account, Free Trial, LiveLabs or a Paid account

*Estimated Workshop Time*: 3 hours

*Please proceed to the first lab*

## More Information
Feel free to share with your colleagues

Java EE
- [Oracle J2EE (JEE)](https://www.oracle.com/in/java/technologies/java-ee-glance.html)

WebLogic Resources
- [Video PageBlogs](https://www.youtube.com/user/OracleWebLogic)
- [White Paper](https://www.oracle.com/middleware/weblogic/resources.html)
- [Product Page](https://www.oracle.com/java/weblogic/)

JDeveloper
- [Overview Video](https://www.youtube.com/watch?v=63rnCGawF9w)
- [Product Tutorial](https://docs.oracle.com/cd/E53569_01/tutorials/tut_ide/tut_ide.html)
- [Java Application Development](https://www.oracle.com/application-development/technologies/jdeveloper.html)

## Acknowledgements
- **Authors** - Pradeep Chandramouli, Nishant Kaushik, Kanika Sharma, Laxmi Amarappanavar, Balasubramanian Ramamoorthy, AppDev & Database Team, Oracle, October 2020
- **Contributors** - Meghana Banka, Rene Fontcha
- **Last Updated By/Date** - Kanika Sharma, NA Technology, October 2020

## See an issue?
Please submit feedback using this [form](https://apexapps.oracle.com/pls/apex/f?p=133:1:::::P1_FEEDBACK:1). Please include the *workshop name*, *lab* and *step* in your request.  If you don't see the workshop name listed, please enter it manually. If you would like us to follow up with you, enter your email in the *Feedback Comments* section.



