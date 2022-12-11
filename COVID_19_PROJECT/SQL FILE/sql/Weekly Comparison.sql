
--Weekly evolution of number of confirmed cases, recovered cases, deaths, tests.
--For instance, your dashboard should be able to compare Week 3 of May with Week 2 of August 

select state,Year,Month_name,Month_number,Week_number,
SUm(cast(total_confirmed as bigint)) as confirmed,SUM(cast(total_deceased as bigint)) as deceased,
Sum(cast(total_recovered as bigint)) as recovered
,Sum(cast(total_tested as bigint)) as tested,SUM(cast(total_vaccinated1 as bigint)) as V1,SUM(cast(total_vaccinated2 as bigint)) as V2 from 
(select state,total_confirmed,total_deceased,total_recovered,
total_tested, total_vaccinated1, total_vaccinated2, Month(Date) as Month_number,
DATENAME(Month,date) as Month_name,Year(date) as year,
(datediff(day, dateadd(month, datediff(month, 0, date), 0), date) / 7 + 1) as Week_number
from time_series) as abc
group by Week_number,state,Month_number,Month_name,year
order by Month_number,Week_number;


