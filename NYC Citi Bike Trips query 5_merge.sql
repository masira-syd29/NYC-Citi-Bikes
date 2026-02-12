CREATE OR REPLACE TEMP TABLE station_updates AS 
SELECT '8 AVE & W 31st' as station_name, '8th Ave & West 31st St' as corrected_name;

MERGE `sql-proj1-485910.my_nyc_citi_bike_dataset.citibike_optimized` T
USING station_updates S 
ON T.start_station_name = S.station_name
WHEN MATCHED THEN 
  UPDATE SET start_station_name = S.corrected_namee;