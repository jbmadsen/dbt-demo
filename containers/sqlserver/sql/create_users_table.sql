drop table if exists Source.dbo.Users;
with users as (
	select 1 as [Value], 'User1' as [OtherValue], GETDATE() as Loaded_At
	union all 
	select 2, 'User2', GETDATE() 
	union all 
	select 3, 'User3', GETDATE() 
	union all 
	select 4, 'User4', GETDATE() 
	union all 
	select 5, 'User5', GETDATE() 
	union all 
	select 6, 'User6', GETDATE() 
	union all 
	select 7, 'User7', GETDATE() 
	union all 
	select 8, 'User8', GETDATE() 
	union all 
	select 9, 'User9', GETDATE() 
	union all 
	select 10, 'User10', GETDATE() 
)
select *
into Source.dbo.Users 
from users
;