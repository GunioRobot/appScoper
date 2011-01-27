<cfscript>
theXML = xmlParse ( form.ideEventInfo );
if ( ! len( cgi.HTTPS ) ) {
	ideUrl = "http://" & cgi.HTTP_HOST & ":" & cgi.SERVER_PORT;
} else {
	ideUrl = "https://" & cgi.HTTP_HOST & ":" & cgi.SERVER_PORT_SECURE;
}
ideUrl &= getDirectoryFromPath( cgi.script_name );
ideUrl &= "appscoper.cfm?path=#urlEncodedFormat( theXML.event.ide.projectview.resource.XmlAttributes['path'] )#";
</cfscript>	

<cfcontent reset="true">
<cfheader name="Content-Type" value="text/xml">
<cfoutput> 
<response showresponse="true"> 
	<ide url="#ideUrl#" > 
		<dialog title="appScoper" width="625" height="500" /> 
	</ide> 
</response> 
</cfoutput>