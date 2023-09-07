function Convert-Bytes {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[string]$bytes
	)
	switch ($bytes.length) {
		{$_ -le 3} {$bytes + " B "}
		{($_ -ge 4) -and ($_ -le 6)} {[string]("{0:F2}" -f ($bytes/[Math]::Pow(1024,1))) + " KB"}
		{($_ -ge 7) -and ($_ -le 9)} {[string]("{0:F2}" -f ($bytes/[Math]::Pow(1024,2))) + " MB"}
		{($_ -ge 10) -and ($_ -le 12)} {[string]("{0:F2}" -f ($bytes/[Math]::Pow(1024,3))) + " GB"}
		{($_ -ge 13) -and ($_ -le 15)} {[string]("{0:F2}" -f ($bytes/[Math]::Pow(1024,4))) + " TB"}
		{$_ -ge 16} {" >=1 PiB!!"}
	}
}

Write-Host "`nCalculating. Please wait..."

$AllFiles = Get-ChildItem -Recurse -Force -File | Select-Object Length, FullName
$TotalUsage = Convert-Bytes ($AllFiles | Measure-Object -Property Length -Sum).Sum

Write-Host "`nChecking all files in folder: " -NoNewLine
Write-Host "$($PWD.ProviderPath)" -ForegroundColor 'green'
Write-Host "Total data in this folder: " -NoNewLine
Write-Host "$TotalUsage" -ForegroundColor 'green'
Write-Host "Total files in this folder: " -NoNewLine
Write-Host "$($AllFiles.Count)" -ForegroundColor 'green'

# Output the top 30 largest files in this directory sorted by size. Show the size and the file path to them (minus the current path name).
Write-Host "`nThe largest files in this folder are:" -NoNewLine
$AllFiles | 
Sort-Object -Descending -Property Length | 
Select-Object -First 30 | 
Select-Object Length, @{Name="Size";Expression={Convert-Bytes $_.Length}}, @{Name="File";Expression={$_.FullName -replace ($($PWD.ProviderPath) -replace '\\','\\' -replace '\$','\$') -replace '^\\(.*)','$1'}} | 
Sort-Object -Descending -Property Length, @{Expression="File";Descending=$false} | 
Format-Table @{Name="Size";Expression={$_.Size};Align="Right"},File -Wrap

Write-Host "Press any key to exit."
[Console]::ReadKey() > $null
