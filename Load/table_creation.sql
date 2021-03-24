-- creating fire table
DROP TABLE IF EXISTS fires;

CREATE TABLE fires (
	INDEX_ID INT,
	FIRE_ID INT NOT NULL,
	FIRE_YEAR INT NOT NULL,
	STAT_CAUSE_DESCR VARCHAR(100),
	LATITUDE DECIMAL,
	LONGITUDE DECIMAL,
	STATE VARCHAR(50),
	COUNTY VARCHAR(100),
	LAT_LONG VARCHAR(200),
	COUNTY_NAME VARCHAR(100),
	DISCOVER_DATE DATE
);

-- creating drought table
DROP TABLE IF EXISTS droughts;

CREATE TABLE droughts (
	drought_id INT NOT NULL,
	County VARCHAR(100),
	State VARCHAR(50),
	None DECIMAL,
	D0 DECIMAL,
	D1 DECIMAL,
	D2 DECIMAL,
	D3 DECIMAL,
	D4 DECIMAL,
	ValidStart DATE,
	ValidEnd DATE,
	Year INT
);

-- creating county table
DROP TABLE IF EXISTS counties;

CREATE TABLE counties (
	county_id INT NOT NULL,
	county VARCHAR(100),
	fips_code INT NOT NULL,
	population INT,
	area VARCHAR(200)
);

-- dropping counties_2 table 
DROP TABLE IF EXISTS counties_2;

-- creating fire_groups table
DROP TABLE IF EXISTS fire_groups;

CREATE TABLE fire_groups (
	index_id INT NOT NULL,
	FIRE_YEAR INT,
	COUNTY_NAME VARCHAR(100),
	NUM_OF_FIRES INT
);

-- creating yearly_averages table
DROP TABLE IF EXISTS yearly_averages;

CREATE TABLE yearly_averages (
	average_id INT NOT NULL,
	year INT,
	county VARCHAR(100),
	drought_id DECIMAL,
	none DECIMAL,
	D0 DECIMAL,
	D1 DECIMAL,
	D2 DECIMAL,
	D3 DECIMAL,
	D4 DECIMAL
);