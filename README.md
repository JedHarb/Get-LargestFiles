# Get-LargestFiles
See which files are taking up the most drive space.

There are lots of great free tools out there to see what's using the most space on your computer (WinDirStat, TreeSize Free). But sometime, you just want a quick script to show you the basics.

You can drop and run this script from a folder to see the largest files in it, plus some other useful info. You can also navigate the PowerShell console to any directory and run this code to get the same result.

Feel free to change 30 to any number X to see only the top X results.

If you'd rather save the results than just outputing them to the console, you can change the Format-Table line to output the results to a .txt (with Out-File https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file) or to a .csv (with Out-CSV https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-csv).
