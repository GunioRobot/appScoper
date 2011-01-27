<cfscript>
//request.includeExts is an array of file extensions to include when counting lines
request.includedExtensions = ["cfc"];
// request.exclude is an array of partial paths or subdirecctories to exclude when counting lines
request.excludePaths = ["assets","deploy","design","extDirectApi","mxunit","org","schema","selenium","tests"];
// enable to create XLS file when run
request.makeXls = true;
</cfscript>
