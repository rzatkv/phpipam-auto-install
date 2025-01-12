# phpipam-auto-install

This repository contains an automated installation script for setting up phpIPAM along with its required dependencies on a Linux server.

## Features
- Detects the operating system (Ubuntu, CentOS, RHEL).
- Allows user to choose between Apache or Nginx as the web server.
- Configures MariaDB and prompts for database credentials.
- Downloads and configures the latest version of phpIPAM.
- Sets up firewall rules for HTTP and HTTPS.
- Provides a detailed summary of the installation.

## Prerequisites
- Root or sudo privileges on the target system.
- Access to the internet for downloading required packages.

## Installation Steps

1. Clone this repository:
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

## Notes
- default admin user details : Username: Admin - Password: ipamadmin for login to phpipam.
- The script defaults to `phpipam` for the database name, `phpipam` for the database user, and `phpipamadmin` for the database password if no custom values are provided during the setup.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.
