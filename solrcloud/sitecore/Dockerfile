FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Uses dism.exe to install the IIS role.
#RUN DISM /Online /Enable-Feature /FeatureName:IIS-WebServer /All /NoRestart

# Install IIS and ASP.net 4.7

RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment

RUN powershell Enable-WindowsOptionalFeature -online -FeatureName NetFx4Extended-ASPNET45
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45

RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic

RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45

# Extra Options
#RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionDynamic
#RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility
#RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-ODBCLogging
#RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-URLAuthorization
#RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-HostableWebCore
RUN powershell Enable-WindowsOptionalFeature -Online -FeatureName IIS-IPSecurity

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

# Install Sitecore 9 Identity Server dependencies
RUN powershell choco install -y dotnetcore-windowshosting
#RUN powershell choco install -y dotnetcore
#RUN powershell choco install -y dotnetcore-sdk
#RUN powershell choco install -y jdk11

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


# Install Sitecore9 WebSite
# C:\inetpub\wwwroot\Sitecore9.local should be mapped or replaced

# Run import module if needed
#RUN powershell Import-Module WebAdministration
RUN mkdir C:\inetpub\wwwroot\Sitecore9.local
RUN powershell New-WebAppPool -name "Sitecore9AppPool"
RUN powershell New-WebSite -name "Sitecore9" -PhysicalPath "%SystemDrive%\inetpub\wwwroot\Sitecore9.local" -HostHeader "Sitecore9.dev.local" -ApplicationPool "Sitecore9AppPool"

RUN mkdir C:\inetpub\wwwroot\Sitecore9.xconnect
RUN powershell New-WebAppPool -name "Sitecore9XconnectAppPool"
RUN powershell New-WebSite -name "Sitecore9.xconnect" -PhysicalPath "%SystemDrive%\inetpub\wwwroot\Sitecore9.xconnect" -HostHeader "Sitecore9.xconnect" -ApplicationPool "Sitecore9XconnectAppPool"

RUN mkdir C:\inetpub\wwwroot\Sitecore9.identityserver
RUN powershell New-WebAppPool -name "Sitecore9IdentityServerAppPool"
RUN powershell New-WebSite -name "Sitecore9.identityserver" -PhysicalPath "%SystemDrive%\inetpub\wwwroot\Sitecore9.identityserver" -HostHeader "Sitecore9.identityserver" -ApplicationPool "Sitecore9IdentityServerAppPool"

# UPDATE FOR YOUR ENVIRONMENT
# ===========================

# Windows containers are missing host.docker.internal so must add explicitly
# Single-quote needed since double-quote will error out powershell command for some reason
RUN powershell Add-Content C:\Windows\System32\drivers\etc\hosts '10.0.75.1 host.docker.internal'
