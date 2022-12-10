--INSIGHT 1
select state,DATENAME(month,date) as Date,YEAR(date) as year,SUM(total_deceased) as 'month_deceased_data',
SUM(cast(total_confirmed as bigint)) as 'month_confirmed_data' 
from time_series
group by state,DATENAME(month,date),YEAR(date) ;


--INSIGHT 2
select state, total_tested, (total_vaccinated1+total_vaccinated2) as total_vaccinated from state;





