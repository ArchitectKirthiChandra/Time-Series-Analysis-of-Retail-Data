select * from retail_sales;


--Task 2
--A potential investor is looking to invest in the retail business whose dataset you are currently working on.
-----The investor needs to understand which product categories the business is good at. Can you do a historical 
--------analysis of revenue share of each product line to identify product lines that have more revenue share.
select kind_of_business,strftime ('%Y', sales_month) [Year_of_Revenue_Share], 
		max(sales) [Revenue_share]
from retail_sales
GROUP by kind_of_business
order by  Year_of_Revenue_Share desc, max(sales) desc;

--Justification, in the above syntax we will get the kind of bussiness and the year in which it has excelled 
-------------------------------------------------------------------------with the amount of Revenue Share



--Task 3
---One of the product lines the investor is interested in is Women's clothing stores and Men's clothing stores. 
---------The investment firm wants to understand what is the relative size of both the businesses.
select strftime ('%Y', sales_month) [Year],kind_of_business,sum(sales) from retail_sales
where kind_of_business in ("Women's clothing stores","Men's clothing stores")
GROUP by kind_of_business,Year
order by Year DESC, sum(sales) DESC
limit 10;

--Justification,in this answer the investor can see the past 5 Year and then see the highest sales business in mens clothing and womens clothing bussiness






--Task 4
-----Another dimension that the investor is interested in is, finding out which product categories are growing 
-----------since the past 10 years. Can you help them with this task?
select x.Year, x.kind_of_business, x.Max_sales
from (
select strftime ('%Y', sales_month) [Year],
		kind_of_business,sum(sales) [Max_sales], 
		rank() over(PARTITION by strftime ('%Y', sales_month) order by sum(sales) Desc) [Rank]
from retail_sales
GROUP by  Year, kind_of_business
order by Max_sales DESC) x
where x.Rank = 1
order by x.Year DESC
limit 10;



--Justification, given below is the detail of past ten years and the kind of bussiness which has 
-------------------------------------------------highest sales in the past ten years..