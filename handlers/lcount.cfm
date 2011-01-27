<cfsetting enablecfoutputonly="true">
<cfdirectory directory="/Library/Webserver/Documents/vmiwareapp" action="list" name="theProject"
filter="*" sort="directory" recurse="yes">
<cfset totalLines = 0>
<!---loop over all the files and filter on list of extensions--->
<cfloop query="theProject">
 <cfif type eq "file" AND NOT REFindNoCase("mxunit", "#directory#")>
  <cfif left(name, 1) NEQ '.' AND listLen(name, '.') GT 1 AND "cfc,cfm" CONTAINS listGetAt(name, 2, '.')>
   <!---create an array of line items (parse by ascii carriage return and output the name of the file--->
      <cffile action="read" file="#directory#/#name#" variable="curFile" >
   <cfset myArray = listToArray(curFile, "#Chr(10)#")>  <!--- Chr(10) is linefeed and Chr(13) is CR --->
   <cfoutput>#directory#/#trim(name)# - file lines =s #arrayLen(myArray)#<br /></cfoutput>
   <!---add current files line count to total--->
   <cfset totalLines = totalLines + arrayLen(myArray)>
  </cfif>
 </cfif>
</cfloop>
<!---output line count total--->
<cfoutput><br />Total all lines - #totalLines#</cfoutput>


<cffunction name="getLineSeparator" access="public" output="false" returntype="string" hint="Returns the system line separator">
	<cfscript>
		return createObject("java", "java.lang.System").getProperty("line.separator");
	</cfscript>
</cffunction>