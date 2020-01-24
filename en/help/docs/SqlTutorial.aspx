<%@ Page Title="" Language="C#" MasterPageFile="../HelpMaster.master" AutoEventWireup="true" CodeBehind="RealQuery.aspx.cs" Inherits="SkyServer.Help.Docs.RealQuery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HelpContent" runat="server">
<div id="title">Getting Started with SQL</div>

<div id="transp">

<table WIDTH=640 border=0 cellspacing="3" cellpadding="3">
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

<table align=center>
<tr>
<td class='tsml'>
<b><i>Basic SQL:</i></b>
<br><a href="#basic">Basic SELECT-FROM-WHERE</a>
<br><a href="#spatial">Basic position search</a>
<br><a href="#phototag">Using PhotoTag</a>
<br><a href="#between">Search for a Range of Values</a>
<br><a href="#rect">Rectangular position search</a>
<br><a href="#join">More than one table: JOIN...ON</a>
<br><a href="#specphoto">Photometry & spectroscopy</a>
<br><a href="#countgroup">Counting by type or category</a>
<br><a href="#starflag">Using flags</a>

<br><hr>

<b><i>SQL Jujitsu:</i></b>
<br><a href="#subsamp">Data subsample</a>
<br><a href="#closepairs">Objects in close pairs</a>
<br><a href="#nbrrun">Selected neighbors in run</a>
<br><a href="#objcount">Object counts and logic</a>
<br><a href="#repeatz">Repeated high-<i>z</i> objects</a>
<br><a href="#split64">Splitting 64-bit values</a>
<br><a href="#outer">Using LEFT OUTER JOIN</a>
<br><a href="#nested">Using Nested Queries</a>

<br><hr>

<b><i>Quasars:</i></b>
<br><a href="#qsospec">QSOs by spectroscopy</a>
<br><a href="#qsocol">QSOs by colors</a>
<br><a href="#quasar3">FIRST matches for quasars</a>

</td>

<td width="5">&nbsp;</td>

<td class='tsml'>
<b><i>General Astronomy:</i></b>
<br><a href="#galview">Only stars or galaxies</a>
<br><a href="#clean">Clean photometry</a>
<br><a href="#mjd">Using Field MJD</a>
<br><a href="#lines">Objects by spectral lines</a>
<br><a href="#unspec">Spectra by classification</a>
<br><a href="#movast">Moving asteroids</a>
<br><a href="#repeat">Plates with repeat spectra</a>
<br><a href="#galstar">Galaxies blended with stars</a>
<br><a href="#countsbytype">Counts by type and program</a>
<br><a href="#footprint">Checking SDSS footprint</a>

<br><hr>

<b><i>Stars:</i></b>
<br><a href="#cleanStars">Clean photometry - Stars</a>
<br><a href="#cv">CVs using colors</a>
<br><a href="#bincol">Binary stars colors</a>
<br><a href="#spplines">Using sppLines table</a>
<br><a href="#sppparams">Using sppParams table</a>
<br /><a href="#pm">Proper motions</a>
<!-- <br><font color="red"><b>Stars by spectral class (KS)</b></font> -->

<br><hr>

<b><i>Miscellaneous:</i></b>
<br><a href="#photoz">Photometric Redshifts</a>
<br><a href="#specOther1">Spectra in Other Programs - I</a>
<br><a href="#specOther2">Spectra in Other Programs - II</a>
<br><a href="#wisexmatch">Using WISE Cross-Match</a>

</td>

<td width="5">&nbsp;</td>

<td class='tsml'>
<b><i>Galaxies:</i></b>
<br><a href="#cleanGals">Clean photometry - Galaxies</a>
<br><a href="#galblue">Galaxies with blue centers</a>
<br><a href="#diamlim">Diameter limited sample</a>
<br><a href="#lrg">LRG sample selection</a>
<br><a href="#htm">Galaxy counts on HTM grid</a>
<br><a href="#zoo">Classifications from Galaxy Zoo</a>
<br><a href="#bosstarg">BOSS target selection</a>
<br><a href="#bossgal1">BOSS Stellar Masses</a>
<br><a href="#bossgal2">BOSS Stellar Vel. Disps.</a>

<br><hr>

<b><i>Varaibility Queries:</i></b>
<br><a href="#multiple">Stars multiply measured</a>
<br><a href="#timeseries">Multiple Detections and Time Series</a>

<br><hr>

<b><i>APOGEE:</i></b>
<br><a href="#apogeePlate">All APOGEE Plate Visits</a>
<br><a href="#aspcapParams">ASPCAP Parameters and Errors</a>
<br><a href="#apogeeStars">APOGEE Stars No BAD Flags</a>
<br><a href="#aspcapCluster">ASPCAP Params for Cluster Mbrs</a>
<br><a href="#apogeePMs">APOGEE Proper Motions</a>
<br><a href="#apogeeClusterCenters">APOGEE Stars Near Cluster Ctr</a>
<br><a href="#apogeeRVs">RVs for Individual APOGEE Visits</a>
<br><a href="#apogeeSegue">APOGEE and SEGUE Spectra</a>
<br><a href="#apogeeStarPhoto">SDSS photometry for APOGEE Stars</a>

<br>
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
	string tableDef = "<table width=720 border=0 cellspacing=0 cellpadding=0 bgcolor=#222266>\r\n<tr><td colspan=2>\r\n";
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
	qry = "Object counts by type & program: GROUP BY and ORDER BY";
	cmd = tableDef;
	cmd += "-- List the number of each type of object observed by each special spectroscopic observation <br>\r\n";
	cmd += "-- program. This query provides an example of GROUP BY and ORDER BY on more than one column. <br>\r\n";
	cmd += "-- . <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT plate.programname, class, \r\n";
	cmd += "<dd>COUNT(specObjId) AS numObjs \r\n";
	cmd += "<br>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a>\r\n";
	cmd += "<dd>JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PlateX+U\">PlateX</a> AS plate ON plate.plate = specObjAll.plate\r\n";
	cmd += "<br>GROUP BY plate.programname, class\r\n";
	cmd += "<br>ORDER BY plate.programname, class\r\n";
	cmd += "<br><br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "phototag";
	qry = "Using the PhotoTag view";
	cmd = tableDef;
	cmd += "-- This query introduces the <a href=\""+url+"/help/browser/browser.aspx?description+PhotoTag+V\">PhotoTag</a> view, which contains the most frequently used columns<br>\r\n";
	cmd += "-- of <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll</a> table. Queries to PhotoTag will run more quickly than those to PhotoObjAll.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- This sample query finds data for all objects in fields with desired PSF width. <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 100</td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    r.run,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    r.rerun,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    f.camCol,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    f.field,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    p.objID,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    p.ra,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    p.dec,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    p.modelMag_r,  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>    f.psfWidth_r  </td> </tr>\r\n";
	cmd += "<tr> <td> FROM  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd> <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoTag+U\">PhotoTag</a> AS p </td> </tr>\r\n";
	cmd += "<tr> <td> <dd> JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Field+U\">Field</a> AS f ON f.fieldid = p.fieldid </td> </tr>\r\n";
	cmd += "<tr> <td> <dd> JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Run+U\">Run</a> AS r ON f.run = r.run </td> </tr>\r\n";
	cmd += "<tr> <td> WHERE mode=1 &nbsp;&nbsp;&nbsp;&nbsp;-- select primary objects only</td> </tr>\r\n";
	cmd += "<tr> <td> <dd>   and f.psfWidth_r &gt; 1.2  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>   and  p.modelMag_r &lt; 21.  </td> </tr>\r\n";
	cmd += "<tr> <td> <dd>   and  r.stripe = 21  </td> </tr>\r\n";
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
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
	

	qName = "specphoto";
	qry = "Photometry and Spectroscopy: SpecPhoto";
	cmd = tableDef;
	cmd += "-- This query introduces the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecPhoto+V\">SpecPhoto</a> view of the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecPhotoAll+U\">SpecPhotoAll</a> table, which is a <i>pre-computed</i><br>\r\n";
	cmd += "-- join of the most commonly-searched fields in <i>both</i> the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecobjAll+U\">SpecObjAll</a> table (which contains<br>\r\n";
	cmd += "-- spectroscopy data) and the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll</a> table that contains photometry data.<br>\r\n";
	cmd += "-- This means that if you want to combine photometry and spectroscopy tables yourself using <br>\r\n";
	cmd += "-- JOIN...ON, you can save yourself the trouble of doing that since the join already has been <br>\r\n";
	cmd += "-- \"precomputed\" and done for you.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- You should use <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecPhoto+V\">specPhoto</a> whenever your columns of interest<br>\r\n";
	cmd += "-- can be found there; using specPhoto means that your queries will<br>\r\n";
	cmd += "-- return results <i>much faster</i> than manually using JOIN...ON.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- This sample query retrieves both magnitudes (from photometry) and<br>\r\n";
	cmd += "-- redshifts (from spectroscopy) of 100 quasars. Note that this query<br>\r\n"; 
	cmd += "-- also introduces the use of mathematical operators (in this case subtraction)<br>\r\n";
	cmd += "-- in queries.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT top 100<br>\r\n";
	cmd += "<dd>objid, ra, dec, psfmag_i-extinction_i AS mag_i,<br>\r\n";
	cmd += "<dd>psfmag_r-extinction_r AS mag_r, z&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -- In SpecPhoto, \"z\" is the redshift  </td> </tr>\r\n";
	cmd += "<tr><td> FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecPhoto+V\">SpecPhoto</a>  </td> </tr>\r\n";
	cmd += "<tr><td> WHERE <br>\r\n";
	cmd += "<dd> (class = 'QSO') \r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );	
	

	qName = "subsamp";
	qry = "Data subsample";
	cmd = tableDef;
	cmd += "-- Give me the colors of a random 1% sample of objects from all fields that     <br>\r\n";
	cmd += "-- are \"survey quality\" so that I could plot up color-color diagrams and play  <br>\r\n";
	cmd += "-- around with more sophisticated cuts.  Query requested by <a href=\"mailto:kgb@pha.jhu.edu\">Karl Glazebrook</a>. <br>\r\n";
	cmd += "-- Uses the HTM spatial index ID as a random number generator.  The htmID is      <br>\r\n";
	cmd += "-- multiplied by a prime number (37) to remove bias and generate a random number <br>\r\n";
	cmd += "-- from the lowermost 16 bits.  This number is then constrained to be between 650<br>\r\n";
	cmd += "-- and 65000 to generate a random sample between 1 and 100% of the data            <br>\r\n";
	cmd += "-- respectively.  So replacing the \"1\" by a different number between 1 and 99    <br>\r\n";
	cmd += "-- will generate a sample of the required percentage of objects. <br>\r\n";
	cmd += "-- Note that this is much faster than the standard \"ORDER BY RANDOM()\" SQL method. <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td colspan=\"2\"> SELECT TOP 100 u, g, r, i, z FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Galaxy+V\">Galaxy</a> </td> </tr>\r\n";
	cmd += "<tr> <td colspan=\"2\"> WHERE </td> </tr>\r\n";
	cmd += "<tr> <td colspan=\"2\"> <dd> (htmid*37 & 0x000000000000FFFF) </td> </tr> \r\n";
	cmd += "<tr> <td> <dd>&nbsp;&nbsp;&nbsp; &lt; (650 * 1) </td> <td> -- Replace the \"1\" with a number &lt; 99 to get a higher percentage data subsample  </td> </tr>\r\n";
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );


	qName = "closepairs";
	qry = "Objects in close pairs using Neighbors";
	cmd = tableDef;
	cmd += "-- This query introduces the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Neighbors+U\">Neighbors</a> table, which contains each    <br>\r\n";
	cmd += "-- object's neighbors within 30 arcseconds.                       <br>\r\n";
	cmd += "-- Find all objects within 30 arcseconds of one another           <br>\r\n";
	cmd += "-- that have very similar colors: that is where the color ratios  <br>\r\n";
	cmd += "-- u-g, g-r, r-I are less than 0.05m.                             <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "</td></tr>\r\n";
	cmd += "<tr> <td> SELECT TOP 10 P.ObjID 			</td><td>-- distinct cases  </td></tr>\r\n";
	cmd += "<tr> <td>   FROM	<a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoPrimary+V\">PhotoPrimary</a> AS P	</td><td>-- P is the primary object</td></tr>\r\n";
	cmd += "<tr> <td> <dd> JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Neighbors+U\">Neighbors</a> AS N ON P.ObjID = N.ObjID	</td><td>-- N is the neighbor link</td></tr>\r\n";
	cmd += "<tr> <td colspan=2> <dd> JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoPrimary+V\">PhotoPrimary</a> AS L ON L.ObjID = N.NeighborObjID	</td></tr>\r\n";
	cmd += "<tr> <td> </td><td>-- L is the lens candidate of P</td></tr>\r\n";
	cmd += "<tr> <td>  WHERE </td><td> </td></tr>\r\n";
	cmd += "<tr> <td> <dd>   P.ObjID &lt; L. ObjID 			</td><td>-- avoid duplicates</td></tr>\r\n";
	cmd += "<tr> <td> <dd>   and abs((P.u-P.g)-(L.u-L.g))<0.05 	</td><td>-- L and P have similar spectra.</td></tr>\r\n";
	cmd += "<tr> <td> <dd>   and abs((P.g-P.r)-(L.g-L.r))<0.05	</td><td> </td></tr>\r\n";
	cmd += "<tr> <td> <dd>   and abs((P.r-P.i)-(L.r-L.i))<0.05	</td><td> </td></tr>\r\n";
	cmd += "<tr> <td> <dd>   and abs((P.i-P.z)-(L.i-L.z))<0.05	</td><td> </td></tr>\r\n";
	cmd += "<tr> <td colspan=2> <br> </td> </tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
	showQuery( qName, qry, cmd, cmd );


	qName = "nbrrun";
	qry = "Selected neighbors in run: Nested query and STR";
	cmd = tableDef;
	cmd += "-- A more complex query that also uses the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Neighbors+U\">Neighbors</a> table.     <br>\r\n";
	cmd += "-- This is a query from <a href=\"mailto:rhl@astro.princeton.edu\">Robert Lupton</a> that finds selected neighbors in a given run and <br>\r\n";
	cmd += "-- camera column.  It contains a nested query containing a join, <i>and</i> a join with the <br>\r\n";
	cmd += "-- results of the nested query to select only those neighbors from the list that meet       <br>\r\n";
	cmd += "-- certain criteria.  The nested queries are required because the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Neighbors+U\">Neighbors</a> table does      <br>\r\n";
	cmd += "-- not contain all the parameters for the neighbor objects. This query also contains   <br>\r\n";
	cmd += "-- examples of setting the output precision of columns with STR.     <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT TOP 10 \r\n";
	cmd += "<dd>        obj.run, obj.camCol, str(obj.field, 3) as field,\r\n";
	cmd += "<dd>        str(obj.rowc, 6, 1) as rowc, str(obj.colc, 6, 1) as colc,\r\n";
	cmd += "<dd>        str(dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fObj+F\">fObj</a>(obj.objId), 4) as id,  \r\n";
	cmd += "<dd>        str(obj.psfMag_g - 0*obj.extinction_g, 6, 3) as g,\r\n";
	cmd += "<dd>        str(obj.psfMag_r - 0*obj.extinction_r, 6, 3) as r,\r\n";
	cmd += "<dd>        str(obj.psfMag_i - 0*obj.extinction_i, 6, 3) as i,\r\n";
	cmd += "<dd>        str(obj.psfMag_z - 0*obj.extinction_z, 6, 3) as z,\r\n";
	cmd += "<dd>        str(60*distance, 3, 1) as D,\r\n";
	cmd += "<dd>        dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fField+F\">fField</a>(neighborObjId) as nfield,\r\n";
	cmd += "<dd>        str(dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fObj+F\">fObj</a>(neighborObjId), 4) as nid<br>\r\n";
	cmd += "FROM\r\n";
	cmd += "<dd>        (SELECT obj.objId,\r\n";
	cmd += "<dd> &nbsp;&nbsp;                run, camCol, field, rowc, colc,\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 psfMag_u, extinction_u,\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 psfMag_g, extinction_g,\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 psfMag_r, extinction_r,\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 psfMag_i, extinction_i,\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 psfMag_z, extinction_z,\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 NN.neighborObjId, NN.distance\r\n";
	cmd += "<dd>         FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObj+V\">PhotoObj</a> as obj\r\n";
	cmd += "<dd>         &nbsp;&nbsp;JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Neighbors+U\">neighbors</a> as NN on obj.objId = NN.objId\r\n";
	cmd += "<dd>         WHERE\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 60*NN.distance between 0 and 15 and\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 NN.mode = 1 and NN.neighborMode = 1 and\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 run = 756 and camCol = 5 and\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 obj.type = 6 and (obj.flags & 0x40006) = 0 and\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 nchild = 0 and obj.psfMag_i &lt; 20 and\r\n";
	cmd += "<dd> &nbsp;&nbsp;                 (g - r between 0.3 and 1.1 and r - i between -0.1 and 0.6)\r\n";
	cmd += "<dd>         ) as obj <br>\r\n";
	cmd += "<dd>JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObj+V\">PhotoObj</a> as nobj on nobj.objId = obj.neighborObjId <br>\r\n";
	cmd += "WHERE \r\n";
	cmd += "<dd>        nobj.run = obj.run and\r\n";
	cmd += "<dd>        (abs(obj.psfMag_g - nobj.psfMag_g) &lt; 0.5 or\r\n";
	cmd += "<dd>         abs(obj.psfMag_r - nobj.psfMag_r) &lt; 0.5 or\r\n";
	cmd += "<dd>         abs(obj.psfMag_i - nobj.psfMag_i) &lt; 0.5)  <br>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";
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


	qName = "quasar3";
	qry = "FIRST matches for quasars";
	cmd = tableDef;
	cmd += "-- This sample query is a useful quasar query (from <a href=\"mailto:jester@fnal.goV\">Sebastian Jester</a>). <br>\r\n";
	cmd += "-- Getting magnitudes for spectroscopic quasars - retrieves photometry. <br>\r\n";
	cmd += "-- This query uses the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecPhoto+V\">SpecPhoto view</a> of the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecPhotoAll+U\">SpecPhotoAll table</a>, which is a <i>pre-computed join</i> <br>\r\n";
	cmd += "-- of the important fields in the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecobjAll+U\">SpecObjAll</a> and <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll</a> tables.  It is very convenient and much <br>\r\n";
	cmd += "-- <i>faster</i> to use this when you can instead of doing the join yourself. <br>\r\n";
	cmd += "-- Getting FIRST data for spectroscopic quasars - returns only those quasars that have <br>\r\n";
	cmd += "-- matches in the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+First+U\">FIRST</a> (Far-InfraRed Survey Telescope) table. <br>\r\n";
	cmd += "<br>\r\n";
	cmd += "SELECT sp.ra,sp.dec,sp.z, \r\n";
	cmd += "<dd>  sp.psfmag_i-sp.extinction_i AS mag_i,\r\n";
	cmd += "<dd>  peak,integr <br>\r\n";
	cmd += "FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecPhoto+V\">SpecPhoto</a> AS sp <br>\r\n";
	cmd += "<dd> INNER JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+First+U\">FIRST</a> AS f ON sp.objid = f.objid <br>\r\n";
	cmd += "WHERE <br>\r\n";
	cmd += "<dd>  class = 'QSO'<br> \r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "clean";
	qry = "Clean photometry: the CLEAN flag";
	cmd = tableDef;
	cmd += "-- One of the most important requirements for selecting data<br>\r\n";
	cmd += "-- useful for research is to select only data that has passed<br>\r\n";
	cmd += "-- a certain standard of clean photometry. Starting with DR8,<br>\r\n";
	cmd += "-- the SDSS has made this easier by providing a flag called CLEAN<br>\r\n";
	cmd += "-- that indicates that an object's photometry has passed all tests<br>\r\n";
	cmd += "-- to bedeclared useful for science. A value of CLEAN=1 (true)<br>\r\n";
	cmd += "-- indicates that that object's photometry has been vetted as clean.<br>\r\n";
	cmd += "-- For more on using flags, see the <a href=\"#starflag\">Using Flags</a> Sample Query.<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "-- In some contexts, it is important to know what conditions<br>\r\n";
	cmd += "-- are required for theimaging pipeline to set the CLEAN flag,<br>\r\n";
	cmd += "-- so that you can adjust these requirements to suit your needs.<br>\r\n";
	cmd += "-- The CLEAN flag works differently for stars and galaxies. For stars,<br>\r\n";
	cmd += "-- see the <a href=\"#cleanStars\">Clean photometry - stars</a> sample query. For galaxies,<br>\r\n";
    cmd += "-- see the <a href=\"#cleanGals\">Clean photometry - galaxies</a> sample query.<br>\r\n";
	cmd += "<br>SELECT top 10 objID, ra, dec, g, clean\r\n";
	cmd += "<br>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObj+V\">PhotoObj</a>\r\n";
	cmd += "<br>WHERE CLEAN=1<br>\r\n";
	cmd += "<br>\r\n";
	cmd += "<tr><td colspan=2><br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>\r\n";	
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
	cmd += "SELECT first.plate, other.plate, \r\n";
	cmd += "<dd>  COUNT(DISTINCT other.mjd) + COUNT(DISTINCT first.mjd) AS nightsObserved, \r\n";
	cmd += "<dd>  otherPlate.programname, count(DISTINCT other.bestObjID) AS objects\r\n";
	cmd += "<br>  FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a> first\r\n";
	cmd += "<dd>  JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+SpecObjAll+U\">SpecObjAll</a> other ON first.bestObjID = other.bestObjID\r\n";
	cmd += "<dd>  JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PlateX+U\">PlateX</a> AS firstPlate ON firstPlate.plate = first.plate\r\n";
	cmd += "<dd>  JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PlateX+U\">PlateX</a> AS otherPlate ON otherPlate.plate = other.plate\r\n";
	cmd += "<br>  WHERE first.scienceprimary = 1 AND other.scienceprimary = 0 \r\n";
	cmd += "<dd>  AND other.bestObjID &gt; 0\r\n";
	cmd += "<br>  GROUP BY first.plate, other.plate, otherPlate.programname\r\n";
	cmd += "<br>  ORDER BY nightsObserved DESC, otherPlate.programname, \r\n";
	cmd += "<dd>  first.plate, other.plate<br>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "footprint";
	qry = "Checking if objects are in SDSS footprint: OUTER APPLY";
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
	cmd += "<br>SELECT top 100 objID, ra, dec,\r\n";
	cmd += "<dd> (CASE WHEN q.type IS NULL THEN 'NO' ELSE 'YES' END) AS found\r\n";
	cmd += "<br>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObj+V\">PhotoObj</a> AS p\r\n";
	cmd += "<dd>OUTER APPLY dbo.<a href=\""+url+"/help/browser/browser.aspx?cmd=description+fFootprintEq+F\">fFootprintEq</a>(ra,dec,0.1) AS q\r\n";
	cmd += "<br>WHERE (ra BETWEEN 179.5 AND 182.3) AND (dec BETWEEN -1.0 AND 1.8)\r\n";
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
	
	
	qName = "zoo";
	qry = "Classifications from Galaxy Zoo";
	cmd = tableDef;
	cmd += "-- SDSS includes data on visual galaxy morphologies from the <br>\r\n";
	cmd += "-- Galaxy Zoo project. <a href=\"http://www.galaxyzoo.org\">Galaxy Zoo</a> is a web-based project<br>\r\n";
	cmd += "-- that used the collective efforts of about 100,000 volunteer <br>\r\n";
	cmd += "-- citizen scientists to classify more than one million<br>\r\n";
	cmd += "-- SDSS DR7 Main Galaxy Sample (MGS) galaxies.<br>\r\n";
	cmd += "-- Full details on the classification process, including the operation<br>\r\n";
	cmd += "-- of the site and estimates of classification accurary, are given in<br>\r\n";
    	cmd += "-- <a href=\"http://adsabs.harvard.edu/abs/2008MNRAS.389.1179L\">Lintott et al. (2008)</a>.<br>\r\n";
	cmd += "<br>\r\n";
    	cmd += "-- Galaxy Zoo data are contained in tables that begin with <em>zoo</em><br>\r\n";
    	cmd += "-- in the DR8 schema. For each galaxy, available data includes its<br>\r\n";
    	cmd += "-- SDSS object ID and weighted probabilities for each of six different<br>\r\n";
    	cmd += "-- morphological classifications based on counts of volunteer \"votes\".<br>\r\n";
    	cmd += "-- Full details on what data the Galaxy Zoo catalog contains are given</a><br>\r\n";
    	cmd += "-- in <a href=\"http://adsabs.harvard.edu/abs/2011MNRAS.410..166L\">Lintott et al. (2010).</a><br>\r\n";
    	cmd += "<br>\r\n";
    	cmd += "-- The first query below finds the weighted probability that a given galaxy<br>\r\n";
    	cmd += "-- has each of the six morphological classifications.<br>\r\n";
    	cmd += "-- The second query finds 100 galaxies that have clean photometry,<br>\r\n";
    	cmd += "-- at least 10 Galaxy Zoo volunteer votes and at least an 80% probability<br>\r\n";
    	cmd += "-- of being clockwise spirals.<br>\r\n";
	cmd += "<br>\r\n";	      	
	cmd += "</td></tr>\r\n";
	cmd += "<tr><td>SELECT</td></tr>\r\n";
	cmd += "<tr><td><dd> objid, nvote,</td></tr>\r\n";
	cmd += "<tr><td><dd> p_el as elliptical,</td></tr>\r\n";
    cmd += "<tr><td><dd> p_cw as spiralclock, p_acw as spiralanticlock, p_edge as edgeon,</td></tr>\r\n";
    cmd += "<tr><td><dd> p_dk as dontknow, p_mg as merger</td></tr>\r\n";
	cmd += "<tr><td>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+ZooNoSpec+U\">ZooNoSpec</a> </td></tr>\r\n";
	cmd += "<tr><td>WHERE objid = 1237656495650570395</td></tr>\r\n";
	cmd += "<tr><td colspan=2><br></td></tr>\r\n";
	cmd += "<tr><td colspan=2>-- Second query: find likely clockwise spirals.<br>\r\n";
	cmd += "<br>\r\n";	
	cmd += "</td></tr>\r\n";
	cmd2 =  "<tr><td colspan=2>SELECT TOP 100</td></tr>\r\n";
	cmd2 += "<tr><td><dd> g.objid, zns.nvote,</td></tr>\r\n";
	cmd2 += "<tr><td><dd> zns.p_el as elliptical,</td></tr>\r\n";
    cmd2 += "<tr><td><dd> zns.p_cw as spiralclock, zns.p_acw as spiralanticlock, zns.p_edge as edgeon,</td></tr>\r\n";
    cmd2 += "<tr><td><dd> zns.p_dk as dontknow, zns.p_mg as merger</td></tr>\r\n";
    cmd2 += "<tr><td colspan=2>FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Galaxy+V\">Galaxy</a> as G<br></td></tr>\r\n";
   	cmd2 += "<tr> <td> JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+ZooNoSpec+U\">ZooNoSpec</a> AS zns";
	cmd2 += "<tr> <td> <dd> ON G.objid = zns.objid </td></tr>\r\n";
	cmd2 += "<tr><td>WHERE g.clean=1 and zns.nvote >= 10 and zns.p_cw > 0.8</td></tr>\r\n";
	cmd2 += "<tr><td colspan=2>	 <br></td></tr>\r\n";
	cmd2 += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd+cmd2 );



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
	cmd += "&nbsp;&nbsp;&nbsp;    modelMag_i, modelMagErr_i, p.ra, p.dec <br>\r\n";
	cmd += "INTO #list<br>\r\n";
	cmd += "FROM <a href=\""+url+"/help/browser/browser.aspx?cmd=description+detectionIndex+U\">detectionindex</a> d <br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll</a> p ON d.objid=p.objid<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp;    JOIN <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Field+U\">Field</a> f ON p.fieldid=f.fieldid<br>\r\n";
	cmd += "WHERE d.thingid=97423000<br>\r\n";
	cmd += "ORDER BY 1<br>\r\n";
	cmd += "--  <br>\r\n";
	cmd += "-- Now find objects near each of the detections <br>\r\n";
	cmd += "--  <br>\r\n";
	cmd += "SELECT a.*, b.* <br>\r\n";
	cmd += "FROM #list a<br>\r\n";
	cmd += " CROSS APPLY <a href=\""+url+"/help/browser/browser.aspx?cmd=description+fGetNearbyObjEq+F\">dbo.fGetNearbyObjEq</a>(a.ra, a.dec, 0.1) b<br>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


	qName = "wisexmatch";
	qry = "Using the WISE Cross-Match Table";
	cmd = tableDef;
	cmd += "-- The <a href=\""+url+"/help/browser/browser.aspx?cmd=description+WISE_allsky+U\">WISE_allsky</a> is a straightforward import of the WISE all-sky data release catalog.  <br>\r\n";
	cmd += "-- It has hundreds of columns containing all manner of<br>\r\n";
	cmd += "-- WISE measurements. It has 563,921,584 rows.  This catalog includes data<br>\r\n";
	cmd += "-- from the first part of the WISE mission, when all four of its mid-IR<br>\r\n";
	cmd += "-- channels (3.4, 4.6, 12, and 22 microns) were operational.  It is<br>\r\n";
	cmd += "-- all-sky.<br>\r\n";
	cmd += "-- <br>\r\n";
	cmd += "-- The <a href=\""+url+"/help/browser/browser.aspx?cmd=description+WISE_xmatch+U\">WISE_xmatch</a> is an astrometric cross-match between the WISE_allsky<br>\r\n";
	cmd += "-- and SDSS photoObj objects.  It contains 495,003,196 matches.  The<br>\r\n";
	cmd += "-- <a href=\""+url+"/help/browser/browser.aspx?cmd=description+WISE_xmatch+U\">WISE_xmatch</a> table itself just contains three columns: IDs of the WISE<br>\r\n";
	cmd += "-- and SDSS objects, and the distance between them.  I used a matching<br>\r\n";
	cmd += "-- radius of 4 arcsec, and duplicate matches are allowed.<br>\r\n";
	cmd += "-- <br>\r\n";
	cmd += "-- To use the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+WISE_xmatch+U\">WISE_xmatch</a> table, join on one of the SDSS Photo* tables<br>\r\n";
	cmd += "-- (<a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoObjAll+U\">PhotoObjAll</a>, <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoPrimary+V\">PhotoPrimary</a>, <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoTag+V\">PhotoTag</a>, <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Galaxy+V\">Galaxy</a>, <a href=\""+url+"/help/browser/browser.aspx?cmd=description+Star+V\">Star</a>) and the <a href=\""+url+"/help/browser/browser.aspx?cmd=description+WISE_allsky+U\">WISE_allsky</a><br>\r\n";
	cmd += "-- table, like so:<br>\r\n";
	cmd += " <br>\r\n";
	cmd += "select top 10<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp; S.ra as sdss_ra, S.dec as sdss_dec, W.ra as wise_ra, W.dec as wise_dec,<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp; S.psfmag_r as r, W.w1mpro as w1<br>\r\n";
	cmd += "from <a href=\""+url+"/help/browser/browser.aspx?cmd=description+WISE_xmatch+U\">wise_xmatch</a> as X<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp; join <a href=\""+url+"/help/browser/browser.aspx?cmd=description+WISE_allsky+U\">wise_allsky</a> as W on X.wise_cntr = W.cntr<br>\r\n";
	cmd += "&nbsp;&nbsp;&nbsp; join <a href=\""+url+"/help/browser/browser.aspx?cmd=description+PhotoTag+V\">photoTag</a> as S on X.sdss_objid = S.objid<br>\r\n";
	cmd += "where S.nchild = 0<br>\r\n";
	cmd += "<br></td></tr>\r\n";
	cmd += "</table>\r\n<br><br>";
	showQuery( qName, qry, cmd, cmd );


%>


</div>
</asp:Content>
