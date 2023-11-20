#Storyline: This code is going to take system information and place it inside a zipfile. This code will also create the corrispoding hash tables for the files that are being created

# Prompt the user for the location to save the results
$resultsDirectory = Read-Host "Please enter the full path of the directory where you want to save the results"

function file-hash() {
    
    #Create the hashes for the coresponding files 
    $hash = Get-FileHash -path $resultsDirectory/*csv -Algorithm SHA256

    #creating a new file inside the specifed directory which creates a checksum for the hashes 
    $hash | Out-file $resultsDirectory\checksums.txt 
}
    

# 1. Running Processes and the path for each process.
$processesPath = Join-Path -Path $resultsDirectory -ChildPath "processes.csv"
Get-Process | Select-Object Name, Path | Export-Csv -Path $processesPath -NoTypeInformation

# 2. All registered services and the path to the executable controlling the service (you'll need to use WMI).
$servicesPath = Join-Path -Path $resultsDirectory -ChildPath "services.csv"
Get-WmiObject -Class Win32_Service | Select-Object Name, PathName | Export-Csv -Path $servicesPath -NoTypeInformation

# 3. All TCP network sockets
$tcpSocketsPath = Join-Path -Path $resultsDirectory -ChildPath "tcpSockets.csv"
Get-NetTCPConnection | Export-Csv -Path $tcpSocketsPath -NoTypeInformation

# 4. All user account information (you'll need to use WMI)
$userAccountsPath = Join-Path -Path $resultsDirectory -ChildPath "userAccounts.csv"
Get-WmiObject -Class Win32_UserAccount | Export-Csv -Path $userAccountsPath -NoTypeInformation

# 5. All NetworkAdapterConfiguration information
$networkAdaptersPath = Join-Path -Path $resultsDirectory -ChildPath "networkAdapterConfiguration.csv"
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Export-Csv -Path $networkAdaptersPath -NoTypeInformation

# 6. MP Threat(This is good because you can check the history of threats that Windows Defender have previously detected)
$MPThreat = Join-Path $resultsDirectory -ChildPath "MPThreat.csv"
Get-MpThreat | Export-Csv -path $MPThreat -NoTypeInformation

# 7. Security Event Logs (This is good because you can check the security events in the logs)
$Securityeventlogs = Join-Path $resultsDirectory -ChildPath "Securityeventlogs.csv"
Get-Eventlog -LogName Security | Export-csv -Path $Securityeventlogs -NoTypeInformation

# 8. System event logs (This is good because you can check the system event logs to see what happened within the system)
$SystemeventLogs = join-path $resultsDirectory -ChildPath "SystemEventLogs.csv"
Get-Eventlog -LogName System | export-csv -path $SystemeventLogs -NoTypeInformation

# 9. Computer Info (This is good because you can check to see if anything has been changed within the computer or if anything seems out of place compared to it's last state) 
$CompInfo = Join-Path $resultsDirectory -ChildPath "CompInfo.csv"
Get-ComputerInfo | export-csv -path $CompInfo -NoTypeInformation

#Creating the name of the zip file and telling it to park inside the directory the user chose 
$zipfilepath = "$resultsDirectory\resultszip.zip"

#Compress the directory results
Compress-Archive -Path $resultsDirectory\* -DestinationPath $zipfilepath -Force

#Create a hash tale for the zipfile
$zipfilehash = Get-FileHash -path $zipfilepath -Algorithm SHA256

#take that hash table associated with the zipfile and place it inside the directory chosen by the user
$zipfilehash | Out-File $resultsDirectory\zipfilehash.txt

#calling the hashing function from appove 
file-hash 
