<#  
.SYNOPSIS  
  Invoke installation of OSD Task sequences on remote computers   
   
.DESCRIPTION  
  Function that will Invoke installation of OSD Task sequences on remote computers  in Software Center that's available for the remote computer.   
   
.PARAMETER Computername  
    Specify the remote computer you wan't to run the script against   
   
.PARAMETER AppName  
    Specify the OSD Task sequence you wan't to invoke an Installation of    
     
   
.EXAMPLE  
  
    Invoke-OSDInstall -Computername SD010 -OSDName "Task Sequence"  
  

       
   
.NOTES  
    FileName:    Invoke-OSDInstall.ps1  
    Author:      Timmy Andersson  
    Contact:     @Timmyitdotcom  
    Created:     2017-01-08  
    
               
#>  

function Invoke-OSDInstall
{
 Param
(
 [String][Parameter(Mandatory=$True, Position=1)] $Computername,
 [String][Parameter(Mandatory=$True, Position=2)] $OSDName

)
Begin
{

 $CIMClass = (Get-CimClass -Namespace root\ccm\clientsdk -ComputerName $Computername -ClassName CCM_ProgramsManager)
 $OSD = (Get-CimInstance -ClassName CCM_Program -Namespace "root\ccm\clientSDK" -ComputerName $Computername | Where-Object {$_.Name -like "$OSDName"})
 
 $Args = @{PackageID = $OSD.PackageID
          ProgramID = $OSD.ProgramID
          }   
}

Process
{
  

Invoke-CimMethod -CimClass $CIMClass -ComputerName $Computername -MethodName "ExecuteProgram" –Arguments $Args

}
End {}
} 
