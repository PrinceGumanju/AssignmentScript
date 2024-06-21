#!/bin/bash

# System Information
username=$(whoami)
Hostname=$(hostname)
OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)
Uptime=$(uptime)

# Hardware Information
CPU=$(lscpu)
Speed=$(lscpu | grep -E 'MHz')
RAM=$(free -h)
Disks=$(lsblk -d --output NAME,VENDOR,MODEL,SIZE)
Video=$(sudo lshw -C display)

# Network Information
FQDN=$(hostname --fqdn)
Host_Addresses=$(hostname -I)
GatewayIP=$(ip route show default)
DNS=$(cat /etc/resolv.conf)
Network_Cards=$(sudo lshw -class network -short)
Global_IP_Addresses=$(ip -o -4 addr show scope global)
Users_LoggedIn=$(who)
Disk_Space=$(df -h)
Process_Count=$(ps -e | wc -l)
Load_Averages=$(cat /proc/loadavg)
Listening_Networking_Ports=$(ss -tuln)
UFW_Rules=$(sudo ufw status)

# Output
echo "*** System Information ***"
echo "Username: $username"
echo "Hostname: $Hostname"
echo "OS: $OS"
echo "Uptime: $Uptime"

echo "*** Hardware Information ***"
echo "CPU:"
echo "$CPU"
echo "Speed:"
echo "$Speed"
echo "RAM:"
echo "$RAM"
echo "Disk(s):"
echo "$Disks"
echo "Video:"
echo "$Video"

echo "*** Network Information ***"
echo "FQDN: $FQDN"
echo "Host Addresses: $Host_Addresses"
echo "GatewayIP: $GatewayIP"
echo "DNS Server(s): $DNS"
echo "Network Cards:"
echo "$Network_Cards"
echo "Global IP Addresses:"
echo "$Global_IP_Addresses"

echo "*** System Status ***"
echo "Users Logged In:"
echo "$Users_LoggedIn"
echo "Disk Space:"
echo "$Disk_Space"
echo "Process Count: $Process_Count"
echo "Load Averages: $Load_Averages"
echo "Listening Network Ports:"
echo "$Listening_Networking_Ports"
echo "UFW Rules:"
echo "$UFW_Rules"
