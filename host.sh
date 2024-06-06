

# Variables
HOSTNAME="app.cadanapay.com"
IP_ADDRESS=144.217.241.43
HOSTS_FILE="/etc/hosts"

# Add the new entry
echo "$IP_ADDRESS $HOSTNAME" >> $HOSTS_FILE