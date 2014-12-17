--SITING WANG
--LAB6
--10/23/14


--Q1
select distinct c.name, c.city
from Customers c
inner join Orders c
on o.cid=c.cid
inner join Products p
on o.pid= p.pid
where c.city in(select p.city
		from Products
		group by p.city
		order by count(*)
		limit 2)

--Q2
select distinct c.name, c.city
from Customers c
INNER JOIN Orders o
on o.cid = c.cid
INNER JOIN Products p
on o.pid = p.pid
where c.city in (select products.city
		       from products
                 group by city 
                 having COUNT(*) = (select COUNT(*)
			                     from products
			                     group by city 
			                     order by COUNT(*) DESC 
limit 1))

--Q3
select*
from products
where priceUSD > (select avg(priceUSD)
                   from products)
order by pid ASC;
                 
--Q4
select c.name, o.pid, o.dollars
from customers c,
     orders o
where c.cid = o.cid
order by o.dollars asc; 

--Q5
select c.name, coalesce(o.dollars, 0)
from customers,
full outer join orderson c.cid=o.cid
order by c.name;

--Q6
select distinct c.name, p.name, a.name
from customers c,
     products p,
     agents a,
     orders o
where c.cid = o.cid
  and a.aid = o.aid
  and p.pid = o.pid
  and a.city = 'New York'
order by c.name asc;

--Q7
select o.*
from orders o, products p, customers c
where o.pid = p.pid
	and o.cid = c.cid
	and (p.priceusd * o.qty) - c.discount != o.dollars;
