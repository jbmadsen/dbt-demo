drop table if exists Source.dbo.DemoTable ;
with vals as (
	select 1 as [Value], '2' as [OtherValue], GETDATE() as Loaded_At
	union all 
	select 2, '3', GETDATE()
	union all 
	select 3, '4', GETDATE()
	union all 
	select 4, NULL, GETDATE()
	union all 
	select 5, '6', GETDATE() 
)
select *
into Source.dbo.DemoTable
from vals
;