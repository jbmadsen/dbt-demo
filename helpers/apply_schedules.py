# Imports
import os # comes with python
import yaml # pip install pyyaml
import pyMSSQLJob
import pyodbc

# Variables 
schedules = []
jobs = []
sql = []

# Where to look for YML (assuming we start in ./dbt-demo/ folder for python execution)
rootdir = './src/'

print("Loading schedules")
# Loop through all folders
for subdir, dirs, files in os.walk(rootdir):
    # Foreach file
    for file in files:
        # If that file is a YML file
        if file.endswith('.yml'):
            # Open it
            with open(os.path.join(subdir, file)) as f:
                # Read it
                docs = yaml.load_all(f, Loader=yaml.FullLoader)
                # Foreach block in the YML
                for doc in docs:
                    # Get the key/value pair
                    for k, v in doc.items():
                        # If the key is schedules
                        if k == 'schedules':
                            # Add it to the lidt
                            schedules.append(v)

# flatten nested list [[{},{}],..] to only list [{},{},...]
all_schedules = [item for sublist in schedules for item in sublist]

print("Converting schedules to jobs")
# Create schedules from YML
for schedule in all_schedules:
    model = pyMSSQLJob.Job.fromModel(schedule)
    jobs.append(model)
    print(model)

print("Connecting to SQL Server")
# Connect to SQL Server
connection = pyodbc.connect(#'Driver={SQL Server};'
                            'Driver={ODBC Driver 17 for SQL Server};'
                            'Server=172.23.0.2;'
                            #'Server=127.0.0.1;'
                            'Database=Common;'
                            'UID=sa;'
                            'PWD=Secure1337Password;')
# Create cursor object to interact with database
# (connection only serves the connection, not the interaction)
cursor = connection.cursor()

print("Converting jobs to SQL models")
# Convert Job to SQL and execute against SQL Server
for job in jobs:
    job_converter = pyMSSQLJob.JobToSQLConverter()
    sql_job = job_converter.job_to_sql(job)
    print(f"Sending SQL model for {job.name} to SQL Server")
    count = cursor.execute(f"""{sql_job}""")
    connection.commit()

# Close connection 
try:
    if connection is not None:
        connection.close()
        del connection
except NameError:
    connection = None
print("Closed connnection. Done!")
