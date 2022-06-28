--What year had the "best" movies? 
SELECT YEAR(release_date) AS release_year, --column for year
	COUNT(id) AS num_movies, --column for number of movies released that year
	ROUND(AVG(vote_average),2) AS avg_rating --colum for average rating of all movies that year
FROM Movies
GROUP BY YEAR(release_date) --Group by the year
ORDER BY avg_rating DESC; --sort from best average rating to worst average rating

--Movies with few reviews skew results, only includ years with 100 or more
SELECT YEAR(release_date) AS release_year, --column for year
	COUNT(id) AS num_movies, --column for number of movies released that year
	ROUND(AVG(vote_average),2) AS avg_rating --colum for average rating of all movies that year
FROM Movies
GROUP BY YEAR(release_date) --Group by the year
HAVING COUNT(id)>= 100 --filter for movies of 100 or more ratings
ORDER BY avg_rating DESC; --sort from best average rating to worst average rating