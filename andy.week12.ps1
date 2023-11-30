#Login to a remote SSH Server
New-SSHSession -ComputerName '192.168.4.22' -Credential (Get-Credential sys320)

while ($True) {
#Prompt to run commmands
$the_cmd = read-host -Prompt "Please enter a command"

#Run command on SSH Server
(Invoke-SSHCommand -index 0 $the-cmd).Output

}
Set-SCPFile -Computername '192.168.4.22' -Credential (Get-Credential sys320)
-RemotePath '/home/sys320' -LocalFile '.\tedx.jpeg'

#Close SSH Session
Remove-SSHSession -SessionId 