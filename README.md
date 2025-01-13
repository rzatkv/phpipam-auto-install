# phpipam-auto-install

A comprehensive installation script to automate the setup of phpIPAM on both Linux and Windows servers. This script simplifies the installation of phpIPAM, its dependencies, and the web server configuration.

## Features

- **Cross-Platform Support**:
  - Installs on both Linux (Ubuntu, CentOS, RHEL) and Windows Server.
- **Web Server Options**:
  - Supports Apache, Nginx (Linux), and IIS, XAMPP (Windows).
- **Database Configuration**:
  - Prompts for custom database credentials or uses default values.
- **PHP Version Selection**:
  - Allows users to select the PHP version during installation.
- **Installation Summary**:
  - Displays a detailed summary table after installation, including:
    - OS version
    - Web server version
    - PHP version
    - MySQL version
    - Database credentials
- **Firewall Configuration**:
  - Automatically configures firewall rules (Linux only).

## Prerequisites

### For Linux:
- A fresh installation of Ubuntu, CentOS, or RHEL.
- Root or sudo access.

### For Windows:
- Windows Server (2016 or later) with Administrator privileges.
- PowerShell 5.1 or later.

---

## Installation Steps

### Linux

1. Clone the repository:
   ```bash
   git clone https://github.com/rzatkv/phpipam-auto-install.git
   cd phpipam-auto-install
   ```

2. Make the script executable:
   ```bash
   chmod +x phpipam-install
   ```

3. Run the script:
   ```bash
   sudo ./phpipam-install
   ```

4. Follow the prompts to complete the installation.

5. Access phpIPAM in your browser:
   ```
   http://<your_server_ip>/phpipam
   ```

---

### Windows

1. Download the latest release:
   - Go to the [Releases](https://github.com/rzatkv/phpipam-auto-install/releases) page.
   - Download the latest version (ZIP file).

2. Extract the ZIP file:
   - Right-click the ZIP file and select **Extract All**.

3. Run the script:
   - Open PowerShell as Administrator.
   - Navigate to the script directory:
     ```bash
     cd path\to\extracted\folder
     ```
   - Execute the script:
     ```bash
     .\phpipam-install.ps1
     ```

4. Follow the on-screen prompts to complete the installation.

5. Access phpIPAM in your browser:
   ```
   http://localhost/phpipam
   ```

---

## Notes

- On Windows, make sure your server has internet access to download dependencies.
- The script automatically disables installation scripts (`$disable_installer = true`) in the phpIPAM configuration after setup.
- Default database credentials (if not customized):
  - **Database Name**: `phpipam`
  - **User**: `phpipam_user`
  - **Password**: `phpipam_pass`
- Default phpIPAM admin credentials:
  - **Username**: `admin`
  - **Password**: `ipamadmin`

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Troubleshooting

### Common Issues

1. **Database Connection Error**:
   - Ensure the MySQL service is running.
   - Verify the database credentials in the `config.php` file.

2. **Firewall Issues** (Linux):
   - Ensure HTTP (port 80) and HTTPS (port 443) are open in the firewall.

3. **Permissions Issues**:
   - Ensure the script is executed with root or Administrator privileges.

### Reporting Bugs
If you encounter any issues, please create an issue in the [GitHub Issues](https://github.com/rzatkv/phpipam-auto-install/issues) section.

---

## Contributing

Contributions are welcome! Feel free to fork this repository, make changes, and submit a pull request.

---

## Author

**Reza Karimi**  
[GitHub Profile](https://github.com/rzatkv)
