#!/usr/local/bin/bash
PGRESVER=93

sh /usr/rsetup/scripts/__fetch_ports.sh

# Install
echo "Building PostgreSQL + PostGIS..."
(cd /usr/ports/databases/postgis21 && sudo make -DBATCH install clean >/dev/null)
echo "PostgreSQL/PostGIS built."
#sudo pkg install -y postgis >/dev/null #perl5 postgresql${PGRESVER}-server postgresql${PGRESVER}-client gdal geos proj gmake iconv libiconv postgis >/dev/null

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
echo "Creating a new superuser named 'vagrant':"
sudo -u pgsql bash -c "createuser -sdrP vagrant"

# Create a PostGIS template
sh /usr/rsetup/scripts/__create_postgis_template.sh >/dev/null

echo "postgresql installed:"
psql -V
pkg info | grep postgis | awk '{ print $1 }'