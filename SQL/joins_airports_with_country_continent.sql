SELECT a.name, a.ident, cc.continent 
FROM airports a
JOIN country_continent cc ON a.iso_country = cc.iso_country
ORDER BY cc.continent, a.name 
LIMIT 10;