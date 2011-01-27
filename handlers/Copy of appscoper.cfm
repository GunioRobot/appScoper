<cfif directoryExists ( url.path )>
	<cfset files = directoryList ( url.path, true, "path", "*.*" )>
<cfelse>
	<cfset files = [ url.path ]>
</cfif>

<cfset message = "">
<cfloop array="#files#" index="filePath">
	<cfif listFindNoCase ("cfc,cfm,js", listLast (filePath, ".") )>
		<cfset lineNumber = 0>
		<cfset fileIssues = "">
		<cfloop file="#filePath#" index="line">
			<cfset lineNumber++>
			<cfloop array="#request.lookFor#" index="stringToFind">
				<cfif refindNoCase (stringToFind, line )>
					<cfset fileIssues &= "<li>Line #lineNumber#: #stringToFind#</li>">
				</cfif>
			</cfloop>
		</cfloop>
		<cfif len( fileIssues )>
			<cfset message &= "<h4>#ReReplaceNoCase( filePath, ".*trunk/", "")#</h4><ul>#fileIssues#</ul>">
		</cfif>
	</cfif>
</cfloop>

<cfoutput>
<style type="text/css">
body {
	font-family: Helvetica, sans-serif;
}
h4 {
	margin-bottom: 0;
}
ul {
	margin: 0;
}
</style>
<body>
</cfoutput>

<cfif len( message )>
	<cfoutput>Some problems:#message#</cfoutput>
<cfelse>
	<cfoutput><h2>All Good! :)</h2></cfoutput>
</cfif>

<cfoutput>
</body>
</cfoutput>