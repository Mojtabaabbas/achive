use Netflix
--1) Count the number of Movies vs TV Shows
--2) Find the most common rating for movies and TV shows
--3) List all movies released in a specific year (e.g., 2020)
--4. Find the top 5 countries with the most content on Netflix
--5. Identify the longest movie
--6. Find content added in the last 5 years
--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
--8. List all TV shows with more than 5 seasons
--9. Count the number of content items in each genre
--10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!

SELECT type, rating
FROM
(
    SELECT type, rating, COUNT(*) AS count_rating,
           RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix_titles
    GROUP BY type, rating
) AS t3
WHERE ranking = 1;









select date_added from netflix_titles
where type='movie'








--1) Count the number of Movies vs TV Shows

select type, count(*)'Count the number' from netflix_titles
group by type






--2) Find the most common rating for movies and TV shows
SELECT type, rating
FROM
(
    SELECT type, rating, COUNT(*) AS count_rating,
           RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix_titles
    GROUP BY type, rating
) AS t3
WHERE ranking = 1;








--3) List all movies released in a specific year (e.g., 2020)
select release_year from netflix_titles
where  release_year=2020









--4. Find the top 5 countries with the most content on Netflix
select country, count(*) from netflix_titles
group by country
order by count(*) desc







--5. Identify the longest movie
select * from netflix_titles
where type='movie' and duration=(select max(duration) from netflix_titles)






--6. Find content added in the last 5 years
SELECT date_added
FROM netflix_titles
WHERE TRY_CONVERT(DATE, date_added, 101) >= DATEADD(YEAR, -5, GETDATE());








--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select type, director from netflix_titles
where director like'Rajiv Chilaka%'








select country from netflix_titles
cross  STRING_SPLIT(country, ',') as new_country










select listed_in from netflix_titles
where type='TV Show'



--8. List all TV shows with more than 5 seasons
select *
from netflix_titles
where type='TV Show' and LEFT(duration, charindex(' ', duration) -1) > 5











--9. Count the number of content items in each genre

select value, count(show_id)
from netflix_titles

cross apply STRING_SPLIT(listed_in, ',')

group by value
order by value

--select listed_in, show_id, value
--from netflix_titles
--cross apply STRING_SPLIT(listed_in, ',')
--order by value





--10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!


SELECT 
    YEAR(TRY_CONVERT(DATE, date_added, 101)) AS year_added, 
    COUNT(*) AS total_per_year,
    ROUND(CAST(COUNT() AS numeric) / CAST((SELECT COUNT() FROM netflix_titles WHERE country = 'India') AS numeric) * 100, 2) AS avg_content_per_year
FROM netflix_titles
WHERE country = 'India'
GROUP BY YEAR(TRY_CONVERT(DATE, date_added, 101))





 







--2019 --> 15.00
--2020 --> 12.00















--11. List all movies that are documentaries
select show_id, value from netflix_titles
cross apply string_split(listed_in,',')
where value='documentaries'


select * from netflix_titles
where listed_in like '%documentaries'



--12. Find all content without a 

select * FROM netflix_titles
where director  is null



select value, count(*) from netflix_titles
cross apply string_split(cast, ',')
where value like 'Salman Khan%'
group by value

