/* 
Exercici 1

Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions amb un valor comprès 
entre 100 i 200 euros i en alguna d'aquestes dates: 29 d'abril del 2021, 20 de juliol del 2021 i 13 de març del 2022. 
Ordena els resultats de major a menor quantitat.
*/;

SELECT  c.company_name,
        c.phone,
        c.country,
        DATE (t.timestamp) AS data_t,
        t.amount
FROM transaction t
JOIN company c ON t.company_id = c.id
WHERE (t.amount BETWEEN 100 AND 200)
AND DATE (t.timestamp) IN ('2021-04 -29' , '2021-07-20' , '2022-03-13')
ORDER BY t.amount DESC
;


/* 
Exercici 2

Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, 
per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, 
però el departament de recursos humans és exigent i 
vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.
*/;

SELECT  c.company_name,
        qo.operacions,
CASE 
    WHEN qo.operacions > 4 THEN 'Te mes de 4 operacions'
    ELSE 'Te menys de 4 operacions'
END AS quantitat_transaccions
FROM company c
JOIN (
    SELECT  t.company_id,
            COUNT (t.id) AS operacions
    FROM transaction t
    WHERE declined = 0
    GROUP BY t.company_id
) AS qo
ON c.id = qo.company_id
ORDER BY quantitat_transaccions DESC, c.company_name
;