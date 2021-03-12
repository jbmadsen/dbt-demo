use Import;

drop table if exists dbo.retail_crm_employees;
with vals as (
	select 1 as employees_id, 1 as workplace_id, 'Mark' as first_name, 'Sharon' as last_name, '1999-01-01' as birthdate, 'M' as gender, '2020-02-05' as hired_date, 'Sales Rep' as title, 10500 as salary, GETDATE() as dwh_loaded_at
    union all 
	select 2 as employees_id, 1 as workplace_id, 'Sandra' as first_name, 'Edwards' as last_name, '1995-02-16' as birthdate, 'F' as gender, '2019-02-05' as hired_date, 'Manager' as title, 14000 as salary, GETDATE() as dwh_loaded_at
    union all 
	select 3 as employees_id, 3 as workplace_id, 'Ashley' as first_name, 'Frank' as last_name, '1980-12-08' as birthdate, 'F' as gender, '2018-02-05' as hired_date, 'Sales Rep' as title, 11000 as salary, GETDATE() as dwh_loaded_at
    union all 
	select 4 as employees_id, 5 as workplace_id, 'Dorothy' as first_name, 'Frank' as last_name, '2001-03-15' as birthdate, 'F' as gender, '2017-02-05' as hired_date, 'Sales Rep' as title, 10000 as salary, GETDATE() as dwh_loaded_at
    union all 
	select 5 as employees_id, 4 as workplace_id, 'Kimberly' as first_name, 'Jose' as last_name, '2005-01-07' as birthdate, 'F' as gender, '2021-02-05' as hired_date, 'Sales Rep' as title, 10000 as salary, GETDATE() as dwh_loaded_at
    union all 
	select 6 as employees_id, 1 as workplace_id, 'Emily' as first_name, 'Peters' as last_name, '2005-05-04' as birthdate, 'F' as gender, '2021-02-05' as hired_date, 'Sales Rep' as title, 10000 as salary, GETDATE() as dwh_loaded_at
)
select *
into dbo.retail_crm_employees
from vals
;