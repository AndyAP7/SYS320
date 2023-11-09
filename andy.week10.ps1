# Storyline: View the event logs, check for valid log, and print the results

function get_services() { 
    cls

    # grab running services & create an array
    $rServices = Get-Service | Where { $_.Status -eq "running" }
    $arrR = @()

    # Array for running services
    foreach ($tempR in $rServices) {
        $arrR += $tempR
    }




    # grab stopped services & create an array
    $sServices = Get-Service | Where { $_.Status -eq "stopped" }
    $arrS = @()

    # Array for stopped services
    foreach ($tempS in $sServices) {
        $arrS += $tempS
 
    }

    # Prompt for the user choose which prossess to view:
    $readServices = Read-Host -Prompt "Do you want to view all proccesses? Running ones? Or stopped ones? Or 'q' to quit."

    # Checks if the user wants to quit:
    if ($readServices -match "^[qQ]$") {
        break
    
    # ouputs the running services
    } elseif ($readServices -match "^running$") {
        write-host "Retrieving running services, please be patient."
        sleep 2

    $arrR | Out-Host

    Read-Host -Prompt "Press enter when done."
    get_services

    # ouputs the stopped services
    } elseif ($readServices -match "^stopped$") {
        write-host "Retrieving stopped services, please be patient"
        sleep 2
    
    $arrS | Out-Host

    Read-Host -Prompt "Press enter when done."
    get_services

    # ouputs all services
    } elseif ($readServices -match "^all$") {
        write-Host "Retrieving all processes and services, please be patient"
        sleep 2

        $arrR | Out-Host
        $arrS | Out-Host

      Read-Host -Prompt "Press enter when done."
      get_services

    } else {

    Write-Host "Invalid, please try again."
    sleep 2

    get_services

    }
} # End of get_services()


get_services
