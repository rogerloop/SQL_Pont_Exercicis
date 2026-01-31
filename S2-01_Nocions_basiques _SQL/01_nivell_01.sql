/* 
- Exercici 1

A partir dels documents adjunts (estructura_dades i dades_introduir), importa les dues taules. 
Mostra les característiques principals de l'esquema creat i explica les diferents taules i variables que existeixen. 
Assegura't d'incloure un diagrama que il·lustri la relació entre les diferents taules i variables.
 */;

 -- Aquest exercici es`t en el PDF "01_ S2-01_Nocions_basiques_SQL.pdf" d'aquest mateix subdirectori
;

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

/* 
- Exercici 3

Utilitzant només subconsultes (sense utilitzar JOIN):

- Mostra totes les transaccions realitzades per empreses d'Alemanya.
- Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.
- Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.
*/;

-- - Mostra totes les transaccions realitzades per empreses d'Alemanya.

 SELECT *
 FROM transaction t
 WHERE t.company_id IN (SELECT c.id
        FROM company c
        WHERE c.country = 'Germany'
 ) 
 ;

 -- - Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.

 SELECT c.id, 
        c.company_name
 FROM company c
 WHERE c.id IN (
    SELECT t.company_id
    FROM transaction t
    WHERE t.amount > (
                        SELECT AVG (t.amount) AS mitjana_transaccions
                        FROM transaction t
    )
 )
 ;

-- - Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses. 
-- No hi ha cap empresa que no tingui transaccions finalitzades OK el llistat estaria buit

SELECT DISTINCT t.company_id
FROM transaction t
WHERE t.declined = 0
;

