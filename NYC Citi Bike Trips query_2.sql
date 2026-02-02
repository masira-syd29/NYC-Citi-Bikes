WITH DailyTrips AS(
  SELECT 
    start_station_name,
    DATE(starttime) as trip_date,
    COUNT(*) as num_trips
  FROM `bigquery-public-data.new_york.citibike_trips`
  WHERE starttime >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
  GROUP BY 1, 2
),
Rankedtrips AS(
  SELECT *,
  LAG(num_trips) OVER (PARTITION BY start_station_name ORDER BY trip_date) AS prev_day_trips,
  RANK() OVER (PARTITION BY trip_date ORDER BY num_trips DESC) as daily_rank
  FROM DailyTrips
)
SELECT * from Rankedtrips
WHERE daily_rank <= 5
ORDER BY trip_date DESC, daily_rank ASC;
