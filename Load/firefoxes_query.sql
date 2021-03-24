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
CREATE VIEW yearly_droughts_county AS( 
	SELECT
		fires_drought_join.county_name,
		fires_drought_join.year,
		COUNT(fires_drought_join.year) AS num_of_fires
	FROM
		fires_drought_join
	GROUP BY
		fires_drought_join.county_name,
		fires_drought_join.year
);

SELECT 
	*
FROM
	yearly_droughts_county;


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
		
SELECT
	*
FROM
	fires_by_drought_period;


--
CREATE VIEW fire_cause_summary AS(
	SELECT
		fires.STAT_CAUSE_DESCR AS cause_description,
		COUNT(fires.FIRE_ID) AS num_fires
	FROM
		fires
	GROUP BY
		fires.STAT_CAUSE_DESCR
	ORDER BY
		num_fires DESC);

SELECT
	*
FROM 
	fire_cause_summary;

-- creating view where yearly averages and yearly count of fires by county are joined
CREATE VIEW yearly_fire_drought_join AS (
	SELECT
		a.year,
		a.county,
		g.num_of_fires,
		a.None AS no_drought_pct,
		a.D0 AS abnormally_dry_pct,
		a.D1 AS moderate_drought_pct,
		a.D2 AS severe_drought_pct,
		a.D3 AS extreme_drought_pct,
		a.D4 AS exceptional_drought_pct
	FROM
		yearly_averages a JOIN fire_groups g ON a.county = g.county_name
	ORDER BY
		g.num_of_fires DESC);
	
	
SELECT 
	* 
FROM 
	yearly_fire_drought_join;
	
-- creating view on number of fires vs population for year 2015
CREATE VIEW fire_county_details AS(	
	SELECT
		counties.county,
		counties.population,
		counties.area,
		fire_groups.num_of_fires,
		fire_groups.fire_year
	FROM
		counties, 
		fire_groups
	WHERE counties.county = fire_groups.county_name);
	
SELECT 
	*
FROM
	fire_county_details;