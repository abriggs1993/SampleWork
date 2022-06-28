--It may be useful to see if there is a similarity in top films for the top years
--Let's first get a list of films, their release year, and average rating
SELECT YEAR(release_date) AS year_released,  --column for year released                      
	title, --column for title
	ROUND(AVG(vote_average),2) AS avg_rating --column for average rating
FROM Movies
GROUP BY YEAR(release_date), title
ORDER BY year_released;

--now lets filter this table using the top ten years from the previous table we found

SELECT YEAR(release_date) AS year_released,
	title,
	ROUND(AVG(vote_average),2) AS avg_rating
FROM Movies
WHERE YEAR(release_date) BETWEEN 1993 AND 1995 OR YEAR(release_date) BETWEEN 1997 AND 2000 OR YEAR(release_date) BETWEEN 2020 AND 2021 --filter using the top to years found in previous query
GROUP BY YEAR(release_date), title
ORDER BY year_released, avg_rating DESC;

--This is still too much information. It would be most helpful to see the top three movies from each of the top ten years
WITH cte AS  --create the cte
 (SELECT YEAR(release_date) AS year_released,
	title,
	ROUND(AVG(vote_average),2) AS avg_rating
FROM Movies
WHERE YEAR(release_date) BETWEEN 1993 AND 1995 OR YEAR(release_date) BETWEEN 1997 AND 2000 OR YEAR(release_date) BETWEEN 2020 AND 2021
GROUP BY YEAR(release_date), title),
	
 topthree AS  --create another cte to get a ranking for each movie's ranking per year
	(SELECT *, ROW_NUMBER() --select all rows from cte and include a ranking
	over(PARTITION BY year_released --breakdown the rankings by year
	ORDER BY year_released, avg_rating DESC) AS ranking --orderby year and then by avg rating
	FROM cte )

SELECT * FROM topthree WHERE ranking <=3;  --select just the top three rankings per year
