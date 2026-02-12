-- Write a query to find the 3 longest bike trips for every day in 2023. Then, tell me how you'd make it faster.
WITH DailyLongest AS (
  SELECT 
    DATE(starttime) as trip_date,
    start_station_name,
    tripduration,
    ROW_NUMBER() OVER(PARTITION BY DATE(starttime) ORDER BY tripduration DESC ) AS trip_rank
  FROM `bigquery-public-data.new_york.citibike_trips`
  WHERE starttime >= '2023-01-01' AND starttime < '2024-01-01'
)
SELECT * FROM DailyLongest
WHERE trip_rank <= 3
ORDER BY trip_date DESC;