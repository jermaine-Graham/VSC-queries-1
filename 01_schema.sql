CREATE TABLE uk_housing_market (
    id INT, 
    name VARCHAR(225),
    rating NUMERIC(3, 1),
    address VARCHAR(255),
    city VARCHAR(100),
    lat_long VARCHAR(100)
);

COPY uk_housing_market FROM 'C:/Data Scientist  course/data_projects/uk_housing_market - uk_housing_market.csv' WITH (FORMAT csv, HEADER true); 


