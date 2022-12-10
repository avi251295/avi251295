--Compare delta7 confirmed cases with respect to vaccination

select
state,date,delta7_confirmed,
delta7_vaccinated1,delta7_vaccinated2
from time_series;