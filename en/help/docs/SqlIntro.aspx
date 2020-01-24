<%@ Page Title="" Language="C#" MasterPageFile="../HelpMaster.master" AutoEventWireup="true" CodeBehind="RealQuery.aspx.cs" Inherits="SkyServer.Help.Docs.RealQuery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HelpContent" runat="server">
<div id="title">Getting Started with SQL</div>

<div id="transp">

<table WIDTH=800 border=0 cellspacing="3" cellpadding="3">
<tr><td bgcolor="black">
<p>
This page contains a sample queries designed to serve as a tutorial to begin writing your own SQL queries. The first section, <em>Basic SQL</em>, serves 
as an introduction to the syntax of the SQL database access language, and how to use it to query SDSS data in the SkyServer. The 
sections that follow feature queries written to solve real 
scientific problems submitted by astronomers. The queries are organized into increasing order of complexity.
</p>

<p>
Click on the name of the query in the list below to go directly to that
sample query. You can load the query into SkyServer's 
<a href="<%=url%>/tools/search/sql.aspx">SQL Query tool</a> by clicking 
on the <img src="images/load.gif" height=25 align=middle /> button above each
query. You can then modify the query to suit your needs. Alternatively, you can 
send each query to the database and see the results by clicking on the <img
src="images/run.gif" height=25 align=middle /> button.  

<p>
<b>NOTE</b>: Please read the <a href="#hints">query hints</a> below 
before you try any queries, especially if you are new to SQL or the SkyServer.
</p>

<table width=800 align=center>
<tr>
<td class='tsml'>
<a href="#first">First simple query</a>
<br><a href="#basic">Basic SELECT-FROM-WHERE</a>
<br><a href="#between">Search for a Range of Values - BETWEEN</a>
<br><a href="#countgroup">Counting objects: Aggregation - GROUP BY</a>
<br><a href="#join">Searching more than one table: JOIN</a>
<br><a href="#repeatz">Repeated high-<i>z</i> objects - self-join and ORDER BY</a>
<br><a href="#starflag">Using flags - calling a scalar function</a>
<br><a href="#spatial">Basic position search - using a table-valued function</a>
</td>

<td width="5">&nbsp;</td>

<td class='tsml'>
<a href="#rect">Rectangular position search</a>
<br><a href="#countsbytype">Counts by type & program: Nested GROUP/ORDER BY</a>
<br><a href="#outer">Using LEFT OUTER JOIN</a>
<br><a href="#objcount">Object counting and logic: SUM and CASE</a>
<br><a href="#nested">Using Nested Queries: POWER and CAST</a>
<br><a href="#repeat">Finding plates with repeat spectra: COUNT(DISTINCT)</a>
<br><a href="#timeseries">Multiple Detections and Time Series: CROSS APPLY</a>
<br><a href="#footprint">Checking SDSS footprint: OUTER APPLY</a>

</td>
</tr>
</table>

<p><a name="hints"></a>
Some hints on searching SkyServer:</p>
<ol>
   <li>If you're not sure how many objects a query is going to return, it's always a good idea to either use the "SELECT TOP x" construct to return only the first x matching rows, or first do a "count" query, e.g. <br>
&nbsp;&nbsp;   "SELECT TOP 10 objID, ra, dec FROM <a href"<%=url%>/help/browser/browser.aspx?cmd=description+Galaxy+V">Galaxy</a> WHERE ..." <br>
OR <br>
&nbsp;&nbsp;   "SELECT count(*) FROM <a href"<%=url%>/help/browser/browser.aspx?cmd=description+Galaxy+V">Galaxy</a> WHERE ..." <br>so as to get an idea of how many objects 
   will be returned, so you don't find yourself waiting a lot longer than you expected to.
   </li>
   <li>Note that when you ask for the first x objects using "SELECT TOP x ...", this is not a deterministic ordering; the "TOP 10" objects may be different if you run the same query again. There is no concept of default order in relational tables, any order is explicitly imposed by the user using the ORDER BY clause, see later. In most cases, if you don't specify an order, you may actually get the objects in the order they are stored on disk, which is in the order of the Primary Key (clustered index).  However, this order may be superseded by what order the objects may be in the cache at any given time. Also note that the "SELECT TOP x" syntax is specific to SQL Server, other flavors of SQL may have slightly different ways to achieve the same thing. In general, you will see all the sample SkyServer queries incorporate a TOP x qualifier so that the query runs quickly.
   </li>
   <li>If even a count query takes a long time, this is a good indication that the actual query will take a much longer time to run, 
   so you should check if you have formulated the query correctly and in the most efficient way. Some advice on how to write efficient 
   queries can be found in the <a href="<%=url%>/help/docs/sql_help.aspx#optquery">Optimzing Queries</a> 
   section of the <a href="<%=url%>/help/docs/sql_help.aspx">SQL in SkyServer</a>.
   </li>
   <li>If you have optimized your query and it still takes much longer to run than you think it should, try again at a different time. 
   Sometimes when many queries are being run simultaneously, the servers can take a longer time to return. This in turn can sometimes result 
   in queries timing out, even though they would run perfectly well on the server when the server load is less.
   <li>If your query returns a lot of output (more than a few thousand objects), it is generally not a good idea to select the HTML output 
   format (which is selected by default in the <a href="../../tools/search/sql.aspx">SQL Search</a> tool). Instead, try selecting CSV (comma-separated 
   value) output. However, for all queries that return many objects, you are much better off using the 
   <a href="http://skyserver.sdss.org/casjobs">CasJobs</a> batch query service or another asynchronous service like <a href="http://apps.sciserver.org/compute/">SciServer Compute</a>. 
   </li>
   <li>Be sure to exclude invalid values (unset or uncalculated quantities), as described on the SQL in SkyServer page under 
   <a href="<%=url%>/help/docs/sql_help.aspx#invalid">Excluding Invalid Data Values</a>.
   </li>
   <li>SkyServer returns all values with a default precision. For some applications (such as doing high-precision astrometry with 
   RA and Dec values), the default precision is not enough. For these applications, use the <b>STR(<i>column</i>,<i>n</i>,<i>d</i>)</b> SQL 
   construct (where <i>n</i> is the total number of digits and <i>d</i> is the number of decimal places) to set the precision of the column that your query requests. The SkyServer returns values with a default 
   precision that is set for each data type, and this may not be enough for columns like ra, dec etc. 
   See the <a href="#nbrrun">Selected neighbors in run</a> sample query below for examples of how to use STR.
   </li>
</ol>
<p><br><br>

<%
	string cmdRun;
	string qName = "first";
	string qry = "First Simple Query";
	string tableDef = "<table width=800 border=0 cellspacing=0 cellpadding=0 bgcolor=#222266>\r\n<tr><td colspan=2>\r\n";
	string cmd = tableDef;
    	string cmd2;

	cmd += "-- This is the \"Hello World\" example of how to write a SQL query.<br>\r\n";
	cmd += "<br>\r\n";
	
	cmd += "-- This is a first very simple SQL query:<br>\r\n";
	cmd += "-- <b>SELECT [variables] FROM [table] without any constraints </b><br>\r\n";
	cmd += "-- Note that we have included a TOP qualifier to make sure this is a limited query result.<br>\r\n";
	cmd += "-- This sample query returns the unique object ID and the ra,dec for the first 10 random objects<br>\r\n";
	cmd += "-- in the PhotoObjAll table.<br>\r\n";
	cmd += "<br>\r\n";	
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 10</td> </tr>\r\n";
	cmd += "<tr> <td> <dd>   objID, ra ,dec </dd>    </td> 		<td> -- Get the unique object ID and coordinates</td> </tr>\r\n";
	cmd += "<tr> <td> FROM </td> </tr>\r\n";
	cmd += "<tr> <td> <dd> <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll</a>	</dd>	</td> <td> -- From the table containing photometric data</td> </tr>\r\n";
	cmd += "<tr> <td colspan=2><br></td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );

	qName = "basic";
	qry = "Basic SELECT-FROM-WHERE";
	tableDef = "<table width=720 border=0 cellspacing=0 cellpadding=0 bgcolor=#222266>\r\n<tr><td colspan=2>\r\n";
	cmd = tableDef;
	cmd += "-- This query shows the basic structure of a SQL query:<br>\r\n";
	cmd += "-- <b>SELECT [variables] FROM [table] WHERE [constraints]</b><br>\r\n";
	cmd += "-- Although many of your SQL queries will be more complex,<br>\r\n";
    cmd += "-- they will all follow this same basic structure.<br>\r\n";
	cmd += "-- This sample query finds <u>unique</u> objects in an RA/Dec box.<br>\r\n";
	cmd += "-- This query introduces the concept of a <b>view</b> or virtual table, <b>PhotoPrimary</b>.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- For a more efficient way to find objects by position, see the <a href=\"#spatial\">Basic position search</a> query.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "<br>\r\n";	
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 100</td> </tr>\r\n";
	cmd += "<tr> <td> <dd>   objID, ra ,dec </dd>    </td> 		<td> -- Get the unique object ID and coordinates</td> </tr>\r\n";
	cmd += "<tr> <td> FROM </td> </tr>\r\n";
	cmd += "<tr> <td> <dd> <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoPrimary+V\">PhotoPrimary</a>	</dd>	</td> <td> -- View of PhotoObjAll containing photometric data for unique objects </td> </tr>\r\n";
	cmd += "<tr> <td colspan=2> WHERE </td> </tr>\r\n";
	cmd += "<tr> <td> <dd> ra &gt; 185 and ra &lt; 185.1 </dd>  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd> AND dec &gt; 15 and dec &lt; 15.1 </dd> </td> <td> -- that matches our criteria </td> </tr>\r\n";
	cmd += "<tr> <td colspan=2><br></td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );


	qName = "between";
	qry = "Search for a Range of Values: BETWEEN";
	cmd = tableDef;
	cmd += "-- The BETWEEN statement can be used to set constraints on a range of values.</br>\r\n";
	cmd += "-- This sample query finds galaxies with g magnitudes between 18 and 19.</br>\r\n";
	cmd += "-- It uses another view, <b>Galaxy</b>, that contains only objects classified as galaxies.</br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 10 objID, cModelMag_g </td> </tr>\r\n";
	cmd += "<tr> <td> FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Galaxy+V\">Galaxy</a>     </td> </tr>\r\n";
	cmd += "<tr> <td> WHERE </td></tr>\r\n";
	cmd += "<tr> <td> <dd>   cModelMag_g between 18 and 19</td> <td> -- 18 &lt cModelMag_g &lt 19</td> </tr>\r\n";
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );
	

	qName = "countgroup";
	qry = "Counting objects: Aggregation - GROUP BY";
	cmd = tableDef;
	cmd += "-- This simple query introduces two important SQL structures while showing how to count the number of<br>\r\n";
	cmd += "-- spectra of each spectral classification (galaxy, quasar, star).<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- When included in the SELECT block, the <b>COUNT(*)</b> statement returns the <b>number</b> of objects that<br>\r\n";
	cmd += "-- meet your search criteria.<br>\r\n";
	cmd += "-- The <b>GROUP BY</b> statement sorts results into groups (categories) based on the value of a data column.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- In this query, the grouping occurs on the 'class' column of the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObj+V\">SpecObj</a> view, which contains<br>\r\n";
	cmd += "-- the spectral classification of the object.<br>\r\n";
	cmd += "-- The query can be easily modified to find object counts sorted by other columns.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- For another example, see the <a href='#countsbytype'>Counts by Type and Program</a> sample query.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT class, COUNT(*) <br>\r\n";
	cmd += "FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObj+V\">SpecObj</a> <br>\r\n";
	cmd += "GROUP BY class\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );	


	qName = "join";
	qry = "Searching more than one table: JOIN";
	cmd = tableDef;
	cmd += "-- When you need to search for data in two or more tables, you must <b>\"join\"</b> the tables<br>\r\n";
	cmd += "-- together for the purposes of your query by using a JOIN...ON statement.<br>\r\n";
	cmd += "-- JOIN...ON allows you to search for data and/or constraints in both tables.<br>\r\n";
	cmd += "-- The syntax of the statement is:<br>\r\n";
	cmd += "-- <b>JOIN [the second table] ON [a variable the tables have in common]</b>.<br>\r\n"; 
	cmd += "-- The variable the tables have in common is called the \"key\" (think of it<br>\r\n";
	cmd += "-- as the key that unlocks your ability to search two tables).<br>\r\n";
	cmd += "-- The JOIN also requires the use of <b>table aliases</b> that uniquely idenfity each table<br>\r\n";
	cmd += "-- (\"s\" and \"p\") so that the join condition can be specified and columns can be selected from each<br>\r\n";
	cmd += "-- table (especially if columns with the same name exist in both tables). The \"AS\" is optional.<br>\r\n";
	cmd += "-- NOTE: This is the <u>only</u> way you should query multiple tables, i.e. using the explicit JOIN <br>\r\n";
	cmd += "-- syntax.  There is an implicit join syntax where you separate table names with commas. <br>\r\n";
	cmd += "-- <b>DO NOT USE THAT, EVER!</b> <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- This query looks for spectra of high-redshift quasars and shows the date and time at which<br>\r\n";
	cmd += "-- each spectrum was taken. It requires us to join the SpecObjAll table (spectra) with the PlateX<br>\r\n";
	cmd += "-- table in order to get the time of observation, which is contained in the spectroscopic plate.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 100";
	cmd += "<tr> <td> <dd>  s.specObjID,  </td> </tr>\r\n";	
	cmd += "<tr> <td> <dd>  s.ra,  </td> </tr>\r\n";	
	cmd += "<tr> <td> <dd>  s.dec,  </td> </tr>\r\n";	    	
	cmd += "<tr> <td> <dd>  s.mjd,  </td> </tr>\r\n";		
	cmd += "<tr> <td> <dd>  p.taiBegin,  </td> </tr>\r\n";	
	cmd += "<tr> <td> <dd>  p.taiEnd,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  s.fiberID,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  s.z  </td> </tr>\r\n";
	cmd += "<tr> <td> FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a> AS s &nbsp;-- table containing all spectra</td> </tr>\r\n";
	cmd += "<tr> <td> JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PlateX+U\">PlateX</a> AS p &nbsp;&nbsp;&nbsp; -- table containing spectroscopic plate information";
	cmd += "<tr> <td> <dd> ON s.plateID = p.plateID &nbsp; -- join key is unique plate identifier</td></tr>\r\n";
	cmd += "<tr> <td> WHERE </td></tr>\r\n";
	cmd += "<tr> <td> <dd>  (s.class='QSO') </td></tr>\r\n";
	cmd += "<tr> <td> <dd>  AND s.z > 3 </td></tr>\r\n";		
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );


	qName = "repeatz";
	qry = "Repeated high-<i>z</i> objects: self-join and ORDER BY";
	cmd = tableDef;
	cmd += "-- Compare different redshift measurements of the same object for objects with high redshift.\r\n";
	cmd += "<br>-- This query introduces two new things: the <b>self-join</b>, and the ORDER BY clause.\r\n";
	cmd += "<br>\r\n";
	cmd += "<br>SELECT prim.bestObjId, prim.mjd AS PrimMJD, prim.plate AS PrimPlate, \r\n";
	cmd += "<br>&nbsp;&nbsp;&nbsp; other.mjd AS OtherMJD, other.plate AS OtherPlate,\r\n";
	cmd += "<br>&nbsp;&nbsp;&nbsp; prim.z AS PrimZ, other.z AS OtherZ, plate.programname\r\n";
	cmd += "<br>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a> prim\r\n";
	cmd += "<br>&nbsp;&nbsp;&nbsp; JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a> other ON prim.bestObjId = other.bestObjId &nbsp; -- join table with itself\r\n";
	cmd += "<br>&nbsp;&nbsp;&nbsp; JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+platex+U\">platex</a> AS plate ON other.plate = plate.plate AND other.mjd = plate.mjd\r\n";
	cmd += "<br>WHERE other.bestObjId &gt; 0\r\n";
	cmd += "<br>&nbsp;&nbsp;&nbsp; AND prim.sciencePrimary = 1\r\n";
	cmd += "<br>&nbsp;&nbsp;&nbsp; AND other.sciencePrimary = 0\r\n";
	cmd += "<br>&nbsp;&nbsp;&nbsp; AND prim.z &gt; 2.5\r\n";
	cmd += "<br>ORDER BY prim.bestObjId\r\n";
	cmd += "<br><br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "starflag";
	qry = "Using flags: calling a scalar function";
	cmd = tableDef;
	cmd += "-- Another useful query is to select stars that are not saturated.<br> \r\n";
	cmd += "-- It demonstrates the use of <u>scalar</u> functions, actually two functions to get information on flags.<br> \r\n";
	cmd += "-- This query introduces bitwise logic for flags, and uses the 'as' syntax to <br>\r\n";
	cmd += "-- make the query more readable. Note that if a flag is not set, the value <br>\r\n";
	cmd += "-- will be zero. If you want to ensure multiple flags are not set, you can <br>\r\n";
	cmd += "-- either check that each individually is zero, or their sum is zero. <br>\r\n";
	cmd += "--   (From <a href=\"mailto:gtr@astro.princeton.edu\">Gordon Richards</a>) <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- <b>Important caveat</b>: The 'flags' column is the union of the flag values in  <br>\r\n";
	cmd += "-- each band,and using it may produce unexpected results, for example if a <br>\r\n";
	cmd += "-- bad flag bit is set in only one band (e.g. in the 'flags_r' value), that bit <br>\r\n";
	cmd += "-- will be bad in the overall 'flags' value as well.  For more information, <br>\r\n";
	cmd += "-- please see the <a href=\""+globals.SdssUrl+"algorithms/flags_detail.php\">'Photometric flags detail' entry in Algorithms.</a> <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- NOTE: This query takes a long time to run without the \"TOP 1000\". <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 1000  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  objID,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  ra,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  dec,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  psfMag_u, psfMag_g, psfMag_r, psfMag_i, psfMag_z,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  <a href=\""+url+"/help/browser/browser.aspx?cmd=description+fPhotoFlagsN+F\">dbo.fPhotoFlagsN</a>(flags) &nbsp; -- function to get name of flag </td></tr>\r\n";
	cmd += "<tr> <td> FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Galaxy+V\">Galaxy</a>  </td> </tr>\r\n";
	cmd += "<tr> <td> WHERE  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>  (flags & (dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fPhotoFlags+F\">fPhotoFlags</a>('SATURATED'))) != 0 &nbsp; -- function to get bitmask of flag </td> </tr>\r\n";
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );


	qName = "spatial";
	qry = "Basic position search - using a table-valued function";
	cmd = tableDef;
	cmd += "-- Find galaxies within 1' of a given point (ra=185.0, dec=-0.5). <br>\r\n";
	cmd += "-- Introduces table-valued functions (TVF). Basically, you can substitute a  TVF call wheerver you<br>\r\n";
	cmd += "-- would use a table-ref in the query, in this case in the JOIN. Note that just as for a table, you <br>\r\n";
	cmd += "-- use a table alias for the table the function returns. This query also uses ORDER BY.<br>\r\n";
	cmd += "-- The TVF it calls is from a class of cone search functions that return objects near a given position.<br>\r\n";
	cmd += "-- around any point in the sky.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 100 G.objID, GN.distance\r\n";
	cmd += "<tr> <td> FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Galaxy+V\">Galaxy</a> as G\r\n";
	cmd += "<tr> <td> JOIN dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fGetNearbyObjEq+F\">fGetNearbyObjEq(185.,-0.5, 1)</a> AS GN\r\n";
	cmd += "<tr> <td> <dd>  ON G.objID = GN.objID\r\n";
	cmd += "<tr> <td> ORDER BY distance\r\n";
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "rect";
	qry = "Rectangular position search";
	cmd = tableDef;
	cmd += "-- There are several built-in functions available to CAS users that make spatial\r\n";
	cmd += "<br>-- queries, i.e., those with coordinate cuts, much more efficient than simply\r\n";
	cmd += "<br>-- including the coordinate constraints in the WHERE clause. \r\n";
	cmd += "<br>-- This  example shows both ways to do it:\r\n";
	cmd += "<br>-- The first version uses straight coordinate cuts to select a rectangular box.\r\n";
	cmd += "<br>-- The second version illustrates the use of the dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fGetObjFromRectEq+F\">fGetObjFromRectEq</a> function (another \r\n";
	cmd += "<br>-- example of a TVF) that invokes the <a href=\"http://www.skyserver.org/htm/\">Hierarchical Triangular Mesh (HTM)</a>. \r\n";
	cmd += "<br>\r\n";
	cmd += "<br>-- a) Rectangular search using straight coordinate constraints:\r\n";
	cmd += "<br>SELECT TOP 100 objID, ra, dec \r\n";
	cmd += "<br>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObj+V\">PhotoObj</a> &nbsp; -- a view of \"good\" PhotoObjAll photometry \r\n";
	cmd += "<br>WHERE (ra between 179.5 and 182.3) and (dec between -1.0 and 1.8)\r\n";
	cmd += "<br>\r\n";
	cmd += "<br>-- b) This query can be rewritten as follows to use the HTM function that returns a\r\n";
	cmd += "<br>-- rectangular search area (The \"Run this Query\" button above will run this query):\r\n";
	cmd += "<br>\r\n";
	cmd2 = "<br>SELECT TOP 100 p.objID, p.ra, p.dec\r\n";
	cmd2 += "<br>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObj+V\">PhotoObj</a> p \r\n";
	cmd2 += "<dd>JOIN dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+GetObjFromRectEq+F\">fGetObjFromRectEq</a>(179.5, -1.0, 182.3, 1.8) r ON p.objID = r.objID\r\n";
	cmd2 += "<br><br></td></tr>\r\n";
	cmd2 += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd+cmd2 );


	qName = "countsbytype";
	qry = "Counts by type & program: Nested GROUP/ORDER BY";
	cmd = tableDef;
	cmd += "-- List the number of each type of object observed by each special spectroscopic observation <br>\r\n";
	cmd += "-- program. This query provides an example of GROUP BY and ORDER BY on more than one column. <br>\r\n";
	cmd += "-- . <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr><td>SELECT plate.programname, class, \r\n";
	cmd += "<dd>COUNT(specObjId) AS numObjs </td></tr>\r\n";
	cmd += "<br><tr><td>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a>\r\n";
	cmd += "<dd>JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PlateX+U\">PlateX</a> AS plate ON plate.plate = specObjAll.plate</td></tr>\r\n";
	cmd += "<br><tr><td>GROUP BY plate.programname, class</td></tr>\r\n";
	cmd += "<br><tr><td>ORDER BY plate.programname, class</td></tr>\r\n";
	cmd += "<br><br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "outer";
	qry = "Using LEFT OUTER JOIN";
	cmd = tableDef;
	cmd += "-- This query demonstrates the use of a LEFT OUTER JOIN to include rows from the joined table<br>\r\n";
	cmd += "-- that do not satisfy the JOIN condition. The OUTER JOIN (LEFT or RIGHT) <br>\r\n";
	cmd += "-- is an <i>inclusive</i> JOIN, whereas the INNER (default) JOIN is an <i>exclusive</i> JOIN. <br>\r\n";
	cmd += "-- In this case the query returns galaxies with or without spectra that meet the criteria <br>\r\n";
	cmd += "-- in the WHERE clause. The ISNULL operator is used to replace null <br>\r\n";
	cmd += "-- values with zeros for galaxies without spectra.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT TOP 10 p.objid, p.ra, p.dec, ISNULL(s.specobjid,0) AS specobjid, ISNULL(s.z, 0) AS z <br>\r\n";
	cmd += "FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Galaxy+V\">Galaxy AS p</a>\r\n";
	cmd += "<dd>LEFT OUTER JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObj+V\">SpecObj</a> s ON s.bestObjID = p.objID  </td> </tr>\r\n";
	cmd += " <tr> <td>WHERE \r\n";
	cmd += "<dd>p.u BETWEEN 0 AND 19.6 AND p.g BETWEEN 0 AND 20\r\n";
	cmd += "<br>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );
	

	qName = "objcount";
	qry = "Object counting and logic: SUM and CASE";
	cmd = tableDef;
	cmd += "-- Using object counting and logic in a query. <br>\r\n";
	cmd += "-- Find all objects similar to the colors of a quasar at 5.5<redshift<6.5.   <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT count(*) 					as 'total', 	\r\n";
	cmd += "<tr> <td> <dd>sum( case when (Type=3) then 1 else 0 end) 		as 'Galaxies',\r\n";
	cmd += "<tr> <td> <dd>sum( case when (Type=6) then 1 else 0 end) 		as 'Stars',\r\n";
	cmd += "<tr> <td> <dd>sum( case when (Type not in (3,6)) then 1 else 0 end) 	as 'Other'\r\n";
	cmd += "<tr> <td>  FROM 	<a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoPrimary+V\">PhotoPrimary</a>				-- for each object\r\n";
	cmd += "<tr> <td>  WHERE (( u - g &gt; 2.0) or (u &gt; 22.3) ) 	-- apply the quasar color cut.\r\n";
	cmd += "<tr> <td> <dd>   and ( i between 0 and 19 ) \r\n";
	cmd += "<tr> <td> <dd>   and ( g - r &gt; 1.0 ) \r\n";
	cmd += "<tr> <td> <dd>   and ( (r - i &lt; 0.08 + 0.42 * (g - r - 0.96)) or (g - r &gt; 2.26 ) )\r\n";
	cmd += "<tr> <td> <dd>   and 	( i - z &lt; 0.25 )\r\n";
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );


	qName = "nested";
	qry = "Using Nested Queries: POWER and CAST";
	cmd = tableDef;
	cmd += "-- This query demonstrates, among other tings, the use of a <i>nested</i> query (a query <br>\r\n";
	cmd += "-- inside another query) in which the outer query operates on the result of the inner query.  The  <br>\r\n";
	cmd += "-- query also gets the sky brighness and turns it into a flux, which illustrates the use of    <br>\r\n";
	cmd += "-- the POWER() function and CAST to change the string representation into floating             <br>\r\n";
	cmd += "-- point.  The <a href=\""+url+"/help/browser/browser.aspx?cmd=description+First+U\">First</a> table contains matches between SDSS and FIRST survey objects.             <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT TOP 10 fld.run, fld.avg_sky_muJy, fld.runarea AS area, ISNULL(fp.nfirstmatch,0) <br>\r\n";
	cmd += "FROM ( <br>\r\n";
	cmd += "--first part: for each run, get total area and average sky brightness <br>\r\n";
	cmd += "<dd>        SELECT run, sum(primaryArea) AS runarea,\r\n";
	cmd += "<dd>        3631e6*avg(power(cast(10. as float),-0.4*sky_r)) as avg_sky_muJy\r\n";
	cmd += "<dd>        FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Field+U\">Field</a>\r\n";
	cmd += "<dd>        GROUP BY run <br>\r\n";
	cmd += ") AS fld <br>\r\n";
	cmd += "LEFT OUTER JOIN ( <br>\r\n";
	cmd += "-- second part: for each run,get total number of FIRST matches. To get the run number <br>\r\n";
	cmd += "-- for each FIRST match, need to join FIRST with PHOTOPRIMARY. Some runs may have     <br>\r\n";
	cmd += "-- 0 FIRST matches, so these runs will not appear in the result set of this subquery. <br>\r\n";
	cmd += "-- But we want to keep all runs from the first query in the final result, hence       <br>\r\n";
	cmd += "-- we need a LEFT OUTER JOIN between the first and the second query.                  <br>\r\n";
	cmd += "-- The LEFT OUTER JOIN returns all the rows from the first subquery and matches       <br>\r\n";
	cmd += "-- with the corresponding rows from the second query. Where the second query          <br>\r\n";
	cmd += "-- has no corresponding row, a NULL is returned. The ISNULL() function in the         <br>\r\n";
	cmd += "-- SELECT above converts this NULL into a 0 to say \"0 FIRST matches in this run\".     <br>\r\n";
	cmd += "<dd>        SELECT p.run, count(*) AS nfirstmatch\r\n";
	cmd += "<dd>        FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+First+U\">FIRST</a> AS fm\r\n";
	cmd += "<dd>        INNER JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoPrimary+V\">photoprimary</a> as p\r\n";
	cmd += "<dd>        ON p.objid=fm.objid\r\n";
	cmd += "<dd>        GROUP BY p.run <br>\r\n";
	cmd += ") AS fp <br>\r\n";
	cmd += "ON fld.run=fp.run <br>\r\n";
	cmd += "ORDER BY fld.run <br>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );	


	qName = "repeat";
	qry = "Finding plates with repeat spectra: COUNT(DISTINCT)";
	cmd = tableDef;
	cmd += "-- A query to list plates that have objects in common. <br>\r\n";
	cmd += "-- Returns the pairs of plates, the total number of nights <br>\r\n";
	cmd += "-- on which the objects they have in common have been observed, the progam to <br>\r\n";
	cmd += "-- which the special plate belongs, and the number of objects the plates <br>\r\n";
	cmd += "-- have in common. <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "<tr><td>SELECT first.plate, other.plate, \r\n";
	cmd += "<dd>  COUNT(DISTINCT other.mjd) + COUNT(DISTINCT first.mjd) AS nightsObserved, \r\n";
	cmd += "<dd>  otherPlate.programname, count(DISTINCT other.bestObjID) AS objects</td></tr>\r\n";
	cmd += "<br> <tr><td> FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a> first\r\n";
	cmd += "<dd>  JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a> other ON first.bestObjID = other.bestObjID\r\n";
	cmd += "<dd>  JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PlateX+U\">PlateX</a> AS firstPlate ON firstPlate.plate = first.plate\r\n";
	cmd += "<dd>  JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PlateX+U\">PlateX</a> AS otherPlate ON otherPlate.plate = other.plate</td></tr>\r\n";
	cmd += "<br> <tr><td> WHERE first.scienceprimary = 1 AND other.scienceprimary = 0 \r\n";
	cmd += "<dd>  AND other.bestObjID &gt; 0</td></tr>\r\n";
	cmd += "<br> <tr><td> GROUP BY first.plate, other.plate, otherPlate.programname</td></tr>\r\n";
	cmd += "<br> <tr><td> ORDER BY nightsObserved DESC, otherPlate.programname, first.plate, other.plate<br></td></tr>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "timeseries";
	qry = "Multiple Detections and Time Series: CROSS APPLY";
	cmd = tableDef;
	cmd += "-- The <a href=\""+url+"/help/browser/browser.aspx?cmd=description+detectionIndex+U\">detectionIndex table</a> contains all detections of a given physical object,<br>\r\n";
	cmd += "-- which is uniquely identified by the \"thingid\". In order to extract photometry, <br>\r\n";
	cmd += "-- you need a join with the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll table</a>, using the objid.<br>\r\n";
	cmd += "-- There is also a flag field called <i>isPrimary</i>, which is 1 for the object that<br>\r\n";
	cmd += "-- is found on a primary polygon/field, all the other detections have 0 in this field.<br>\r\n";
	cmd += "-- Here is a compound query to find all time series around a certain object with a thingid= 97423000<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    LTRIM(STR(mjd_r,20,2)) AS MJD,<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    dbo.fSDSS(p.objId) AS ID,<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    modelMag_g, modelMagErr_g,<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    modelMag_r, modelMagErr_r,<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    modelMag_i, modelMagErr_i, p.ra, p.dec, o.* <br>\r\n";
	cmd += "FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+detectionIndex+U\">detectionindex</a> d <br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll</a> p ON d.objid=p.objid<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Field+U\">Field</a> f ON p.fieldid=f.fieldid<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    CROSS APPLY <a href=\""+url+"/help/browser/browser.aspx?cmd=description+fGetNearbyObjEq+F\">dbo.fGetNearbyObjEq</a>(p.ra, p.dec, 0.1) o<br>\r\n";
	cmd += "WHERE d.thingid=97423000<br>\r\n";
	cmd += "ORDER BY 1<br>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "footprint";
	qry = "Checking SDSS footprint: OUTER APPLY";
	cmd = tableDef;
	cmd += "-- This query uses the OUTER APPLY construct to apply a <br>\r\n";
	cmd += "-- table-valued function to the results of a query. <br>\r\n";
	cmd += "-- ( See also example below of checking whether a single point is in the SDSS footprint.)  <br>\r\n";
	cmd += "-- In this example, we use the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+fInFootprintEq+F\">fFootPrintEq</a> function which returns a <br>\r\n";
	cmd += "-- a non-NULL value (\"POLYGON\") if the area specified by the RA, dec and  <br>\r\n";
	cmd += "-- radius is inside the SDSS footprint.             <br>\r\n";
	cmd += "-- For each point in the input list, in this case the result of a query   <br>\r\n";
	cmd += "-- on PhotoObj, return \"yes\" or \"no\" depending on whether the point is in <br>\r\n";
	cmd += "-- the SDSS footprint or not, along with any other needed columns.        <br>\r\n";
	cmd += "-- Note that this is really a trivial example since every point in PhotoObj <br>\r\n";
	cmd += "-- is already in the SDSS footprint.  To be really meaningful, a query like  <br>\r\n";
	cmd += "-- this needs to be run on a list of RA, decs that may or may not be in the  <br>\r\n";
	cmd += "-- in the SDSS footprint.  This can be done using a MyDB table in CasJobs <br>\r\n";
	cmd += "-- containing the list of points, for example, or by uploading a list in <br>\r\n";
	cmd += "-- the Object Crossid tool. <br>\r\n";
	cmd += "<br><tr><td>SELECT top 100 objID, ra, dec,\r\n";
	cmd += "<dd> (CASE WHEN q.type IS NULL THEN 'NO' ELSE 'YES' END) AS found</td></tr>\r\n";
	cmd += "<br><tr><td>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObj+V\">PhotoObj</a> AS p\r\n";
	cmd += "<dd>OUTER APPLY dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fFootprintEq+F\">fFootprintEq</a>(ra,dec,0.1) AS q</td></tr>\r\n";
	cmd += "<br><tr><td>WHERE (ra BETWEEN 179.5 AND 182.3) AND (dec BETWEEN -1.0 AND 1.8)\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "<tr><td colspan=2><br>\r\n";
	cmd2 = "-- Checking the footprint for a single point with the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+fInFootprintEq+F\">fInFootprintEq</a> scalar function. \r\n";
	cmd2 += "<br>SELECT dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fInFootprintEq+F\">fInFootprintEq</a>(180, -0.5, 0.2)\r\n";
	cmd2 += "<br><br>\r\n";
	cmd2 += "-- Or if you have a table containing ra,dec values (for example a MyDB table <br>\r\n";
	cmd2 += "-- in CasJobs), you can do something lile:\r\n";
	cmd2 += "<br>SELECT dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fInFootprintEq+F\">fInFootprintEq</a>(t.ra, t.dec, 0.1)\r\n";
	cmd2 += "<br>FROM MyTable_10 AS t\r\n";
	cmd2 += "<br></td></tr>\r\n";
	cmd2 += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd+cmd2 );	
		
%>


</div>
</asp:Content>
