-- Process Phase --

-- Identify null values --

SELECT *
FROM `cyclistic-bike-share-450921.Cyclist_data.cyclist_data_consolidated` 
WHERE 
ride_id IS NULL
OR rideable_type IS NULL 
OR start_station_name IS NULL 
OR start_station_id IS NULL 
OR end_station_name IS NULL
OR end_station_id IS NULL
OR member_casual IS NULL;

-- Delete null values --

DELETE
FROM `cyclistic-bike-share-450921.Cyclist_data.cyclist_data_consolidated` 
WHERE 
ride_id IS NULL
OR rideable_type IS NULL 
OR start_station_name IS NULL 
OR start_station_id IS NULL 
OR end_station_name IS NULL
OR end_station_id IS NULL
OR member_casual IS NULL;

-- Identify blank values --

SELECT *
FROM `cyclistic-bike-share-450921.Cyclist_data.cyclist_data_consolidated` 
WHERE 
ride_id = ''
OR rideable_type = '' 
OR start_station_name = '' 
OR start_station_id = ''
OR end_station_name = ''
OR end_station_id = ''
OR member_casual = '';

-- Identify duplicates --

SELECT *,
COUNT(*)
FROM `cyclistic-bike-share-450921.Cyclist_data.cyclist_data_consolidated`
GROUP BY 
ride_id, 
rideable_type, 
start_station_name, 
start_station_id, 
end_station_name,
end_station_id,
member_casual
having count(*) > 1

-- Remove duplicates --

SELECT 
  DISTINCT ride_id, rideable_type, start_station_name, start_station_id, end_station_name,end_station_id,member_casual
FROM `cyclistic-bike-share-450921.Cyclist_data.cyclist_data_consolidated`;

