ipconfig /all | Select-String -Pattern "DHCP Server"
ipconfig /all | Select-String -Pattern "DNS Server"
Get-Process | Select-Object ProcessName, Path, ID | export-Csv -NoTypeInformation `
-Path "C:\Users\andy.phuong\Desktop\processes.csv" 
Get-Service | Where { $_.Status -eq "Running" } | Select-Object DisplayName, Status |export-Csv -NoTypeInformation `
-Path "C:\Users\andy.phuong\Desktop\services.csv" 
Start-Process -FilePath "C:Windows\System32\calc.exe"
sleep 2
Stop-Process -Name CalculatorApp
