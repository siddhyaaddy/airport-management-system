SELECT code FROM countries_lookup
UNION
SELECT iso_country FROM country_continent;
