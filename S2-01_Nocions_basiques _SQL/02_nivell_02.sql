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