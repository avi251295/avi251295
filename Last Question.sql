select state,DateName(month, date) as month_name,DATEPART(month,date) as month_num,SUM(total_confirmed) as no_of_cases
from time_series
group by DATEName(month, date),state,DATEPART(month,date)
order by month_num,no_of_cases desc;

