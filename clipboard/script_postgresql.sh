#!/bin/sh

psql -U postgres -c "ALTER USER postgres WITH PASSWORD '123456'" -d template1
psql -U postgres -c "CREATE DATABASE testdb ENCODING 'LATIN1' LC_COLLATE 'C' LC_CTYPE 'C' template template0;"
psql -U postgres -c "CREATE LANGUAGE plpgsql;"
psql -U postgres -c "CREATE ROLE testdb LOGIN SUPERUSER INHERIT CREATEDB CREATEROLE;"
psql -U postgres -c "CREATE ROLE gas LOGIN ENCRYPTED PASSWORD 'gas' SUPERUSER INHERIT CREATEDB CREATEROLE;"
psql -U postgres testdb < /tmp/dump_testdb_postgresql.sql