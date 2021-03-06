<%@page import="java.io.InputStream"%>
<%@page contentType="text/html"%>
<%@page import ="java.sql.*"%>
<%@page import ="java.util.*"%>
<%
ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
InputStream propertiesFile = classLoader.getResourceAsStream("hr.properties");

if (propertiesFile == null) {
    throw new NullPointerException("Properties file 'hr.properties' is missing in classpath.");
}

Properties properties = new Properties();
properties.load(propertiesFile); // Handle IOException.

String oJDBCDriver = properties.getProperty("oJDBCDriver");
String oJDBCURL = properties.getProperty("oJDBCURL");
String oJDBCUser = properties.getProperty("oJDBCUser");
String oJDBCPassword = properties.getProperty("oJDBCPassword");

// Check if a user is logged
String oLoggedUser = (String) session.getAttribute( "logged-user" );
if ( oLoggedUser == null ) 
{
	response.sendRedirect( "login.jsp" );
	return;
}

// Retrieve logged user informations
String oLoggedUserFirstName  = (String) session.getAttribute( "logged-user-firstname" );
String oLoggedUserLastName   = (String) session.getAttribute( "logged-user-lastname" );
ArrayList oRoles = (ArrayList) session.getAttribute( "logged-user-privileges" );

// Check rights
if ( !oRoles.contains( "SELECT" ) )
{
	response.sendRedirect( "index.jsp?err=no_privilege&needed_privilege=SELECT" );
	return;
}

// Get layout configuration
String oTemplate = application.getInitParameter( "layout.template" ) != null ? application.getInitParameter( "layout.template" ) : "default";

// Retrieve filter parameters
String oAction 				= request.getParameter( "action" ) 		!= null ? (String) request.getParameter( "action" ) 		: "";
String oFilterUserID 		= request.getParameter( "userid" ) 		!= null ? (String) request.getParameter( "userid" ) 		: "";
String oFilterEmpType 		= request.getParameter( "emptype" ) 		!= null ? (String) request.getParameter( "emptype" ) 		: "";
String oFilterFirstName 	= request.getParameter( "firstname" ) 		!= null ? (String) request.getParameter( "firstname" ) 		: "";
String oFilterLastName 		= request.getParameter( "lastname" ) 		!= null ? (String) request.getParameter( "lastname" ) 		: "";
String oFilterDepartment 	= request.getParameter( "department" )		!= null ? (String) request.getParameter( "department" )		: "";
String oFilterLocation	 	= request.getParameter( "location" )	!= null ? (String) request.getParameter( "location" )	: "";
String oFilterPosition 		= request.getParameter( "position" ) 		!= null ? (String) request.getParameter( "position" ) 		: "";
String oFilterActive	 	= request.getParameter( "active" ) 		!= null ? (String) request.getParameter( "active" )		: "";
String oFilterCostCenter 	= request.getParameter( "costcenter" ) 		!= null ? (String) request.getParameter( "costcenter" )		: "";
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
		<title>HR Application</title> 
		<link rel="stylesheet" href="templates/<%= oTemplate %>/stylesheet1.css" media="screen">
		<style type="text/css" media="screen">@import url("templates/<%= oTemplate %>/stylesheet2.css");</style>
		<link rel="stylesheet" href="templates/<%= oTemplate %>/print.css" media="print">

		<script type="text/javascript" src="js/hr.js"></script>
		<script type="text/javascript" src="js/sorttable.js"></script>

		<link rel="shortcut icon" href="favicon.ico"/>
	</head>
	<body>
		<div id="container">
                        <div id="header" title="HR Application">
                            <div id="welcome">
                               <a href="session_data.jsp">Welcome <%= oLoggedUserFirstName %> <%= oLoggedUserLastName %>!</a>
                                <br/>Privileges: <%= oRoles %>
                           </div>
				<h1>My HR Application</h1>
			</div>
			<div id="mainnav">
				<ul>
					<li><a href="index.jsp">Home</a></li>
					<li><a href="index.jsp">Help</a></li>
					<li><a href="index.jsp">About</a></li>
					<li><a href="controller.jsp?action=logout">Logout</a></li>
				</ul>
			</div>
			<div id="menu">
				<h3>Employees</h3>
				<ul>
					<% if ( oRoles.contains( "SELECT" ) ) { %><li><a href="search.jsp">Search Employees</a></li><% } %>
					<% if ( oRoles.contains( "INSERT" ) ) {%><li><a href="employee_create.jsp">New Employee</a></li><% } %>
				</ul>
				<h3>Absence And Attendance</h3>
				<ul>
					<li><a href="#">Timesheets</a></li>
					<li><a href="#">Vacation</a></li>
				</ul>
			</div>
			<div id="content">
				<div id="minheight"></div>
				<div id="filter">
					<form name="search_employees" method="post" action="search.jsp" onsubmit="return checkSearchForm(this);">
						<input type="hidden" name="action" value="search"/>
						<h2>Search Employee</h2>
						<table cellpadding="3" cellspacing="2" border="0">
							<!-- tr><td colspan="2" style="text-align: right; background-color: #fff;"><input type="submit" value="Search"/></td></tr -->
							<tr>
								<th>HR ID</th><td><input type="text" name="userid" value="<%= oFilterUserID %>"/></td>
								<th>Active</th>
								<td>
									<select name="active">
										<option value="">-- Choose a value --</option>
										<option value="1" <% if ( oFilterActive.equals( "1" ) ) out.println( "selected=\"selected\"" ); %>>Active</option>
										<option value="0" <% if ( oFilterActive.equals( "0" ) ) out.println( "selected=\"selected\"" ); %>>Inactive</option>
									</select>
								</td>
							</tr>
							<tr><th>Employee Type</th>
								<td>
									<select name="emptype">
										<option value="">-- Choose a value --</option>
										<option value="Full-Time" <% if ( oFilterEmpType.equals( "Full-Time Employee" ) ) out.print( "selected=\"selected\"" ); %>>Full-Time Employee</option>
										<option value="Part-Time" <% if ( oFilterEmpType.equals( "Part-Time Employee" ) ) out.print( "selected=\"selected\"" ); %>>Part-Time Employee</option>
									</select>
								</td>
								<th>Position</th><td><input type="text" name="position" value="<%= oFilterPosition %>"/></td>
							</tr>
							<tr>
								<th>First Name</th><td><input type="text" name="firstname" value="<%= oFilterFirstName %>"/></td>
								<th>Last Name</th><td><input type="text" name="lastname" value="<%= oFilterLastName %>"/></td>
							</tr>
							<tr>
								<th>Department</th><td><input type="text" name="department" value="<%= oFilterDepartment %>"/></td>
								<th>Location</th><td><input type="text" name="location" value="<%= oFilterLocation %>"/></td>
							</tr>
							<!-- tr>
								<th>Cost Center</th><td><input type="text" name="costcenter" value="<%= oFilterCostCenter %>"/></td>
							</tr -->
						</table>
						<h2>Debug:</h2>

						<input type="checkbox" name="id" value="debug"> Yes<BR>
						<div class="buttonbar"><input type="submit" value="Search"/></div>
					</form>
				</div>
				<div id="employees_list">
					<h2>Search Result</h2>
					<table cellpadding="3" cellspacing="2" border="0" class="sortable">
					<tr>
						<th>HR ID</th>
						<th>Full Name</th>
						<!-- th>Email</th -->
						<!-- th>Phone Mobile</th -->
						<!-- th>Phone Fix</th -->
						<!-- th>Phone Fax</th -->
						<th>Emp Type</th>
						<th>Position</th>
						<!-- th>Is Manager</th -->
						<th>Manager</th>
						<th>Cost Center</th>
						<th>Department</th>
						<th>Location</th>
						<!-- th>Start Date</th -->
						<!-- th>End Date</th -->
						<th style="background-color: #fff;">&nbsp;</th>
					</tr>
					<%
					if ( oAction.equals( "search" ) )
					/* if (   !oFilterUserID.equals( "" )
						|| !oFilterEmpType.equals( "" )
						|| !oFilterFirstName.equals( "" )
						|| !oFilterLastName.equals( "" )
						|| !oFilterActive.equals( "" )
						|| !oFilterCostCenter.equals( "" )
						|| !oFilterDepartment.equals( "" )
						|| !oFilterLocation.equals( "" )
						|| !oFilterPosition.equals( "" ) ) */
					{
						try
						{
							Class.forName( oJDBCDriver );
							Connection conn = DriverManager.getConnection( oJDBCURL, oJDBCUser, oJDBCPassword );
						        Statement stmt = conn.createStatement();
								
								// Prepare query using filter parameters
								String oQuery = "select a.USERID, a.FIRSTNAME, a.LASTNAME, a.EMAIL, a.PHONEMOBILE, a.PHONEFIX, a.PHONEFAX, "
									+ "a.EMPTYPE, a.POSITION, a.ISMANAGER, a.MANAGERID, a.DEPARTMENT, a.LOCATION, a.STARTDATE, a.ENDDATE, a.ACTIVE, "
									+ "a.COSTCENTER, b.FIRSTNAME as MGR_FIRSTNAME, b.LASTNAME as MGR_LASTNAME, b.USERID as MGR_USERID "
									+ "from DEMO_HR_EMPLOYEES a left outer join DEMO_HR_EMPLOYEES b on a.MANAGERID = b.USERID where 1=1 ";
								//Check rights
								if ( oRoles.contains("ENGINEERING"))		{ oQuery += "and upper(a.DEPARTMENT) = 'ENGINEERING'";}
								if ( !oFilterUserID.equals( "" ) ) 		{ oQuery += "and a.USERID = " + oFilterUserID + " "; }
								if ( !oFilterLastName.equals( "" ) ) 		{ oQuery += "and upper(a.LASTNAME) like '" + oFilterLastName.toUpperCase() + "%' "; }
								if ( !oFilterFirstName.equals( "" ) ) 		{ oQuery += "and upper(a.FIRSTNAME) like '" + oFilterFirstName.toUpperCase() + "%' "; }
								if ( !oFilterDepartment.equals( "" ) )		{ oQuery += "and upper(a.DEPARTMENT) like '" + oFilterDepartment.toUpperCase() + "%' "; }
								if ( !oFilterCostCenter.equals( "" ) )		{ oQuery += "and upper(a.COSTCENTER) like '" + oFilterCostCenter.toUpperCase() + "%' "; }
								if ( !oFilterLocation.equals( "" ) )	{ oQuery += "and upper(a.LOCATION) like '" + oFilterLocation.toUpperCase() + "%' "; }
								if ( !oFilterPosition.equals( "" ) ) 		{ oQuery += "and upper(a.POSITION) like '" + oFilterPosition.toUpperCase() + "%' "; }
								if ( !oFilterEmpType.equals( "" ) ) 		{ oQuery += "and upper(a.EMPTYPE) like '" + oFilterEmpType.toUpperCase() + "%' "; }
								if ( !oFilterActive.equals( "" ) ) 		{ oQuery += "and a.ACTIVE = " + oFilterActive + " "; }
								
								oQuery += "order by a.LASTNAME, a.FIRSTNAME";

								// Execute query and display results
								ResultSet rs = stmt.executeQuery( oQuery );
								while (rs.next())
								{
									int    oUserID = rs.getInt("USERID");
									String oFirstName = rs.getString("FIRSTNAME") != null ? rs.getString("FIRSTNAME") : "";
									String oLastName = rs.getString("LASTNAME") != null ? rs.getString("LASTNAME") : "";
									String oEmail = rs.getString("EMAIL") != null ? rs.getString("EMAIL") : "";
									String oPhoneMobile = rs.getString("PHONEMOBILE") != null ? rs.getString("PHONEMOBILE") : "";
									String oPhoneFix = rs.getString("PHONEFIX") != null ? rs.getString("PHONEFIX") : "";
									String oPhoneFax = rs.getString("PHONEFAX") != null ? rs.getString("PHONEFAX") : "";
									String oEmpType = rs.getString("EMPTYPE") != null ? rs.getString("EMPTYPE") : "";
									String oPosition = rs.getString("POSITION") != null ? rs.getString("POSITION") : "";
									int    oIsManager = rs.getInt("ISMANAGER");
									int    oManagerID = rs.getInt("MANAGERID");
									String oCostCenter = rs.getString("COSTCENTER") != null ? rs.getString("COSTCENTER") : "";
									String oDepartment = rs.getString("DEPARTMENT") != null ? rs.getString("DEPARTMENT") : "";
									String oLocation = rs.getString("LOCATION") != null ? rs.getString("LOCATION") : "";
									java.util.Date oStartDate = rs.getDate("STARTDATE");
									java.util.Date oEndDate = rs.getDate("ENDDATE");
									int oActive = rs.getInt("ACTIVE");
									String oManagerFirstName = rs.getString("MGR_FIRSTNAME") != null ? rs.getString("MGR_FIRSTNAME") : "";
									String oManagerLastName = rs.getString("MGR_LASTNAME") != null ? rs.getString("MGR_LASTNAME") : "";
									int oManagerUserID = rs.getInt("MGR_USERID");
									%>	
									<tr>
										<td><%= oUserID %></td>
										<td><a href="employee_view.jsp?userid=<%= oUserID %>"><%= oLastName %>, <%= oFirstName %></a></td>
										<!-- td><%= oEmail %></td -->
										<!-- td><%= oPhoneMobile %></td -->
										<!-- td><%= oPhoneFix %></td -->
										<!-- td><%= oPhoneFax %></td -->
										<td><%= oEmpType %></td>
										<td><%= oPosition %></td>
										<!-- td><%= oIsManager %></td -->
										<td><% if ( oManagerID != 0 ) { %><a href="employee_view.jsp?userid=<%= oManagerID %>"><%= oManagerLastName + ", " + oManagerFirstName %></a><% } %></td>
										<td><%= oCostCenter %></td>
										<td><%= oDepartment %></td>
										<td><%= oLocation %></td>
										<!-- td><%= oStartDate %></td -->
										<!-- td><%= oEndDate %></td -->
										<td><span style="display: none;"><%= oActive %></span><img src="images/icon_active_<%= oActive %>.gif" width="16" height="16" title="<% if ( oActive == 1 ) out.print( "Active" ); else out.print( "Inactive" ); %>"/></td>
									</tr>

									<%

								}
								
									String select[] = request.getParameterValues("id");
									if (select != null && select.length != 0) {
										out.println(oQuery);
									}
								

						        stmt.close();
						}
						catch(Exception e)
						{
							e.printStackTrace();
							out.println( e );
						}
					}
					%>
					</table>
				</div>
			</div>
			<div id="footer">
				<a href="index.jsp">My HR Application</a> | <a href="#">My Intranet</a> | <a href="#">My Self-Service</a><br/>
				Copyright &copy; My HR Application 2008
			</div>
		</div>
	</body>
</html>
