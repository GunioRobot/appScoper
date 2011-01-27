<cfscript>
/**
* Returns a relative path from the current template to an absolute file path.
* 
* @param abspath      Absolute path. (Required)
* @return Returns a string. 
* @author Isaac Dealey (info@turnkey.to) 
* @version 1, May 2, 2003 
*/
function getRelative(abspath) { 
    var aHere = listtoarray(getdirectoryfrompath(getcurrenttemplatepath()),"\/"); 
    var aThere = ""; var lenThere = 0; 
    var aRel = ArrayNew(1); var x = 0; 
    var newpath = ""; 
    
    aThere = ListToArray(abspath,"\/"); lenThere = arraylen(aThere); 
    
    for (x = 1; x lte arraylen(aHere); x = x + 1) { 
        if (x GT lenThere OR comparenocase(aHere[x],aThere[x])) { 
            ArrayPrepend(aRel,".."); if (x lte lenThere) { ArrayAppend(aRel,aThere[x]); } 
        } 
    }
    
    for (; x lte arraylen(aThere); x = x + 1) { ArrayAppend(aRel,aThere[x]); }
    
    newpath = ArrayToList(aRel,"/"); 

    return newpath; 
}
</cfscript>