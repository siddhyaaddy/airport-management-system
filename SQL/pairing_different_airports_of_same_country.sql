SELECT a1.name AS airport1_name, a2.name AS airport2_name
FROM airports a1
JOIN airports a2 
  ON a1.iso_country = a2.iso_country 
 AND a1.id <> a2.id
LIMIT 10;

