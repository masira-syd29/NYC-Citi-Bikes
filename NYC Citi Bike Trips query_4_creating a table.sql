CREATE OR REPLACE TABLE `sql-proj1-485910.my_nyc_citi_bike_dataset.citibike_optimized`
PARTITION BY DATE(starttime)
CLUSTER BY start_station_name
AS
SELECT * FROM `bigquery-public-data.new_york.citibike_trips`
WHERE starttime >= '2022-01-01';