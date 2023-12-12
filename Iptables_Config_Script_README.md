
# Iptables Configuration Script

This script is a utility for quickly configuring iptables rules according to different use-cases: Workstation, Server, and Prototype Domain Controller. It's designed to simplify the process of setting up iptables rules, making it accessible for administrators and users with varying levels of expertise.

## Features

- **Interactive Menu**: Offers an easy-to-use menu for selecting the configuration type.
- **Pre-Defined Configurations**: Includes specific configurations for different environments.
- **Flexibility**: Allows users to easily switch between different iptables setups.

## Prerequisites

- A Linux system with iptables installed.
- Bash shell.
- Root or sudo privileges.

## Usage

1. Download the script to your Linux system.
2. Make it executable with `chmod +x iptables_config.sh`.
3. Run the script with superuser privileges: `sudo ./iptables_config.sh`.
4. Select the appropriate configuration option when prompted.

## Configurations

1. **Workstation**: Optimizes iptables for typical workstation usage.
2. **Server**: Sets up iptables rules suited for a server environment.
3. **Prototype Domain Controller**: Configures iptables for a prototype domain controller, including dynamic port ranges.

## License

[Your License Information]

## Disclaimer

This script should be used with caution. Improper configuration of iptables can result in inaccessible services or security vulnerabilities. Always ensure that you understand the changes being made to your iptables rules.
