sp_configure 'external scripts enabled', 1;
RECONFIGURE WITH OVERRIDE; 
GO

-- this turns on advanced options and is needed to configure xp_cmdshell
exec sp_configure 'show advanced options', '1';
RECONFIGURE WITH OVERRIDE; 
GO

-- this enables xp_cmdshell
exec sp_configure 'xp_cmdshell', '1';
RECONFIGURE WITH OVERRIDE; 
GO
