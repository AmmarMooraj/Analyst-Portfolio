--check connection between loan deafualt and various factors

select *
from [Credit Project]..credit_risk*/


select loan_status, loan_grade, cb_person_default_on_file, loan_percent_income
from [Credit Project]..credit_risk
order by 1,2*/

select loan_status, loan_grade, cb_person_default_on_file, loan_percent_income
from [Credit Project]..credit_risk
where loan_status = 1
order by 1,2

select AVG(loan_percent_income) as mean
from credit_risk
where loan_status=1;

select MAX(loan_percent_income)
from credit_risk
--max loan_percent_income in set is 83

SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY loan_percent_income) over() AS median_value
FROM 
    credit_risk;
---median loan_percent_income is 0.15
SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY loan_int_rate) over() AS median_value
FROM 
    credit_risk;
--median loan rate is 10.6

select
	count(case when loan_int_rate >= 10.6 then 1 end) as total,
	count(case when loan_int_rate >= 10.6 and loan_status = 1 then 1 end) as defaulted,
	cast(count(case when loan_int_rate >= 10.6 and loan_status = 1 then 1 end) as float)/
	cast(count(case when loan_int_rate >= 10.6 then 1 end) as float) as proportion
from credit_risk;
--30% of loans with an interest rate above 10.6% defaulted
select
	count(case when loan_int_rate < 10.6 then 1 end) as total,
	count(case when loan_int_rate < 10.6 and loan_status = 1 then 1 end) as defaulted,
	cast(count(case when loan_int_rate < 10.6 and loan_status = 1 then 1 end) as float)/
	cast(count(case when loan_int_rate < 10.6 then 1 end) as float) as proportion
from credit_risk;
--13% of loans with an interest rate below 10.6%

select
	count (case when loan_percent_income >= 0.15 then 1 end) as total,
	count (case when loan_percent_income >= 0.15 and loan_status = 1 then 1 end) as defaulted,
	cast(count (case when loan_percent_income >= 0.15 and loan_status = 1 then 1 end) as float)
	/cast(count(case when loan_percent_income >= 0.15 then 1 end) as float) as proportion
from credit_risk;
--31% of loans that accounted for more than 15% of income were defaulted on
select
	count (case when loan_percent_income < 0.15 then 1 end) as total,
	count (case when loan_percent_income < 0.15 and loan_status = 1 then 1 end) as defaulted,
	cast(count (case when loan_percent_income < 0.15 and loan_status = 1 then 1 end) as float)
	/cast(count(case when loan_percent_income < 0.15 then 1 end) as float) as proportion
from credit_risk;
--12% of loans that account for less that 15% were defaulted on

select count(*)
from credit_risk
where loan_status = 1 and loan_percent_income >= 0.5




select count(*)
from [Credit Project]..credit_risk
where loan_status = 1 and loan_grade = 'A';

select count(*)
from [Credit Project]..credit_risk
where loan_status = 0 and loan_grade = 'A';

similar proportion of grade A loans are defaulted on as not

select count(*)
from [Credit Project]..credit_risk

select count(*)
from [Credit Project]..credit_risk
where loan_grade = 'A';


select *
from credit_risk
where loan_status = 1 and loan_grade = 'A';


select count(*)
from credit_risk
where loan_status = 0 and loan_grade != 'A';

select count(*)
from  credit_risk
where loan_status = 1 and loan_grade != 'A';

--there is not a large difference between loan grades and default numbers

select count(*)
from credit_risk
where loan_status = 1 and cb_person_default_on_file = 1

select count(*)
from credit_risk
where loan_status = 1 and cb_person_default_on_file = 1 and cb_person_cred_hist_length >= 3
-- repeat defaulters usually have more than 3 years of credit history

select count(*)
from credit_risk
where loan_status = 1 and cb_person_default_on_file = 0
--most defaulters have not defaulted previously

select count(*)
from credit_risk
where loan_status = 1 and cb_person_default_on_file = 0 and cb_person_cred_hist_length <=3 and cb_person_cred_hist_length != 1
--Most first time defaulters default in year 2 or 3

alter table credit_risk
ADD loan_gp int NULL;


update credit_risk
set loan_gp = 0
where loan_grade = 'G';

update credit_risk
set loan_gp = 1
where loan_grade = 'F';

update credit_risk
set loan_gp = 2
where loan_grade = 'E';

update credit_risk
set loan_gp = 3
where loan_grade = 'D';

update credit_risk
set loan_gp = 4
where loan_grade = 'C';

update credit_risk
set loan_gp = 5
where loan_grade = 'B';

update credit_risk
set loan_gp = 6
where loan_grade = 'A';

--created a loan gradepoint so i can take averages

select loan_gp, loan_grade
from credit_risk
order by 1, 2

select AVG(loan_gp) AS mean
from credit_risk
where loan_status = 1;

--mean loan grade is 3 or D

SELECT TOP 1 loan_gp AS mode
FROM   credit_risk
where loan_status = 1
GROUP  BY loan_gp
ORDER  BY COUNT(*) DESC

--mode loan grade is 3 or D

---collecting data for visualization

select loan_grade, loan_gp, loan_status
from credit_risk
order by 1;

select person_age
from credit_risk
where loan_status = 1;

select *
from credit_risk

select count(*)
from credit_risk
where loan_grade = 'A'

select distinct loan_intent
from credit_risk;

select loan_intent, count(case when loan_status = 1 then 1 end) as defaults, count(loan_intent) as loans
from credit_risk
group by loan_intent