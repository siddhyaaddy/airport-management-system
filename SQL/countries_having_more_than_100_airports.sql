SELECT cc.iso_country, COUNT(*) AS airport_count
FROM airports a
JOIN country_continent cc ON a.iso_country = cc.iso_country
GROUP BY cc.iso_country
HAVING COUNT(*) > 100;

