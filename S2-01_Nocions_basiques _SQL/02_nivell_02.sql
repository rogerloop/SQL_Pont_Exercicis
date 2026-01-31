/* 
Exercici 1

Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. 
Mostra la data de cada transacció juntament amb el total de les vendes. 
*/;

-- Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. 
;

SELECT  DATE (timestamp) AS data_venda, 
        SUM (amount) AS vendes
FROM transaction
GROUP BY data_venda
ORDER BY vendes DESC
LIMIT 5
;

-- Mostra la data de cada transacció juntament amb el total de les vendes. 

-- RESULTAT: M'ha semblat un enunciat ambiguo i he decidit ampliar la informació solicitada 
-- mostrant totes les operacions realitzades en cada una dels 5 dies amb mes vendes,  


SELECT  DATE (t.timestamp) AS data_t,
        c.company_name AS empresa,
        t.amount AS import_transaccio,
        total_data.vendes AS total_dia

FROM transaction t
JOIN company c ON t.company_id = c.id
JOIN (
SELECT  DATE (timestamp) AS data_venda, 
        SUM (amount) AS vendes
FROM transaction
GROUP BY data_venda
ORDER BY vendes DESC
LIMIT 5
) AS total_data
ON DATE (t.timestamp) = total_data.data_venda
;

/* 
Exercici 2

Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.
*/;

SELECT  c.country,
        AVG (t.amount) AS mitjana_vendes
FROM transaction t
JOIN company c ON t.company_id = c.id
GROUP BY c.country
ORDER BY mitjana_vendes DESC
;

/* 
Exercici 3

En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries 
per a fer competència a la companyia "Non Institute". 
Per a això, et demanen la llista de totes les transaccions realitzades 
per empreses que estan situades en el mateix país que aquesta companyia.

Mostra el llistat aplicant JOIN i subconsultes.
Mostra el llistat aplicant solament subconsultes.
*/;


SELECT *
FROM transaction t
JOIN company c ON t.company_id = c.id
WHERE c.country IN (
    SELECT c.country
    FROM company c
    WHERE c.company_name = 'Non Institute'
)
;

SELECT *
FROM transaction t
WHERE t.company_id IN (
    SELECT c.id
    FROM company c
    WHERE c.country IN (
        SELECT c.country
        FROM company c
        WHERE c.company_name = 'Non Institute'
)
)
;