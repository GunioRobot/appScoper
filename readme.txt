appScoper is a CFB Extension that gives you a rough scope of the size of an entire project
or the source files in a subdirectory (recursively).  Not that it means all that much
but I like to have a sense of how big my project is growing from time to time.

Usage:
appScoper is installed to run from the context menu when you have selected a project
or project subdirectory in the CFB Navigator pane. Basic usage is that simple.

Configuration Options:
appScoper has a default set of configurations as follows:
1 - a list of file extensions to count lines and files for
2 - an option list of file path components to exclude which
are tested (contains) for each file being evaluated for processing
3 - an option to set to cause an XLS file of the displayed results
to be output to the selected project or subdirectory for later reference

There is a global config file named appscoper_config.cfm in the handlers
subdirectory which is always included for initial settings.  You can also copy
this into the project subdirectory to customize it by project by editing the 
variables and options as the project specific config will be read if found
after the global.  Note that the output indicates whether global or 
local config options were used. The local extension expects that the 
local config file will be named appscoper_config.cfm.

Note that while a local config will be ready later only options set will override
those in the global config. For example, you might set the global file extensions
common to all projects and only set the excludePaths on a project by project basis
as this is likely to vary.  By commenting out the request.includedExtensions value
in the local config you will get the global file extension list.

What's the point (background) - http://en.wikipedia.org/wiki/Source_lines_of_code

Let me know if you find this useful - bob.chesley@nhsoftwerks.com
Thanks for taking a look.