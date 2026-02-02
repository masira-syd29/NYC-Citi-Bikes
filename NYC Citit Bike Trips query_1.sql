SELECT
  start_station_name,
  start_station_latitude,
  start_station_longitude,
  ST_GEOGPOINT(start_station_longitude, start_station_latitude) AS geo_location,
  COUNT(*) AS num_trips
FROM
  `bigquery-public-data.new_york.citibike_trips`
GROUP BY
  1,
  2,
  3
ORDER BY
  num_trips DESC
LIMIT
  100;