<cfscript>
//request.includeExts is an array of file extensions to include when counting lines
request.includedExtensions = ["cfc","cfm","css","js","html"];
// request.exclude is an array of partial paths or subdirecctories to exclude when counting lines
request.excludePaths = ["assets","deploy","design","extDirectApi","mxunit","org","schema","selenium","tests","install"];
</cfscript>
