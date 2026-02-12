CREATE OR REPLACE TABLE `sql-proj1-485910.my_nyc_citi_bike_dataset.citibike_silver`
PARTITION BY trip_date
CLUSTER BY start_station_name
AS 
WITH RawData AS (
  SELECT *,
    DATE(starttime) as trip_date,
    COALESCE(start_station_name, CAST(start_station_id AS STRING)) as cleaned_station_name
  FROM `bigquery-public-data.new_york.citibike_trips`
  WHERE starttime >= '2023-01-01' AND starttime < '2023-02-01'   
),
Updates AS (
  SELECT '8 Ave & 31 St' as old_name, '8th Ave & West 31st St' as new_name
),
MergedData AS (
  SELECT 
    r.* EXCEPT(start_station_name),
    COALESCE(u.new_name, r.cleaned_station_name) as start_station_name
  FROM RawData r
  LEFT JOIN Updates u ON r.cleaned_station_name = u.old_name
),
Deduplicated AS (
  SELECT *,
    ROW_NUMBER() OVER(PARTITION BY bikeid,starttime ORDER BY starttime) as rn
  FROM MergedData
)
SELECT * EXCEPT(rn)
FROM Deduplicated
WHERE rn=1;