#!/usr/local/bin/bash
createdb -E UTF8 -T template0 postgis_template
psql -d postgis_template -f /usr/local/share/postgresql/contrib/postgis-2.1/postgis.sql
psql -d postgis_template -f /usr/local/share/postgresql/contrib/postgis-2.1/spatial_ref_sys.sql
psql -d postgis_template -c "GRANT ALL ON geometry_columns TO PUBLIC;"
psql -d postgis_template -c "GRANT ALL ON geography_columns TO PUBLIC;"
psql -d postgis_template -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;"
psql -d postgis_template -c "VACUUM FULL;"
psql -d postgis_template -c "VACUUM FREEZE;"
psql -d postgres -c "UPDATE pg_database SET datistemplate='true' WHERE datname='postgis_template';"
psql -d postgres -c "UPDATE pg_database SET datallowconn='false' WHERE datname='postgis_template';"
