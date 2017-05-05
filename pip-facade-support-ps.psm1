########################################################
##
## pip-facade-support-ps.ps1
## Client facade to product support Pip.Services
## Powershell module entry
##
#######################################################

$path = $PSScriptRoot
if ($path -eq "") { $path = "." }

. "$($path)/src/clients/Feedbacks.ps1"
. "$($path)/src/clients/Announcements.ps1"
