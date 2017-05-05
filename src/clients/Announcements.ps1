########################################################
##
## Announcements.ps1
## Client facade to product support Pip.Services
## System announcements commands
##
#######################################################


function Get-PipAnnouncements
{
<#
.SYNOPSIS

Gets page with announcements by specified criteria

.DESCRIPTION

Gets a page with announcements that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/announcements)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

# Read top 10 announcements from test cluster that contain 'abc' string
PS> Get-PipAnnouncements -Name "test" -Filter @{ tags="goals,success" } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/announcements",
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{},
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = $Uri

        $params = $Filter +
        @{ 
            skip = $Skip;
            take = $Take
            total = $Total
        }

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Params $params

        Write-Output $result.Data
    }
    end {}
}


function Get-PipAnnouncement
{
<#
.SYNOPSIS

Gets announcement by id

.DESCRIPTION

Gets announcement by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/announcements/{0})

.PARAMETER Id

A announcement id

.EXAMPLE

# Gets announcement with id 1232
PS> Get-PipAnnouncement -Name "test" -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/announcements/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = $Uri -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route
        
        Write-Output $result
    }
    end {}
}


function Get-PipRandomAnnouncement
{
<#
.SYNOPSIS

Gets a random announcement

.DESCRIPTION

Gets a random announcement

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/announcements/random)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

# Gets a random
PS> Get-PipRandomAnnouncement -Name "test"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/announcements/random",
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{}
    )
    begin {}
    process 
    {
        $route = $Uri
        $params = $Filter

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Params $params
        
        Write-Output $result
    }
    end {}
}


function New-PipAnnouncement
{
<#
.SYNOPSIS

Creates a new announcement

.DESCRIPTION

Creates a new announcement

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/announcements)

.PARAMETER Announcement

A announcement with the following structure:
- id: string
- category: string
- app: string
- title: MultiString
- content: MultiString
- location: LocationV1
  - name: string
  - pos: any (GeoJSON)
- start_time: Date
- end_time: Date
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- importance: number
- custom_hdr: any
- custom_dat: any

.EXAMPLE

# Creates a new announcement
PS> New-PipAnnouncement -Name "test" -Announcement @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Post",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/announcements",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Announcement
    )
    begin {}
    process 
    {
        $route = $Uri

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $Announcement
        
        Write-Output $result
    }
    end {}
}


function Update-PipAnnouncement
{
<#
.SYNOPSIS

Creates a new announcement

.DESCRIPTION

Creates a new announcement

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/announcements/{0})

.PARAMETER Announcement

A announcement with the following structure:
- id: string
- category: string
- app: string
- title: MultiString
- content: MultiString
- location: LocationV1
  - name: string
  - pos: any (GeoJSON)
- start_time: Date
- end_time: Date
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- importance: number
- custom_hdr: any
- custom_dat: any


.EXAMPLE

# Update existing announcement
PS> Update-PipAnnouncement -Name "test" -Announcement @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Put",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/announcements/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Announcement
    )
    begin {}
    process 
    {
        $route = $Uri -f $Announcement.id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $Announcement
        
        Write-Output $result
    }
    end {}
}


function Remove-PipAnnouncement
{
<#
.SYNOPSIS

Removes announcement by id

.DESCRIPTION

Removes announcement by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/1.0/announcements/{0})

.PARAMETER Id

A announcement id

.EXAMPLE

# Delete announcement with id 1232
PS> Remove-PipAnnouncement -Name "test" -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Delete",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/announcements/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = $Uri -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route
        
        Write-Output $result
    }
    end {}
}