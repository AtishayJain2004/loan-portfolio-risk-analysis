create database BankingAnalytics

use BankingAnalytics
select count(*) from customers

-- checking relationships (Customer to Loans)--

select top 10
c.customer_id,
c.annual_income,
l.loan_amount
from customers c
join loans l
on c.customer_id = l.customer_id

-- Checking relationships (Loans to payments) --

select top 10 
l.loan_id,
l.loan_amount,
p.paid_total
from loans l
join payments p
on l.loan_id = p.loan_id

-- full relationship join --

select top 10
c.customer_id,
c.annual_income,
l.loan_amount,
cp.total_credit_limit,
p. paid_total
from customers c
join loans l
on c.customer_id = l.customer_id
join credit_profile cp
on c.customer_id = cp.customer_id
join payments p
on l.loan_id = p.loan_id

--Loan distribution by purpose--

select loan_purpose, count(*) as total_loans
from loans
group by loan_purpose
order by total_loans desc

-- Average interest rate by grade --

select grade , avg(interest_rate) as avg_rate
from loans
group by grade
order by avg_rate desc

-- Income vs Loan Size --

select
avg(c.annual_income) as avg_income,
avg(l.loan_amount) as avg_loan
from customers c
join loans l
on c.customer_id = l.customer_id

-- Delinquency Risk--

select 
delinq_2y,
count(*) AS borrowers
from credit_profile
group by delinq_2y
order by delinq_2y desc

-- risk by loan grade --
select 
grade,
count(*) as loans,
avg(interest_rate) as avg_interest_rate
from loans
group by grade
order by avg_interest_rate desc

--borrower risk segmentation--

select
	case
		when cp.delinq_2y = 0 then 'No Delinquency' 
		when cp.delinq_2y between 1 and 2 then 'Moderate Delinquency'
		else 'High Risk'
	end as risk_segment,

	count (*) as total_loans,
	avg(l.loan_amount) as avg_loan_amount,
	avg(l.interest_rate) as avg_interest_rate

from dbo.loans l
join dbo.credit_profile cp on l.customer_id = cp.customer_id

group by 
	case 
		when cp.delinq_2y = 0 then 'No Delinquency'
		when cp.delinq_2y between 1 and 2 then 'Moderate Delinquency'
		else 'High Risk'
	end

order by avg_interest_rate desc

-- credit utilization risk ---

select
	cp.customer_id,
	cp.total_credit_limit,
	cp.open_credit_lines,

	(cp.open_credit_lines * 1.0 / cp.total_credit_lines) as credit_lin_ratio
from dbo.credit_profile cp
order by credit_lin_ratio desc

-- Loan Repayment Performance --

Select
	l.loan_id,
	l.loan_amount,
	p.paid_total,
	p.balance,

	(p.paid_total * 100.0/ l.loan_amount) as repayment_percentage

from dbo.loans l
join dbo.payments p
on l.loan_id = p.loan_id

order by repayment_percentage desc

-- Top Borrowers by Total Loan Value --

select top 10
	c.customer_id,
	count(l.loan_id) AS total_loans,
	sum(l.loan_amount) as total_borrowed

from dbo.customers c
join dbo.loans l
on c.customer_id = l.customer_id

group by c.customer_id

order by total_borrowed desc

-- Risk Ranking --

select
	l.loan_id,
	l.grade,
	l.loan_amount,
	l.interest_rate,

	rank() over(
		order by interest_rate desc
	) as risk_rank
from dbo.loans l 

-- State-Wise Lending Risk --
select
	c.state,
	count(l.loan_id) as total_loans,
	avg(l.loan_amount) as avg_loan_amount,
	avg(l.interest_rate) as avg_interest_rate
from dbo.loans l
join dbo.customers c
on l.customer_id = c.customer_id
group by c.state
order by avg_interest_rate desc

-- Loan size vs interest Rate segmentation -- 

select
case 
	when loan_amount < 500 then 'Small Loan'
	when loan_amount between 5000 and 15000 then 'Medium Loan'
	else 'Large Loan'
end as loan_size_segment,

count(*) as total_loans,
avg(interest_rate) as avg_interest_rate

from dbo.loans
group by
case 
	when loan_amount < 500 then 'Small Loan'
	when loan_amount between 5000 and 15000 then 'Medium Loan'
	else 'Large Loan'
end
order by avg_interest_rate desc

-- Loan Portfolio Exposure --

select
loan_id,
loan_amount,
sum(loan_amount) over() as total_portfolio_value,
sum(loan_amount) over( order by loan_amount desc) as cumulative_portfolio_exposure
from dbo.loans
order by loan_amount desc

-- default risk vs interest rate --
select
	cp.delinq_2y,
	count(l.loan_id) as total_loans,
	avg(l.interest_rate) as avg_interest_rate,
	avg(l.loan_amount) as avg_loan_amount
from dbo.loans l
join dbo.credit_profile cp
on l.customer_id = cp.customer_id
group by cp.delinq_2y
order by cp.delinq_2y desc

--Income Segment vs Loan Risk--

select 
case	
	when c.annual_income < 50000 then 'Low Income'
	when c.annual_income between 50000 and 100000 then 'Middle Income'
	else 'High Income'
END AS income_segment,

count(l.loan_id) as total_loans,
avg(l.loan_amount) as avg_loan_amount,
avg(l.interest_rate) as avg_interest_rate

from dbo.loans l
join dbo.customers c
on l.customer_id = c.customer_id

group by
case
	when c.annual_income < 50000 then 'Low Income'
	when c.annual_income between 50000 and 100000 then 'Middle Income'
	else 'High Income'
END
order by avg_interest_rate desc
