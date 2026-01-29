/* 
Exercicis Subqueries
Sobre la BBDD “hospitales”, pots realitzar els següents exercicis per practicar les subqueries:

» 1. Mostra el nom del hospital amb més pressupost de cada comunitat autònoma.

» 2. Mostra el nom de l'hospital i el nom del pacient que te menys edat de cada hospital.

» 3. Mostra els hospitals que estàn per sobre de la mitja de "indice_satisfaccion" de cada comunidad autònoma.
 */;

 -- » 1. Mostra el nom del hospital amb més pressupost de cada comunitat autònoma.
 ;

-- SOLUCION JOIN con subquery agregada

SELECT  hospitales.comunidad_autonoma,
        nombre
FROM hospitales
JOIN (
    SELECT  comunidad_autonoma,
            MAX (presupuesto_anual_millones) AS max_presupuesto
    FROM hospitales
    GROUP BY comunidad_autonoma
) AS max_presupuesto_ca
ON hospitales.comunidad_autonoma = max_presupuesto_ca.comunidad_autonoma
AND hospitales.presupuesto_anual_millones = max_presupuesto_ca.max_presupuesto
;

-- SOLUCION con WHERE

SELECT  comunidad_autonoma,
        nombre
FROM hospitales
WHERE (comunidad_autonoma, presupuesto_anual_millones) IN (
    SELECT  comunidad_autonoma, MAX (presupuesto_anual_millones)
    FROM hospitales
    GROUP BY comunidad_autonoma)
;

-- SOLUCION Subquery Correlacionada

SELECT  comunidad_autonoma,
        nombre
FROM hospitales h1
WHERE presupuesto_anual_millones = (    SELECT MAX (presupuesto_anual_millones)
                                        FROM hospitales h2
                                        WHERE h1.comunidad_autonoma = h2.comunidad_autonoma)
ORDER BY comunidad_autonoma
;

-- » 2. Mostra el nom de l'hospital i el nom del pacient que te menys edat de cada hospital.
;

SELECT  h.hospital_id,
        h.nombre,
        p.nombre,
        p.edad
FROM hospitales h
JOIN pacientes p ON h.hospital_id = p.hospital_id
WHERE (h.hospital_id, p.edad) IN (
    SELECT p.hospital_id, MIN (p.edad) AS min_edad
    FROM pacientes p
    GROUP BY p.hospital_id
    ORDER BY p.hospital_id
) 
ORDER BY h.hospital_id
;

-- » 3. Mostra els hospitals que estàn per sobre de la mitja de "indice_satisfaccion" de cada comunidad autònoma.
;

SELECT  hospitales.nombre,
        hospitales.indice_satisfaccion AS is_hospital,
        med_satisfaccion_ca.media_satisfaccion AS is_media_ca
FROM hospitales
JOIN (
SELECT h.comunidad_autonoma, AVG (h.indice_satisfaccion) AS media_satisfaccion
FROM hospitales h
GROUP BY h.comunidad_autonoma
) AS med_satisfaccion_ca
ON hospitales.comunidad_autonoma = med_satisfaccion_ca.comunidad_autonoma
WHERE hospitales.indice_satisfaccion > med_satisfaccion_ca.media_satisfaccion
ORDER BY hospitales.indice_satisfaccion
;

