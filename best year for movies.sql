--What year had the "best" movies? 
SELECT YEAR(release_date) AS release_year, --column for year
	COUNT(id) AS num_movies, --column for number of movies released that year
	ROUND(AVG(vote_average),2) AS avg_rating --colum for average rating of all movies that year
FROM [Movies].[dbo].[Movies]
GROUP BY YEAR(release_date) --Group by the year
ORDER BY avg_rating DESC; --sort from best average rating to worst average rating

--Years with few movies skew results, only include years with 100 or more movies that have been reviewed
SELECT YEAR(release_date) AS release_year, --column for year
	COUNT(id) AS num_movies, --column for number of movies released that year
	ROUND(AVG(vote_average),2) AS avg_rating --colum for average rating of all movies that year
FROM [Movies].[dbo].[Movies]
GROUP BY YEAR(release_date) --Group by the year
HAVING COUNT(id)>= 100 --filter for years with more than 100 movies
ORDER BY avg_rating DESC; --sort from best average rating to worst average rating

--Let's make it more manageable by looking at the top 10 years
SELECT TOP 10 YEAR(release_date) AS release_year, --limit to top ten results
	COUNT(id) AS num_movies, --column for number of movies released that year
	ROUND(AVG(vote_average),2) AS avg_rating --colum for average rating of all movies that year
FROM [Movies].[dbo].[Movies]
GROUP BY YEAR(release_date) --Group by the year
HAVING COUNT(id)>= 100 --filter for year of 100 or more movies
ORDER BY avg_rating DESC; --sort from best average rating to worst average rating