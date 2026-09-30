
-- distinct city ratings over 5.0
SELECT DISTINCT city, rating 
FROM uk_housing_market
WHERE rating > 5.0;

-- overall look at table
SELECT *
FROM uk_housing_market;

-- average, max aand min rating of properties in uk housing market
SELECT COUNT(id) AS total_properties,
    ROUND(AVG(rating), 2) AS average_rating,
    MAX(rating) AS highest_rating,
    min(rating) AS lowest_rating
FROM uk_housing_market;


-- city grouping with total properties and avg rating
SELECT city,
    COUNT(id) AS total_properties,
    ROUND(AVG(rating), 2) AS avg_property_rating
FROM uk_housing_market
GROUP BY city;

-- properties in san francisco and san jose
SELECT id,
    city
FROM uk_housing_market
WHERE city in ('San Francisco', 'San Jose');


-- properties in san jose above average rating of san jose properties
WITH avg_property_rating_san_jose AS (
    SELECT ROUND(AVG(rating), 2) AS avg_rating
    FROM uk_housing_market
    WHERE city = 'San Jose'
    GROUP BY city
)
SELECT *
FROM uk_housing_market
WHERE city = 'San Jose'
AND rating > (SELECT avg_rating FROM avg_property_rating_san_jose);



--categorizing properties based on their rating 
SELECT id, 
    name,
    rating,
    city,
    CASE 
        WHEN rating >= 8 THEN 'Excellent'
        WHEN rating >= 6 THEN 'Good'
        WHEN rating >= 4 THEN 'Okay'
        ELSE 'Poor'
    END AS rating_category
FROM uk_housing_market;



-- city and properties categorized by average property rating in each teir of rating category
SELECT
    summary.city,
    summary.rating_category,
    ROUND(AVG(summary.number_of_properties), 2) AS average_overall_properties
FROM (
    SELECT
        COUNT(propertie_rating_categorie.rating_category) AS number_of_properties, 
        city, 
        ROUND(AVG(rating), 2) AS average_rating, rating_category 
        FROM (
            SELECT DISTINCT city,
                rating,
                CASE 
                    WHEN rating >= 8 THEN 'Excellent'
                    WHEN rating >= 6 THEN 'Good'
                    WHEN rating >= 4 THEN 'Okay'
                    ELSE 'Poor'
                END AS rating_category
            FROM uk_housing_market
        ) AS propertie_rating_categorie
        GROUP BY city, propertie_rating_categorie.rating_category
    ) AS summary
    GROUP BY summary.city, summary.rating_category  
    ORDER BY summary.city ASC;

-- cities with number of properties organised from Max in DESC order 
SELECT MAX(city),
COUNT(city) AS total_cities
FROM uk_housing_market
GROUP BY city
ORDER BY total_cities DESC;

--names of properties with the word bar in
SELECT *
FROM uk_housing_market
WHERE name LIKE '%bar%';

