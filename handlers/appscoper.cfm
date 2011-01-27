<cfinclude template="utils.cfm">
<cfif directoryExists ( url.path )>
	<cfset fileList = directoryList ( url.path, true, "path", "*.*" )>
		<!--- if project local config exists load it TBD - not sure if ending backslash is already there or not --->
	<cfset relPath = #getRelative(url.path)#>
	<cfif fileExists(url.path & "/appscoper_config.cfm")>
		<cfset localConfig = relPath & "/appscoper_config.cfm">
		<cfinclude template="#localConfig#">
	</cfif>
<cfelse>
	<cfset fileList = [ url.path ]>
</cfif>
<cfset grandTotalLines = 0>

<!--- set up results array by extension --->
<cfset extCount = ArrayLen(request.includedExtensions)>
<cfset resultsArray = arrayNew(2)>
<cfset temp = ArrayResize(resultsArray, extCount)>
<cfloop index="i" from="1" to="#extCount#">
	<cfset resultsArray[i][1] = request.includedExtensions[i]>
	<cfset resultsArray[i][2] = 0>
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
		<cfset fileIssues = "">
		<cfloop file="#filePath#" index="line">
			<!--- get line count for this file --->
			<cfset lineCount++>
		</cfloop>
		<!--- increment grand total and extension total in array --->
		<cfset grandTotalLines = grandTotalLines + lineCount>
		<cfset resultsArray[#curExtIndex#][2] = resultsArray[#curExtIndex#][2] + lineCount>
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
</style>
<body>
</cfoutput>
<cfoutput>
<table>
	<tr><th colspan="2">Results: #url.path#</th></tr>
	<cfloop index="i" from="1" to="#extCount#">
		<tr><td>Lines in extension #resultsArray[i][1]#</td><td class="count">#resultsArray[i][2]#</td></tr>
	</cfloop>
	<tr><td>Total lines</td><td class="count">#grandTotalLines#</td></tr>
</table>
<cfsavecontent variable="report">
<table>
	<tr><th colspan="2">Results: #url.path#</th></tr>
	<cfloop index="i" from="1" to="#extCount#">
		<tr><td>Lines in extension #resultsArray[i][1]#</td><td class="count">#resultsArray[i][2]#</td></tr>
	</cfloop>
	<tr><td>Total lines</td><td class="count">#grandTotalLines#</td></tr>
</table>
</cfsavecontent>
<cfset xlsFile = "#url.path#/appscoper_#DateFormat(Now(),'ddmmyyyy')#_#LSTimeFormat(Now(),'HHMMSS')#.xls">
<cffile action="write" file="#xlsFile#" output="#report#">
<br />
XLS output saved to:<br />
#xlsFile#<br /><br />
<cfif isDefined("variables.localConfig")>
Using project local config.
<cfelse>
Using global config.
</cfif>
</body>
</cfoutput>