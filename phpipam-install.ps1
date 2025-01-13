# PowerShell script to install phpIPAM on Windows Server

# Default database credentials
$dbName = "phpipam"
$dbUser = "phpipam_user"
$dbPass = "phpipam_pass"

# Ask user for database credentials
Write-Host "Do you want to set custom database credentials? (Y/N)" -ForegroundColor Yellow
$customDb = Read-Host
if ($customDb -match "^[Yy]$") {
    $dbName = Read-Host "Enter database name (default: phpipam)"
    $dbUser = Read-Host "Enter database user (default: phpipam_user)"
    $dbPass = Read-Host "Enter database password (default: phpipam_pass)"
    if (-not $dbName) { $dbName = "phpipam" }
    if (-not $dbUser) { $dbUser = "phpipam_user" }
    if (-not $dbPass) { $dbPass = "phpipam_pass" }
}

# Ask user for web server choice
Write-Host "Select the web server to install:" -ForegroundColor Yellow
Write-Host "1) IIS (Internet Information Services)"
Write-Host "2) XAMPP (Apache)"
$webServerChoice = Read-Host "Enter your choice (1/2)"

# Ask user for PHP version
Write-Host "Enter the PHP version to install (default: 8.1.14):" -ForegroundColor Yellow
$phpVersion = Read-Host
if (-not $phpVersion) { $phpVersion = "8.1.14" }

# Install Web Server
if ($webServerChoice -eq "1") {
    Write-Host "Installing IIS..." -ForegroundColor Yellow
    if (!(Get-WindowsFeature -Name Web-Server).Installed) {
        Install-WindowsFeature -Name Web-Server -IncludeManagementTools
        Write-Host "IIS installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "IIS is already installed." -ForegroundColor Green
    }
} elseif ($webServerChoice -eq "2") {
    Write-Host "Installing XAMPP..." -ForegroundColor Yellow
    $xamppInstallerUrl = "https://www.apachefriends.org/xampp-files/8.1.14/xampp-windows-x64-8.1.14-0-VS16-installer.exe"
    $xamppInstallerPath = "C:\\xampp-installer.exe"
    Invoke-WebRequest -Uri $xamppInstallerUrl -OutFile $xamppInstallerPath
    Start-Process -FilePath $xamppInstallerPath -ArgumentList "/SILENT" -Wait
    Write-Host "XAMPP installed successfully!" -ForegroundColor Green
}

# Install PHP
Write-Host "Installing PHP version $phpVersion..." -ForegroundColor Yellow
$phpInstallerUrl = "https://windows.php.net/downloads/releases/php-$phpVersion-Win32-vs16-x64.zip"
$phpZipPath = "C:\\php.zip"
$phpInstallPath = "C:\\php"

Invoke-WebRequest -Uri $phpInstallerUrl -OutFile $phpZipPath
Expand-Archive -Path $phpZipPath -DestinationPath $phpInstallPath -Force
Remove-Item -Path $phpZipPath

Write-Host "PHP version $phpVersion installed at $phpInstallPath." -ForegroundColor Green

# Install MySQL
Write-Host "Installing MySQL..." -ForegroundColor Yellow
$mysqlInstallerUrl = "https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-web-community-8.0.34.0.msi"
$mysqlInstallerPath = "C:\\mysql-installer.msi"

Invoke-WebRequest -Uri $mysqlInstallerUrl -OutFile $mysqlInstallerPath
Start-Process -FilePath $mysqlInstallerPath -ArgumentList "/quiet" -Wait
Write-Host "MySQL installation completed." -ForegroundColor Green

# Configure Database
Write-Host "Configuring phpIPAM database..." -ForegroundColor Yellow
& "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -u root -p -e "
CREATE DATABASE IF NOT EXISTS `$dbName;
CREATE USER `$dbUser@localhost IDENTIFIED BY `$dbPass;
GRANT ALL PRIVILEGES ON `$dbName.* TO `$dbUser@localhost;
FLUSH PRIVILEGES;
"
Write-Host "Database configured successfully." -ForegroundColor Green

# Download and Configure phpIPAM
Write-Host "Downloading phpIPAM..." -ForegroundColor Yellow
$phpipamUrl = "https://github.com/phpipam/phpipam/archive/refs/heads/master.zip"
$phpipamZipPath = "C:\\phpipam.zip"
$phpipamPath = "C:\\inetpub\\wwwroot\\phpipam"

Invoke-WebRequest -Uri $phpipamUrl -OutFile $phpipamZipPath
Expand-Archive -Path $phpipamZipPath -DestinationPath $phpipamPath -Force
Remove-Item -Path $phpipamZipPath

Write-Host "phpIPAM downloaded to $phpipamPath." -ForegroundColor Green

# Configure phpIPAM
Write-Host "Configuring phpIPAM..." -ForegroundColor Yellow
$configFilePath = "$phpipamPath\\config.dist.php"
$configNewFilePath = "$phpipamPath\\config.php"

Copy-Item -Path $configFilePath -Destination $configNewFilePath
(Get-Content $configNewFilePath) -replace "'localhost';", "'localhost';" | `
    Set-Content $configNewFilePath

Write-Host "phpIPAM configured successfully." -ForegroundColor Green

# Display Installation Summary
$osVersion = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty Caption
Write-Host ""
Write-Host "Installation Summary:" -ForegroundColor Green
Write-Host "========================================"
Write-Host "| Parameter          | Value            |"
Write-Host "========================================"
Write-Host "| OS and Version     | $osVersion       |"
Write-Host "| Web Server         | $(if ($webServerChoice -eq '1') { 'IIS' } else { 'XAMPP' }) |"
Write-Host "| PHP Version        | $phpVersion      |"
Write-Host "| MySQL Version      | 8.0.34           |"
Write-Host "| Database Name      | $dbName          |"
Write-Host "| Database User      | $dbUser          |"
Write-Host "| Database Password  | $dbPass          |"
Write-Host "========================================"

Write-Host "phpIPAM installation completed! Access it at http://localhost/phpipam" -ForegroundColor Green
