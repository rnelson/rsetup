#!/usr/local/bin/bash
PGRESVER=93

# Install
echo "Installing PostgreSQL + PostGIS..."
sudo pkg install -y postgis >/dev/null
echo "PostgreSQL/PostGIS installed."

# Enable on boot
sudo bash -c "echo 'postgresql_enable=YES' >> /etc/rc.conf"

# Configure the server
sudo /usr/local/etc/rc.d/postgresql initdb >/dev/null
sudo sh /usr/rsetup/scripts/__pgsql_listen_tcpip.sh
sudo bash -c "echo 'local all  all  peer' > /usr/local/pgsql/data/pg_hba.conf"
sudo bash -c "echo 'host  all  all  10.0.1.0/24  md5' >> /usr/local/pgsql/data/pg_hba.conf"
sudo bash -c "echo 'host  all  all  10.0.2.0/24  md5' >> /usr/local/pgsql/data/pg_hba.conf"

# Start the server
sudo /usr/local/etc/rc.d/postgresql start >/dev/null

# Create a user
echo "Creating a new superuser named 'root' with password 'vagrant':"
sudo -u pgsql psql -c "create user root with password 'vagrant';"
echo "root user created."

# Create a PostGIS template
sh /usr/rsetup/scripts/__create_postgis_template.sh >/dev/null

echo "postgresql installed:"
psql -V
pkg info | grep postgis | awk '{ print $1 }'