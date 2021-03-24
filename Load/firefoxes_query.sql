-- checking county table
SELECT
	*
FROM
	counties;
	
	
-- checking fires table
SELECT
	*
FROM
	fires;
	
-- checking droughts table
SELECT
	*
FROM
	droughts;
	
		
-- checking fire_groups table
SELECT
	*
FROM
	fire_groups;
	
-- checking yearly_averages table
SELECT
	*
FROM
	yearly_averages;
	
-- test select
CREATE VIEW fires_drought_join AS (
	SELECT
		droughts.county,
		droughts.none,
		droughts.d0,
		droughts.d1,
		droughts.d2,
		droughts.d3,
		droughts.d4,
		droughts.year,
		fires.fire_year, 
		fires.county_name
	FROM
		droughts
	INNER JOIN fires ON
		fires.county_name=droughts.county
);

SELECT
	*
FROM
	fires_drought_join;

-- grouping by county, year and number of fires
SELECT
	fires_drought_join.county_name,
	fires_drought_join.year,
	COUNT(fires_drought_join.year) AS num_of_fires
FROM
	fires_drought_join
GROUP BY
	fires_drought_join.county_name,
	fires_drought_join.year
;
	

-- creating view where fires are listed alongside drought measurements for chosen period
CREATE VIEW fires_by_drought_period AS (
	SELECT
		f.fire_id,
		f.discover_date AS fire_discovery_date,
		d.validstart AS from_drought_measure_date,
		d.validend AS to_drought_measure_date,
		f.county_name, 
		d.None AS no_drought_pct,
		d.D0 AS abnormally_dry_pct,
		d.D1 AS moderate_drought_pct,
		d.D2 AS severe_drought_pct,
		d.D3 AS extreme_drought_pct,
		d.D4 AS exceptional_drought_pct
	FROM
		fires f JOIN droughts d ON f.county_name = d.county
	WHERE
		f.DISCOVER_DATE BETWEEN d.validstart AND d.validend);

--
SELECT
	*
FROM
	fires_by_drought_period;


--
SELECT
	COUNT(fires.FIRE_ID), 
	fires.STAT_CAUSE_DESCR
FROM
	fires


	