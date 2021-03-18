/*
Demo Agent Job from SQL Code
Link: https://docs.microsoft.com/en-us/sql/ssms/agent/create-a-job?view=sql-server-ver15
*/

USE msdb ;  
GO  

DECLARE @name VARCHAR(50) = N'Demo Job';
DECLARE @schedule VARCHAR(50) = N'RunOnce';
DECLARE @step VARCHAR(50) = N'RunOnce';
DECLARE @sqlcmd VARCHAR(50) = N'SELECT 1';

IF NOT EXISTS (select top 1 1 from sysjobs WHERE name = @name)
BEGIN
	EXEC dbo.sp_add_job  
		@job_name = @name ;  

	EXEC sp_add_jobstep  
		@job_name = @name,  
		@step_name = @step,  
		@subsystem = N'TSQL',  
		@command = @sqlcmd,   
		@retry_attempts = 5,  
		@retry_interval = 5 ;  
END;

IF NOT EXISTS (select top 1 1 from sysschedules WHERE name = @schedule)
BEGIN
	EXEC dbo.sp_add_schedule  
		@schedule_name = @schedule,  
		@freq_type = 1,  
		@active_start_time = 233000 ;  
END;

EXEC sp_attach_schedule  
   @job_name = @name,  
   @schedule_name = @schedule;  

GO 

