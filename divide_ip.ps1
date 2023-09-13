$filePath = ".\ip_check\ping_ip\ip_list.txt"
$fileContents = Get-Content -Path $filePath
$list1 = New-Object System.Collections.ArrayList
$list2 = New-Object System.Collections.ArrayList
$ipRegexPattern = "^(([01]?[0-9]?[0-9]?|2[0-4]?[0-9]?|25[0-5])\.){3}([01]?[0-9]?[0-9]?|2[0-4][0-9]|25[0-5])$"
foreach ($ipToCheck in $fileContents) {
    if ($ipToCheck -match $ipRegexPattern) {
        $result = Test-Connection -ComputerName $ipToCheck
        if ($result.StatusCode -eq 0) {
                $list1.Add($ipToCheck)
            } else {
                $list2.Add($ipToCheck )
            }
    } else {
        $list2.Add($($ipToCheck) )

}
}
Write-Host "list1: $($list1)"
Write-Host "list2: $($list2)"
$filePath = ".\ip_check\ping_ip\pingable_ip.txt"
$list1 | Set-Content -Path $filePath
$filePath = ".\ip_check\ping_ip\unpingable_ip.txt"
$list2 | Set-Content -Path $filePath
