#!/bin/bash

echo "Select the use-case for iptables configuration:"
echo "1. Workstation"
echo "2. Server"
echo "3. Prototype Domain Controller"
read -p "Enter your choice (1/2/3): " choice

# Function to flush existing rules and set default policies
initialize_iptables() {
  sudo iptables -F
  sudo iptables -X
  sudo iptables -P INPUT ACCEPT
  sudo iptables -P FORWARD ACCEPT
  sudo iptables -P OUTPUT ACCEPT
}

# Use-case 1: Workstation
configure_workstation() {
  initialize_iptables
  # Allow specific outgoing traffic and drop all others
  sudo iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT # HTTP
  sudo iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT # HTTPS
  sudo iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT # SSH
  sudo iptables -A OUTPUT -p tcp --dport 25 -j ACCEPT # SMTP
  sudo iptables -A OUTPUT -p tcp --dport 110 -j ACCEPT # POP3
  sudo iptables --policy OUTPUT DROP
  sudo iptables -L
}

# Use-case 2: Server
configure_server() {
  initialize_iptables
  # Allow specific incoming traffic and drop all others
  sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT # SSH
  sudo iptables -A INPUT -p tcp --dport 20 -j ACCEPT # FTP
  sudo iptables -A INPUT -p tcp --dport 21 -j ACCEPT # FTP
  sudo iptables -A INPUT -p tcp --dport 139 -j ACCEPT # SMB and NetBIOS
  sudo iptables -A INPUT -p tcp --dport 445 -j ACCEPT # SMB
  sudo iptables -A INPUT -p udp --dport 137 -j ACCEPT # NetBIOS
  sudo iptables -A INPUT -p udp --dport 138 -j ACCEPT # NetBIOS
  sudo iptables --policy INPUT DROP
  sudo iptables -L
}

# Use-case 3: Prototype Domain Controller
configure_domain_controller() {
  initialize_iptables
  # Allow specific incoming and outgoing traffic, dynamic ports, and drop all others
  sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT # SSH
  sudo iptables -A INPUT -p tcp --dport 3389 -j ACCEPT # Remote Desktop
  sudo iptables -A INPUT -p udp --dport 3389 -j ACCEPT # Remote Desktop
  sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT # DNS
  sudo iptables -A INPUT -p tcp --dport 53 -j ACCEPT # DNS
  sudo iptables -A INPUT -p udp --dport 161 -j ACCEPT # SNMP
  sudo iptables -A INPUT -p udp --dport 162 -j ACCEPT
  sudo iptables -A INPUT -p tcp --match multiport --dports 32768:60999 -j ACCEPT # Dynamic port range
  sudo iptables -A INPUT -p udp --match multiport --dports 32768:60999 -j ACCEPT # Dynamic port range

  sudo iptables --policy INPUT DROP

  # Allow specific incoming and outgoing traffic, dynamic ports, and drop all others
  sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT # SSH
  sudo iptables -A OUTPUT -p tcp --sport 3389 -j ACCEPT # Remote Desktop
  sudo iptables -A OUTPUT -p udp --sport 3389 -j ACCEPT # Remote Desktop
  sudo iptables -A OUTPUT -p udp --sport 53 -j ACCEPT # DNS
  sudo iptables -A OUTPUT -p tcp --sport 53 -j ACCEPT # DNS
  sudo iptables -A OUTPUT -p udp --sport 161 -j ACCEPT # SNMP
  sudo iptables -A OUTPUT -p udp --sport 162 -j ACCEPT # SNMP
  sudo iptables -A OUTPUT -p tcp --match multiport --dports 32768:60999 -j ACCEPT # Dynamic port range
  sudo iptables -A OUTPUT -p udp --match multiport --dports 32768:60999 -j ACCEPT # Dynamic port range

  sudo iptables --policy OUTPUT DROP
  sudo iptables -L
}

case $choice in
  1)
    configure_workstation
    echo "Workstation configuration applied."
    ;;
  2)
    configure_server
    echo "Server configuration applied."
    ;;
  3)
    configure_domain_controller
    echo "Prototype Domain Controller configuration applied."
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac
