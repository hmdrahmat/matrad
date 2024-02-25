#!/bin/bash

# Install OpenVPN
sudo apt update
sudo apt install -y openvpn

# Prompt user for OpenVPN server address
read -p "Enter OpenVPN server address: " VPN_SERVER

# Create OpenVPN client configuration file
sudo tee /etc/openvpn/client/client.conf > /dev/null <<EOF
client
dev tun
proto tcp
remote $VPN_SERVER 1194
nobind
persist-key
persist-tun
remote-cert-tls server
ca /etc/openvpn/cert_export_CA.crt
cert /etc/openvpn/cert_export_client.crt
key /etc/openvpn/cert_export_client.key
verb 4
mute 10
auth SHA1
cipher AES-256-CBC
auth-user-pass /etc/openvpn/secret
auth-nocache
askpass /etc/openvpn/client/client.pass
EOF

# Create OpenVPN password file
echo "12345678" | sudo tee /etc/openvpn/client/client.pass > /dev/null

# Enable and start OpenVPN service
sudo systemctl enable openvpn-client@client
sudo systemctl start openvpn-client@client

echo "OpenVPN has been installed and configured successfully!"
