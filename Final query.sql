--It would be most useful to clean my thought process up into one organized code 
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

SELECT * FROM topthree WHERE ranking <=3--select just the top three rankings per year
ORDER BY CASE WHEN year_released = '2021' THEN 1 --order the table by the top ten years in order by avg ranking (found in previous query)
				WHEN year_released = '2019' THEN 2
				WHEN year_released = '1993' THEN 3
				WHEN year_released = '2020' THEN 4
				WHEN year_released = '1997' THEN 5
				WHEN year_released = '1995' THEN 6
				WHEN year_released = '1998' THEN 7
				WHEN year_released = '1999' THEN 8
				WHEN year_released = '1994' THEN 9
				ELSE 10 END;
