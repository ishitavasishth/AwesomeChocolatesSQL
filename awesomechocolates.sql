show tables;

select *
from sales;

select SaleDate, Amount, Customers 
from sales;

select Amount, Customers, GeoID 
from sales;

#Calculating Amount Per Box
select SaleDate, Amount, Boxes, round(Amount/Boxes,2) as Amount_Per_Box
from Sales;

#Amount when 10000(Sales Amount)
select *
from sales
where amount > 10000
order by amount desc;

# Filter when geoid when g1 
select *
from sales
where geoid= 'g1'
order by PID, Amount desc;

# Query result when Amount > 10000 and After a specific period
select * 
from sales
where amount > 1000 
and SaleDate >= '2022-01-01';

#For 2022- and Amount > 10000 
select SaleDate, Amount
from sales
where amount > 10000
and
year(SaleDate) = 2022
order by amount desc; 

#When boxes are greater than 0 and less than 50
select *
from sales
where boxes > 0 and
boxes <=50;

#When boxes range from 0 and 50
select *
from sales
where boxes between 0 and 50;


select SaleDate, Amount, Customers, Boxes, weekday(SaleDate) as Day_of_week
from sales
where weekday(SaleDate)= 4;

select *
from people;

# Let's select a Team- where it's Delish or Jucies

select *
from people
where Team = 'Delish' or Team = 'Jucies';

# IN Operator
select *
from people
where team in ('Delish', 'Jucies');

#This for when people names start with B!
select *
from people
where salesperson like 'B%';

select *
from sales;

select SaleDate, Amount,
case when amount < 1000 then 'Under 1k'
when amount < 5000 then 'Under 5k'
when amount < 10000 then 'Under 10k'
else '10k or more' end as Amount_as_Category
from sales;

#Join- Checking Salesperson and SPID!
select p.Salesperson, p.SPID, p.location, month(s.SaleDate)
from sales as s
inner join people as p
using(SPID);

#Join On Product Table
select pr.PID, year(s.SaleDate), s.SPID, pr.Product, s.Amount, p.team
from sales as s
inner join people as p
using(SPID)
left join products as pr
using(PID);

#Multiple join with condition
select pr.PID, year(s.SaleDate), s.SPID, pr.Product, s.Amount, p.team
from sales as s
inner join people as p
using(SPID)
left join products as pr
using(PID)
where s.amount < 500
and (p.team = 'Delish');


select pr.PID, year(s.SaleDate), s.SPID, pr.Product, s.Amount, p.team
from sales as s
inner join people as p
using(SPID)
left join products as pr
using(PID)
where s.amount < 500
and p.team = ' ';

#Join with Geography

select pr.PID, year(s.SaleDate), s.SPID, pr.Product, s.Amount, p.team, g.geo
from sales as s
inner join people as p
using(SPID)
left join products as pr
using(PID)
left join geo as g
using(geoid)
where s.amount < 500
and (p.team = 'Delish')
and g.geo in ('India', 'New Zealand')
order by s.saleDate;

#Group By
select geoID, sum(amount), round(avg(amount),2), sum(boxes)
from sales
group by 1
order by 1;

select *
from sales;
select *
from geo;

#See name of the country with Sales
select g.geo, sum(s.amount) as Total_Amount, avg(s.amount) as Average_Amount
from
sales as s
inner join geo as g
using(GeoID)
group by g.geoID;
select * from products;
select * from sales;
select * from people;
#Total Amount from team+category
select p.team, pr.category, sum(s.amount) as Total_Amount, sum(s.boxes) as Total_Boxes
from sales as s
left join people as p
using(SPID)
left join products as pr
using(PID)
where p.team <> ' '
group by 1,2
order by 2;

#Total Amount by top 10 Products
select * from sales;
select * from products;

select pr.product, sum(s.amount) as Total_Amount
from sales as s
left join products as pr
using(PID)
group by 1
order by Total_Amount desc
limit 10;

