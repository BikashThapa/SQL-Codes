use daraz;
--  Find the highest and lowest selling books (that had at least one sale) by quantity during the month of Dec 2019.
(select a.author, b.title,count(book_id) from sales s
join book b
on b.id=s.book_id
join author a on b.author_id = a.id
group by book_id
having count(book_id)=(select max(book) from ( select count(book_id) book from sales group by book_id ) x)
order by a.id,b.publishing_year
)
union
(select a.author, b.title,count(book_id) from sales s
join book b
on b.id=s.book_id
join author a on b.author_id = a.id
group by book_id
having count(book_id)=(select min(book) from ( select count(book_id) book from sales group by book_id ) y)
order by a.id,b.publishing_year
);


-- Find the highest and lowest selling books (that had at least one sale) by revenue during the month of Dec 2019.
(select a.author, b.title,(count(book_id)*s.sales_price) as revenue  from sales s
join book b
on b.id=s.book_id
join author a on b.author_id = a.id
group by book_id
having revenue =(select max(total_revenue) from ( select (count(book_id)*sales_price) as total_revenue from sales group by book_id ) y)
order by a.id,b.publishing_year
) 
union
(select a.author, b.title,(count(book_id)*s.sales_price) as revenue  from sales s
join book b
on b.id=s.book_id
join author a on b.author_id = a.id
group by book_id
having revenue =(select min(total_revenue) from ( select (count(book_id)*sales_price) as total_revenue from sales group by book_id ) y)
order by a.id,b.publishing_year
);


-- . Find the top 3 highest selling authors by quantity from the year with the highest sales revenue, along with these authors’ total sales revenue and sales quantity for that year

(select a.author, b.title,(count(book_id)*s.sales_price) as totaL_revenue , count(book_id) as sales_quantity ,year(sales_date) as sold_year  from sales s
join book b
on b.id=s.book_id
join author a on b.author_id = a.id
group by book_id,year(sales_date)
order by sales_quantity desc limit 3);

--  Find the oldest published book that the bookstore has. If more than one, share the full list.

(select a.author, b.title as book,sales_date from sales s
join book b
on b.id=s.book_id
join author a on b.author_id = a.id
where sales_date =(select min(sales_date) from sales )
group by book_id
);
--  Find the sales price for its most recent sale
(select a.author, b.title as book,sales_price ,sales_date from sales s
join book b
on b.id=s.book_id
join author a on b.author_id = a.id
where sales_date =(select max(sales_date) from sales )
group by book_id
);

--  Find how old would the author be when each book was published

select a.author, b.title ,publishing_year,birth_year,((publishing_year)-birth_year) as age from  book b
join author a on b.author_id = a.id;

-- If we were to have 1 table on sales that would have all the data from all 3 tables combined, how would you go about and write it?

create table new_overall(select a.id as authorid,author,birth_year,b.id as bookid,title,publishing_year,author_id,s.id as salesid, sales_date,book_id,sales_price
from  author a
join book b
on a.id=b.author_id
join sales s 
on s.book_id=b.id);


