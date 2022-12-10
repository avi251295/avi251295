--- Let’s call `testing ratio(tr) = (number of tests done) / (population)`, 
--now categorise every district in one of the following categories:
--- Category A: 0.05 ≤ tr ≤ 0.1
--- Category B: 0.1 < tr ≤ 0.3
--- Category C: 0.3 < tr ≤ 0.5
--- Category D: 0.5 < tr ≤ 0.75
--- Category E: 0.75 < tr ≤ 1.0
--Now perform an analysis of number of deaths across all category.
--Example, what was the number / % of deaths in Category A district as compared for Category E districts


with cte as (select *, case when Testing_ratio Between 0.05 and 0.1 Then 'Category A'
			   when Testing_ratio Between 0.1 and 0.3 then 'category B'
			   when Testing_ratio Between 0.3 and 0.5 then 'category C'
			   when Testing_ratio Between 0.5 and 0.75 then 'category D'
			   when Testing_ratio Between 0.75 and 1.0 then 'category E' END as Category
from
(select *, (cast(total_tested as decimal(10,2))/ cast(meta_population as decimal(10,2))) as Testing_ratio 
from 
(select State, District, total_tested,total_deceased,meta_population
from district_tablet
where meta_population != 0 and total_tested != 0) as abc) as def)

select * from cte
PIVOT
(max([total_deceased])
For [Category] in ([Category A],[Category B], [Category C], [Category D], [Category E])) as d