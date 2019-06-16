# To run docker compose
# docker-compose -f .\docker-compose.yml up --no-start sitecore
# docker-compose -f .\docker-compose.yml start sitecore
# docker-compose -f .\docker-compose.yml down

# To force build remove the image or run the following:
# docker-compose -f .\docker-compose.yml build sitecore

FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Uses dism.exe to install the IIS role.
RUN DISM /Online /Enable-Feature /FeatureName:IIS-WebServer /All /NoRestart

# Install IIS Windows Management Server
# On Client Install IIS Manager for Remote Administration 1.2 - https://www.iis.net/downloads/microsoft/iis-manager
# Connect using IP of container
RUN powershell net user Administrator /active:yes "goBoing0"
RUN powershell Install-WindowsFeature Web-Mgmt-Service
RUN powershell Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1
RUN powershell Set-Service -name WMSVC -StartupType Automatic

# Install Chocolatey (Windows Package Manager)
RUN powershell Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install basic utilities
RUN powershell choco install -y 7zip
RUN powershell choco install -y vim

# Install Microsoft Visual C++ Redistributable for Visual Studio 2017 via Chocolatey (fix for ChilkatDotNet47.dll load due to dependency error)
RUN powershell choco install -y vcredist2017

# Install Node for Sitecore JSS
RUN powershell choco install -y nodejs-lts

# Install Sitecore 9 dependencies
RUN powershell choco install -y UrlRewrite
RUN powershell choco install -y webdeploy

# MISCELLANEOUS COMMANDS WHEN EXECUTING ON MACHINE
# Start IIS Remote Manager service
#RUN powershell Start-service WMSVC
# Restart to activate Administrator changes
#RUN powershell Restart-Service WMSVC
# Set PATH for all users
#RUN setx -m PATH "%PATH%;C:\Program Files (x86)\vim\vim80"
#RUN set PATH="%PATH%;C:\Program Files (x86)\vim\vim80"
#RUN setx -m PATH "%PATH%;C:\Program Files\nodejs"
# Creates an HTML file and adds content to this file.
#RUN echo "Hello World - Dockerfile" > c:\inetpub\wwwroot\index.html
# Check installed features
#Get-WindowsFeature -ComputerName Server01 | Where Installed
# List Chocolatey installed packages
#choco list --local-only
