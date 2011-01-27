<cfinclude template="utils.cfm">
<cfif directoryExists ( url.path )>
  <cfset fileList = directoryList ( url.path, true, "path", "*.*" )>
  <!--- if project local config exists load it --->
  <cfset relPath = #getRelative(url.path)#>
  <cfif fileExists(url.path & "/appscoper_config.cfm")>
    <cfset localConfig = relPath & "/appscoper_config.cfm">
    <cfinclude template="#localConfig#">
  </cfif>
  <cfelse>
  <cfset fileList = [ url.path ]>
</cfif>
<cfset grandTotalLines = 0>
<cfset grandTotalFiles = 0>
<!--- set up results array by extension --->
<cfset extCount = ArrayLen(request.includedExtensions)>
<cfset resultsArray = arrayNew(2)>
<cfset temp = ArrayResize(resultsArray, extCount)>
<cfloop index="i" from="1" to="#extCount#">
<cfset resultsArray[i][1] = request.includedExtensions[i]>
<cfset resultsArray[i][2] = 0>
<!--- line count --->
<cfset resultsArray[i][3] = 0>
<!--- file count --->
</cfloop>
<cfloop array="#fileList#" index="filePath">
<!--- check for excluded paths and skip --->
<cfset mustSkip = false>
<cfloop array="#request.excludePaths#" index="exPath">
<cfif REFindNoCase("#exPath#", "#filePath#")>
  <cfset mustSkip = true>
  <cfbreak>
</cfif>
</cfloop>
<cfif mustSkip>
  <cfcontinue>
</cfif>
<cfif listFindNoCase (#arrayToList(request.includedExtensions)#, listLast (filePath, ".") )>
  <cfset curExt = listLast (filePath, ".")>
  <cfset curExtIndex = ArrayFind(request.includedExtensions, #curExt#)>
  <cfset lineCount = 0>
  <cfloop file="#filePath#" index="line">
  <!--- get line count for this file --->
  <cfset lineCount++>
  </cfloop>
  <!--- increment grand total and extension total in array --->
  <cfset grandTotalLines = grandTotalLines + lineCount>
  <cfset grandTotalFiles = grandTotalFiles + 1>
  <!--- increment line count for current extension --->
  <cfset resultsArray[#curExtIndex#][2] = resultsArray[#curExtIndex#][2] + lineCount>
  <!--- increment file count for current extension --->
  <cfset resultsArray[#curExtIndex#][3] = resultsArray[#curExtIndex#][3] + 1>
</cfif>
</cfloop>
<cfoutput>
<style type="text/css">
body {
	font-family: Helvetica, sans-serif;
	font-size: 12px;
	margin: 10px;
}
table {
	border:none
	width: 605px;
	min-width: 95%;
	/* margin: 10px;*/
	background-color: darkgrey;
	font-size: 12px;
}
th {
	color: white;
	background-color: grey;
	padding: 4px;
}
td {
	border: solid 1px;
	background-color: white;
	padding: 4px;
}
td.count {
	text-align: right;
}
tr.totals {
	font-weight: 700;
}
</style>
<body>
</cfoutput>
<cfoutput>
<cfsavecontent variable="report">
<table>
  <tr>
    <th colspan="4">Results: #url.path#</th>
  </tr>
  <tr>
    <th>Extension</th>
    <th>Lines</th>
    <th>Files</th>
    <th>Avg Lines/File</th>
  </tr>
  <cfloop index="i" from="1" to="#extCount#">
  <tr>
    <td>Lines in extension #resultsArray[i][1]#</td>
    <td class="count">#resultsArray[i][2]#</td>
    <td class="count">#resultsArray[i][3]#</td>
    <td class="count">#round(resultsArray[i][2]/max(resultsArray[i][3],1))#</td>
  </tr>
  </cfloop>
  <tr class="totals">
    <td class="count">Totals</td>
    <td class="count">#grandTotalLines#</td>
    <td class="count">#grandTotalFiles#</td>
    <td class="count">#round(grandTotalLines/grandTotalFiles)#</td>
  </tr>
</table>
</cfsavecontent>
<!--- output results to page --->
#report#
<cfif request.makeXls>
  <cfset xlsFile = "#url.path#/appscoper_#DateFormat(Now(),'ddmmyyyy')#_#LSTimeFormat(Now(),'HHMMSS')#.xls">
  <cffile action="write" file="#xlsFile#" output="#report#">
  <br />
  XLS output saved to:<br />
  #xlsFile#<br />
<cfelse>
  <br />
  XLS output disabled
</cfif>
<br />
<cfif isDefined("variables.localConfig")>
  Using project local config
  <cfelse>
  Using global config
</cfif>
</body>
</cfoutput>
