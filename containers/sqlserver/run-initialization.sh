#!/bin/bash

# Wait to be sure that SQL Server came up
echo "Sleeping"
sleep 90s

# Variables
host = "localhost"
user = "sa"
pass = "Secure1337Password"
db = "master"

# Run the setup script to create the DB and the schema in the DB
# Note: make sure that your password matches what is in the Dockerfile
#/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Secure1337Password -d master -i create-database.sql
echo "Setting up databases"
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/config/create_databases.sql

# Create initial tables
echo "Seeding databases"
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/seed/create_retail_customers_address.sql
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/seed/create_retail_customers.sql
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/seed/create_retail_employees.sql
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/seed/create_retail_orders_lines.sql
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/seed/create_retail_orders.sql
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/seed/create_retail_products.sql
/opt/mssql-tools/bin/sqlcmd -S $host -U $user -P $pass -d $db -i /usr/src/app/sql/seed/create_retail_stores.sql

# Done

