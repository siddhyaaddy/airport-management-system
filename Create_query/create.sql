-- Drop tables in reverse dependency order
--DROP TABLE IF EXISTS runways CASCADE;
--DROP TABLE IF EXISTS frequencies CASCADE;
--DROP TABLE IF EXISTS dme_attributes CASCADE;
--DROP TABLE IF EXISTS navaids_base CASCADE;
--DROP TABLE IF EXISTS airports CASCADE;
--DROP TABLE IF EXISTS regions CASCADE;
--DROP TABLE IF EXISTS country_continent CASCADE;
--DROP TABLE IF EXISTS countries CASCADE;
--DROP TABLE IF EXISTS countries_lookup CASCADE;

-- Create normalized country lookup
CREATE TABLE countries_lookup (
    code VARCHAR(2) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    continent VARCHAR(2) NOT NULL
);

-- Modified countries table
CREATE TABLE countries (
    id VARCHAR(10) PRIMARY KEY,
    code VARCHAR(2) NOT NULL UNIQUE,
    wikipedia_link TEXT,
    FOREIGN KEY (code) REFERENCES countries_lookup(code)
);

-- Country-continent relationship
CREATE TABLE country_continent (
    iso_country VARCHAR(2) PRIMARY KEY,
    continent VARCHAR(2) NOT NULL
);

-- Modified regions table
CREATE TABLE regions (
    id VARCHAR(10) PRIMARY KEY,
    code VARCHAR(10) UNIQUE,
    local_code VARCHAR(10),
    name TEXT,
    iso_country VARCHAR(2) NOT NULL,
    wikipedia_link TEXT,
    keywords TEXT,
    FOREIGN KEY (iso_country) REFERENCES country_continent(iso_country)
);

-- Modified airports table
CREATE TABLE airports (
    id INTEGER PRIMARY KEY,
    ident VARCHAR(10) UNIQUE,
    type VARCHAR(20),
    name TEXT,
    latitude_deg DOUBLE PRECISION,
    longitude_deg DOUBLE PRECISION,
    elevation_ft INTEGER,
    iso_country VARCHAR(2) NOT NULL,
    iso_region VARCHAR(10),
    municipality TEXT,
    scheduled_service VARCHAR(3),
    gps_code VARCHAR(10),
    icao_code VARCHAR(10),
    iata_code VARCHAR(10),
    local_code VARCHAR(10),
    home_link TEXT,
    wikipedia_link TEXT,
    keywords TEXT,
    FOREIGN KEY (iso_country) REFERENCES country_continent(iso_country),
    FOREIGN KEY (iso_region) REFERENCES regions(code)
);

-- Frequencies table
CREATE TABLE frequencies (
    id SERIAL PRIMARY KEY,
    airport_ref INTEGER NOT NULL,
    airport_ident VARCHAR(10),
    type VARCHAR(50),
    description TEXT,
    frequency_mhz DOUBLE PRECISION,
    FOREIGN KEY (airport_ref) REFERENCES airports(id),
    FOREIGN KEY (airport_ident) REFERENCES airports(ident)
);

-- Normalized navaids structure
CREATE TABLE navaids_base (
    id INTEGER PRIMARY KEY,
    filename TEXT,
    ident VARCHAR(10) NOT NULL,
    name TEXT,
    type VARCHAR(20) NOT NULL,
    frequency_khz DOUBLE PRECISION,
    latitude_deg DOUBLE PRECISION,
    longitude_deg DOUBLE PRECISION,
    elevation_ft INTEGER,
    iso_country VARCHAR(2),
    usage_type VARCHAR(50),
    power TEXT,
    FOREIGN KEY (iso_country) REFERENCES countries_lookup(code)
);

CREATE TABLE dme_attributes (
    navaid_id INTEGER PRIMARY KEY,
    dme_frequency_khz DOUBLE PRECISION,
    dme_channel VARCHAR(10),
    dme_latitude_deg DOUBLE PRECISION,
    dme_longitude_deg DOUBLE PRECISION,
    FOREIGN KEY (navaid_id) REFERENCES navaids_base(id)
);

-- Runways table
CREATE TABLE runways (
    id SERIAL PRIMARY KEY,
    airport_ref INTEGER NOT NULL,
    airport_ident VARCHAR(10),
    length_ft INTEGER,
    width_ft INTEGER,
    surface VARCHAR,
    lighted BOOLEAN,
    closed BOOLEAN,
    le_ident VARCHAR(10),
    le_latitude_deg DOUBLE PRECISION,
    le_longitude_deg DOUBLE PRECISION,
    le_elevation_ft INTEGER,
    le_heading_degT DOUBLE PRECISION,
    le_displaced_threshold_ft INTEGER,
    he_ident VARCHAR(10),
    he_latitude_deg DOUBLE PRECISION,
    he_longitude_deg DOUBLE PRECISION,
    he_elevation_ft INTEGER,
    he_heading_degT DOUBLE PRECISION,
    he_displaced_threshold_ft INTEGER,
    FOREIGN KEY (airport_ref) REFERENCES airports(id),
    FOREIGN KEY (airport_ident) REFERENCES airports(ident)
);

-- Indexes for performance
CREATE INDEX idx_airports_country ON airports(iso_country);
CREATE INDEX idx_regions_country ON regions(iso_country);
CREATE INDEX idx_navaids_country ON navaids_base(iso_country);



