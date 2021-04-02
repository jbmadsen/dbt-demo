# Imports
import os # comes with python
import yaml # pip install pyyaml


class JobSchedule:
    """
    Model representing a Job Schedule
    """

    def __init__(self, name, schedule):
        self.error = None
        self.name = name + "_schedule"
        self.schedule = schedule 
        self.parseSchedule(schedule)


    def parseSchedule(self, schedule):
        freq_type_map = {
            "Unused": 0, "Once": 1, "Daily": 4, "Weekly": 8, 
            "Monthly": 16, "MonthlyRelative": 32, "Startup": 64, "Idle": 128
        }
        freq_subday_type_map = { 
            "AtTime": 0x1, "Seconds": 0x2, "Minutes": 0x4, "Hours": 0x8
        }
        freq_relative_interval_map = {
            "First": 1, "Second": 2, "Third": 4, "Fourth": 8, "Last": 16
        }

        try:
            self.frequency_type_key = schedule.setdefault('frequency_type', None)
            self.frequency_type = freq_type_map.setdefault(self.frequency_type_key, None)

            self.frequency_interval_key = schedule.setdefault('frequency_interval', None)
            self.frequency_interval = self.parseFrequencyInterval(self.frequency_type_key, self.frequency_interval_key, schedule)

            self.frequency_subday_type_key = schedule.setdefault('frequency_subday_type', None)
            self.frequency_subday_type = freq_subday_type_map.setdefault(self.frequency_subday_type_key, None)

            self.frequency_subday_interval = schedule.setdefault('frequency_subday_interval', None)

            self.frequency_relative_interval_key = schedule.setdefault('frequency_relative_interval', None)
            self.frequency_relative_interval = freq_relative_interval_map.setdefault(self.frequency_relative_interval_key, None)

            self.frequency_recurrence_factor = schedule.setdefault('frequency_recurrence_factor', None)

            self.active_start_date = schedule.setdefault('active_start_date', None)
            self.active_end_date = schedule.setdefault('active_end_date', None)

            self.active_start_time = schedule.setdefault('active_start_time', None)
            self.active_end_time = schedule.setdefault('active_end_time', None)
        except Exception as e:
            self.error = f"Error in schedule {self.name}: {str(e)}"
            print(self.error)
            return
        finally:
            return

    def parseFrequencyInterval(self, frequency_type_key, frequency_interval_key, schedule):
        # Fail fast if not in dict
        if frequency_interval_key is None:
            return None

        if frequency_type_key == 'Daily' and type(frequency_interval_key) == int:
            return frequency_interval_key

        # If frequency_interval is present in Schedule and parsable, we further parse and return it
        if '|' not in frequency_interval_key:
            return self.parseSingleFrequencyInterval(frequency_type_key, frequency_interval_key)
        else:
            # Special cases: This needs special parsing to handle: "Monday|Tuesday|Wednesday"
            intervals = frequency_interval_key.split('|')
            result = 0
            for _, item in enumerate(intervals):
                interval = self.parseSingleFrequencyInterval(frequency_type_key, item)
                result = result + interval
            return result

    def parseSingleFrequencyInterval(self, frequency_type_key, single_frequency_interval_key):
        # Mappings for individual frequency interval
        freq_interval_weekly_map = {
            "Sunday": 1, "Monday": 2, "Tuesday": 4, "Wednesday": 8,
            "Thursday": 16, "Friday": 32, "Saturday": 64 
        }
        freq_interval_monthly_map = {
            "Sunday": 1, "Monday": 2, "Tuesday": 3, "Wednesday": 4, 
            "Thursday": 5, "Friday": 6, "Saturday": 7, "Day": 8, 
            "Weekday": 9, "Weekend": 10
        }
        # Special case for frequency_interval, as it has different mappings for weekly/montly, and a third for remaining
        result = None
        if frequency_type_key == 'Daily':
            return single_frequency_interval_key # Integer in this case
        elif frequency_type_key == 'Weekly':
            result = freq_interval_weekly_map.setdefault(single_frequency_interval_key, None)
        elif frequency_type_key == 'Monthly':
            result = freq_interval_monthly_map.setdefault(single_frequency_interval_key, None)
        return result

    def __repr__(self):
        return f"<JobSchedule name:{self.name} schedule:{self.schedule}>"

    def __str__(self):
        return f"""
        JobSchedule:
        name: {self.name}
        frequency_type: {self.frequency_type} -- {self.frequency_type_key}
        frequency_interval: {self.frequency_interval} -- {self.frequency_interval_key}
        frequency_subday_type: {self.frequency_subday_type} -- {self.frequency_subday_type_key}
        frequency_subday_interval: {self.frequency_subday_interval}
        frequency_relative_interval: {self.frequency_relative_interval} -- {self.frequency_relative_interval_key}
        frequency_recurrence_factor: {self.frequency_recurrence_factor}
        active_start_date: {self.active_start_date}
        active_end_date: {self.active_end_date}
        active_start_time: {self.active_start_time}
        active_end_time: {self.active_end_time}
        error: {self.error}
        """
        

class JobStep:
    """
    Model representing a single Job Step
    """

    def __init__(self, name, command, error):
        self.name = name
        self.command = command
        if self.command.startswith('dbt'):
            split_command = command.split()
            split_command.extend(["--profiles-dir", "./../profiles", "--target", "prod"])
            result_command = str(split_command).replace("\'", "\"")
            self.command = f"""
EXECUTE sp_execute_external_script 
    @language = N'Python',
    @script = N'
import os

import subprocess

os.chdir("/usr/src/app/git/dbt-demo/src/")

process = subprocess.Popen({result_command}, stdout=subprocess.PIPE)
output, error = process.communicate(timeout=60)
if output is not None:
    output = output.decode("utf-8")
if error is not None:
    error = error.decode("utf-8")

OutputDataSet = InputDataSet', 
    @input_data_1 = N'select 1'
    GO
            """
        self.error = error

    @classmethod
    def fromDictionary(self, step):
        # Check for Job errors or fail fast
        error = JobStep.checkModelErrors(step)
        if error is not None: 
            return JobStep(None, None, error)
        name = step['name']
        command = step['command']
        return JobStep(name, command, error)

    @classmethod
    def checkModelErrors(self, step):
        if 'name' not in step.keys():
            return "Error: JobStep has no name"
        elif 'command' not in step.keys():
            return f"Error: JobStep '{step['name']}' has no command"
        else:
            return None

    def __repr__(self):
        return f"<JobStep name:{self.name} command:{self.command}>"

    def __str__(self):
        return f"JobStep: name is {self.name}, command is: {self.command}"


class Job:
    """
    Model representing a Job, including a schedule to run, as well as a list of steps 
    """
    
    def __init__(self, name, description, schedule, steps, error):
        self.name = name
        self.description = description
        self.schedule = schedule
        self.steps = steps
        self.error = error

    @classmethod
    def fromModel(self, model):
        # Check for Job errors or fail fast
        error = Job.checkModelErrors(model)
        if error is not None: 
            return Job(None, None, None, None, error)
        # Assign model name, description, and schedule
        name = model['name']
        description = model['description']
        # Schedule not required
        schedule = None
        if "schedule" in model.keys():
            schedule = JobSchedule(name, model['schedule'])
            # Check for Schedule errors or fail fast
            error = schedule.error
            if error is not None: 
                return Job(name, description, None, None, error)
        # Assign model steps
        steps = [JobStep.fromDictionary(step) for step in model['steps']]
        # Check for JobSteps errors or fail fast
        error = next(filter(lambda step: step.error is not None, steps), None)
        if error is not None: 
            return Job(name, description, None, None, error)
        # Create and return error-free objects
        return Job(name, description, schedule, steps, error)

    @classmethod
    def checkModelErrors(self, model):
        if 'name' not in model.keys():
            return "Error: Schedule has no name"
        elif 'description' not in model.keys():
            return f"Error: Schedule '{model['name']}' has no description"
        elif 'steps' not in model.keys():
            return f"Error: Schedule '{model['name']}' has no steps"
        else:
            return None

    def __repr__(self):
        return f"<Job name:{self.name} description:{self.description}>"

    def __str__(self):
        return f"Job: name is {self.name}, description is: {self.description}"


class JobToSQLConverter:
    """
    [Summary]
    """

    def create_job_sql(self, job_name, job_description):
        sql_recreate_job_template = f"""
IF NOT EXISTS (select top 1 1 from sysjobs WHERE name = '{job_name}')
BEGIN
EXEC dbo.sp_add_job  
    @job_name = '{job_name}',
    @enabled = 1,
    @description = '{job_description}',
    @category_name = 'dbt_jobs', -- Separate my generated Jobs from others
    @owner_login_name = 'sa'
    ;  
END
ELSE
BEGIN
EXEC dbo.sp_update_job   
    @job_name = '{job_name}',
    @enabled = 1,
    @description = '{job_description}',
    @category_name = 'dbt_jobs', -- Separate my generated Jobs from others
    @owner_login_name = 'sa'
    ;
END
"""
        return sql_recreate_job_template

    def jobsteps_to_sql(self, job_name, steps):
        sql_steps_template = f"""
DECLARE @steps TABLE (STEP_NUMBER int);
INSERT INTO @steps 
SELECT STEP.STEP_ID AS STEP_NUMBER
FROM Msdb.dbo.SysJobs JOB
INNER JOIN Msdb.dbo.SysJobSteps STEP ON STEP.Job_Id = JOB.Job_Id
WHERE JOB.Name = '{job_name}'
ORDER BY STEP_NUMBER;

DECLARE @Id INT;
WHILE EXISTS (SELECT TOP 1 1 From @steps)
BEGIN
    SELECT @Id = MAX(STEP_NUMBER) from @steps;
    EXEC dbo.sp_delete_jobstep  
        @job_name = '{job_name}',  
        @step_id = @Id
        ;
    DELETE FROM @steps WHERE STEP_NUMBER = @Id;
END
"""

        for step in steps:
            stop_or_go = 1 if step == steps[-1] else 3 # 3: Go to next step / 1: Quit with success
            sql_steps_template = sql_steps_template + f"""
EXEC sp_add_jobstep  
    @job_name = '{job_name}',  
    @step_name = '{step.name}',  
    @subsystem = N'TSQL',  
    @command = '{step.command.replace("'", "''")}',     
    @on_success_action = {stop_or_go},
    @retry_attempts = 3,
    @retry_interval = 3
    ;  
"""
        
        return sql_steps_template

    def job_schedule_to_sql(self, job_name, schedule_name, schedule):
        freq_type = f'@freq_type = {schedule.frequency_type}, -- {schedule.frequency_type_key}'
        freq_interval = f'@freq_interval = {schedule.frequency_interval}, -- {schedule.frequency_interval_key}' if schedule.frequency_interval is not None else ''
        freq_subday_type = f'@freq_subday_type = {schedule.frequency_subday_type}, -- {schedule.frequency_subday_type_key}' if schedule.frequency_subday_type is not None else ''
        freq_subday_interval = f'@freq_subday_interval = {schedule.frequency_subday_interval},' if schedule.frequency_subday_interval is not None else ''
        freq_relative_interval = f'@freq_relative_interval = {schedule.frequency_relative_interval}, -- {schedule.frequency_relative_interval_key}' if schedule.frequency_relative_interval is not None else ''
        freq_recurrence_factor = f'@freq_recurrence_factor = {schedule.frequency_recurrence_factor},' if schedule.frequency_recurrence_factor is not None else ''
        active_start_date = f'@active_start_date = {schedule.active_start_date},' if schedule.active_start_date is not None else ''
        active_end_date = f'@active_end_date = {schedule.active_end_date},' if schedule.active_end_date is not None else ''
        active_end_time = f'@active_end_time = {schedule.active_end_time},' if schedule.active_end_time is not None else ''
        active_start_time = f'@active_start_time = {schedule.active_start_time}'
        
        sql_job_schedule_template = f"""
IF NOT EXISTS ( SELECT TOP 1 1 
                FROM sysjobschedules js 
                INNER JOIN sysjobs j on js.job_id = j.job_id
                INNER JOIN sysschedules s on js.schedule_id = s.schedule_id
                WHERE j.name = '{job_name}' AND s.name = '{schedule_name}' )
BEGIN
EXEC sp_add_jobschedule  
    @job_name = '{job_name}',
    @name = '{schedule_name}',  
    @enabled = 1,
    {freq_type}
    {freq_interval}
    {freq_subday_type}
    {freq_subday_interval}
    {freq_relative_interval}
    {freq_recurrence_factor}
    {active_start_date}
    {active_end_date}
    {active_end_time}
    {active_start_time}
    ;  
END
ELSE 
BEGIN
EXEC sp_update_jobschedule 
    @job_name = '{job_name}',
    @name = '{schedule_name}',  
    @enabled = 1,
    {freq_type}
    {freq_interval}
    {freq_subday_type}
    {freq_subday_interval}
    {freq_relative_interval}
    {freq_recurrence_factor}
    {active_start_date}
    {active_end_date}
    {active_end_time}
    {active_start_time}
    ;  
END
"""
        return sql_job_schedule_template

    def job_to_sql(self, job):
        # Error handling: Setup SQL to insert into an error table if errors in model
        if job.error is not None:
            sql_error_response = f"""
            INSERT INTO Common.dbo.dbtCreateJobsErrors
            VALUES ({job.name}, {job.error}, GETDATE());
            GO
            """
            return sql_error_response

        sql_create_category_if_not_exists_template = f"""
IF NOT EXISTS (select top 1 1 from syscategories WHERE name = 'dbt_jobs')
BEGIN
    EXEC dbo.sp_add_category  
        @class=N'JOB',  
        @type=N'LOCAL',  
        @name=N'dbt_jobs' 
    ;
END
"""

        sql_create_job_template = self.create_job_sql(job.name, job.description)
        sql_steps_template = self.jobsteps_to_sql(job.name, job.steps)
        sql_job_schedule_template = self.job_schedule_to_sql(job.name, job.schedule.name, job.schedule) if job.schedule is not None else ""

        sql_final_job_template = f"""
USE Common;

IF (NOT EXISTS (SELECT * 
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_SCHEMA = 'dbo' 
                AND  TABLE_NAME = 'dbtCreateJobsErrors'))
BEGIN
CREATE TABLE Common.dbo.dbtCreateJobsErrors (         
    JobName VARCHAR(100) NOT NULL,
    ErrorNumber INT NOT NULL,
    ErrorServerity INT NOT NULL,
    ErrorState INT NOT NULL,
    ErrorProcedure NVARCHAR(200) NOT NULL,
    ErrorLINE INT NOT NULL,
    ErrorMessage NVARCHAR(1000) NOT NULL,
    CreatedAt DATETIME NOT NULL
)
END

USE msdb;

DECLARE @errors TABLE (
    JobName VARCHAR(100),
    ErrorNumber INT,
    ErrorServerity INT,
    ErrorState INT,
    ErrorProcedure NVARCHAR(200),
    ErrorLINE INT,
    ErrorMessage NVARCHAR(1000),
    CreatedAt DATETIME
)

BEGIN TRY

BEGIN TRANSACTION CreateJob;

{sql_create_category_if_not_exists_template}
{sql_create_job_template}
{sql_steps_template}
{sql_job_schedule_template}

EXEC dbo.sp_add_jobserver
    @job_name = '{job.name}',
    @server_name = N'(LOCAL)'

END TRY
BEGIN CATCH

INSERT INTO @errors 
SELECT   
    '{job.name}',
    ERROR_NUMBER(),
    ERROR_SEVERITY(),
    ERROR_STATE(),
    ERROR_PROCEDURE(),
    ERROR_LINE(),
    ERROR_MESSAGE(),
    GETDATE()
;

IF @@TRANCOUNT > 0  
    ROLLBACK TRANSACTION CreateJob;  

END CATCH

IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION CreateJob;  

INSERT INTO Common.dbo.dbtCreateJobsErrors SELECT * FROM @errors;

"""
        
        return sql_final_job_template