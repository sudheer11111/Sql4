# Write your MySQL query statement below

with seniors as 
(
select employee_id,
70000 - rolling_sum as budget_left
from
(select *,
sum(salary) over(order by salary asc) as rolling_sum
from Candidates
where experience = 'Senior') a
where rolling_sum <= 70000
),

juniors as 
(
select a.employee_id
from
(select *,
sum(salary) over(order by salary asc) as rolling_sum
from Candidates
where experience = 'Junior') a
where rolling_sum <= (select coalesce(min(budget_left), 70000) from seniors)
)

select 'Senior' as experience,
coalesce(count(employee_id), 0) as accepted_candidates
from seniors
union all
select 'Junior' as experience,
coalesce(count(employee_id), 0) as accepted_candidates
from juniors