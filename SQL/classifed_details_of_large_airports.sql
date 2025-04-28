SELECT 
  a.name AS airport,
  r.name AS region,
  cc.continent,
  a.latitude_deg,
  a.longitude_deg
FROM airports a
JOIN regions r ON a.iso_region = r.code
JOIN country_continent cc ON a.iso_country = cc.iso_country
WHERE a.type = 'large_airport';


