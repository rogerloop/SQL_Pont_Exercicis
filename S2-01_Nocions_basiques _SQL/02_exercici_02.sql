/* 
Exercici 2

Utilitzant JOIN realitzaràs les següents consultes:

- Llistat dels països que estan fent compres.
- Des de quants països es realitzen les compres.
- Identifica la companyia amb la mitjana més gran de vendes. 
*/;

-- - Llistat dels països que estan fent compres.

-- Poso un filtre Where final per eliminar transaccions no completades (Ja que no serien compres completades)


SELECT DISTINCT c.country
FROM transaction t
JOIN company c ON t.company_id = c.id
WHERE t.declined = 0
;

-- - Des de quants països es realitzen les compres.
-- resultat son 15 països diferents tan amb completades com incloent les no completades.

SELECT COUNT (DISTINCT c.country)
FROM transaction t
JOIN company c ON t.company_id = c.id
WHERE t.declined = 0
;

-- - Identifica la companyia amb la mitjana més gran de vendes. 
-- Resultat : Eget Ipsum Ltd

SELECT  c.id,
        c.company_name,
        AVG (t.amount) AS mitjana_vendes
FROM transaction t
JOIN company c ON t.company_id = c.id
WHERE t.declined = 0
GROUP BY c.id, c.company_name
ORDER BY mitjana_vendes DESC
LIMIT 1
;
