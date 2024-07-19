#!/bin/bash

print_message() {
    echo "==== $1 ===="
}

# Ensure the script runs as root
if [ "$(id -u)" -ne "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Update and install necessary packages
print_message "Updating system and installing necessary packages"
apt update
apt install -y apache2 squid ufw

# Network Configuration
print_message "Configuring network"
cat <<EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.16.21/24
EOF
netplan apply

# Update /etc/hosts
print_message "Updating /etc/hosts"
sed -i '/^192.168.16.21/d' /etc/hosts
echo "192.168.16.21 server1" >> /etc/hosts

# Start and enable services
print_message "Starting and enabling services"
systemctl enable apache2 squid
systemctl start apache2 squid

# Configure UFW
print_message "Configuring UFW"
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 3128/tcp
ufw enable

# Create user accounts and SSH keys
print_message "Creating user accounts and setting up SSH keys"
users=("dennis" "aubrey" "captain" "snibbles" "brownie" "scooter" "sandy" "perrier" "cindy" "tiger" "yoda")

for user in "${users[@]}"; do
    if ! id "$user" &>/dev/null; then
        useradd -m -s /bin/bash "$user"
    fi
    mkdir -p /home/"$user"/.ssh
    chown "$user":"$user" /home/"$user"/.ssh
    chmod 700 /home/"$user"/.ssh
    # Add public keys to authorized_keys
    # Assuming you have the keys for each user, modify this part as needed
done

# Add specific SSH key for user 'dennis'
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5kndS4HmgTrKBT8SKzhK4rhGkEVGlCI student@generic-vm" >> /home/dennis/.ssh/authorized_keys

print_message "Script execution completed"
