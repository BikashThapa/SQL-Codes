-- 1.Find out the average weight for each country
select country,avg(weight) from survey group by country order by avg(weight);

-- 2. Create list of the number of respondents from each country.Order the list of respondents. show only those countries where the number of respondents was greater than 3.
select country,count( country) from survey group by country  having count(country) >3 order by count(*);

-- 3. Display the average height for each country. Show the number of respondents for each country and order the list by average height.
select country,count(country),avg(height) from survey group by country order by avg(height) desc;

-- 4. For each country, find the average weught of both men and women in that country, and the number of respondents in each gender- country category.Display only those categories containing more than two respondents.Order the results by country.
select country,gender,count(country),avg(weight) from survey group by country,gender having count(country) >2 order by country;

-- 5.For each of the possible four answers to exercise question,display the average health score of the respondents in that group.Order from poor health to good health.Is there any relationship between reported amount of exercise and reported state of health?If so, Why? 
select exercise,avg(health) from survey group by exercise order by health desc;
