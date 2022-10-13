@echo off
set /p distroname="Enter chosen distro name: "
set /p fileloc="Enter path to tar file: "
set /p distropath="Enter path to distro: "
mkdir "%distropath%"
setlocal ENABLEDELAYEDEXPANSION
wsl --import "%distroname%" "%distropath%" "%fileloc%"
set distropath=%distropath:\=\\%
set distropath=%distropath: =\ %
wsl -s %distroname%
echo.
wsl bash /home/startup.sh "%distropath%"
echo.
start cmd.exe /b /c %APPDATA%\Code\User\settings.json
set /p irrelevent="That should be it^! Press enter to close"