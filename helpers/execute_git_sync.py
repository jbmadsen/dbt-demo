import pyodbc

print("Connecting to SQL Server")
# Connect to SQL Server
connection = pyodbc.connect(#'Driver={SQL Server};'
                            'Driver={ODBC Driver 17 for SQL Server};' # https://stackoverflow.com/a/57621242
                            'Server=172.23.0.2;'
                            #'Server=127.0.0.1;'
                            'Database=Common;'
                            'UID=sa;'
                            'PWD=Secure1337Password;')
# Create cursor object to interact with database
# (connection only serves the connection, not the interaction)
cursor = connection.cursor()

sql_job = "EXEC msdb.dbo.sp_start_job 'git_sync_job'"

cursor.execute(f"""{sql_job}""")
connection.commit()

# Close connection 
try:
    if connection is not None:
        connection.close()
        del connection
except NameError:
    connection = None
print("Closed connnection. Done!")
