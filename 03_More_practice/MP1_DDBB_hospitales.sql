/* 
Exercicis JOIN

Sobre la BBDD “hospitales”, pots realitzar els següents exercicis per practicar els JOIN:

» 1. Mostra el nom dels hospitals i los pacients extranjers que hi ha a la localitat de Toledo.

» 2. Mostra el nom dels hospitals i la quantitat d'especialitats que hi ha als hospitals de la consulta anterior.

» 3. Mostra el nom de l’hospital i les especialitats que té l’hospital amb identificador 105.

» 4. Digues quants hospitals tenen dades a la taula "hospitales", però no tenen dades a la taula de "pacientes".

» 5. Mostra el nom de l'hospital que té menys especialitats fixes.

» 6. Mostra el nom i el nombre total de visites de l'hospital amb identificador 45.

» 7. Mostra el nom de l'hospital, el nom dels seus pacients estrangers i el nombre de visites, així com les especialitats que NO són fixes. Totes aquestes dades de l'hospital amb identificador 45.

» 8. Suma el "numero_visitas" de la consulta anterior (a mà) i compara-la amb el "numero_visitas" de la consulta núm. 6. Són iguals? Què està passant? 
*/;

-- ==========================================
;

-- » 1. Mostra el nom dels hospitals i los pacients extranjers que hi ha a la localitat de Toledo.
;

SELECT  hospitales.nombre AS hospital,
        pacientes.nombre AS nombre_paciente

FROM hospitales
JOIN pacientes ON hospitales.hospital_id = pacientes.hospital_id
WHERE hospitales.localidad = 'Toledo' AND pacientes.nacionalidad = 'Extranjera'
;

-- » 2. Mostra el nom dels hospitals i la quantitat d'especialitats que hi ha als hospitals de la consulta anterior.
;

SELECT  hospitales.nombre AS hospital,
        COUNT (especialidades.especialidad) AS num_especialidades
FROM hospitales
JOIN especialidades ON hospitales.hospital_id = especialidades.hospital_id
WHERE hospitales.localidad = 'Toledo'
GROUP BY hospitales.nombre
;

-- » 3. Mostra el nom de l’hospital i les especialitats que té l’hospital amb identificador 105.
;

SELECT  hospitales.nombre,
        especialidades.especialidad
FROM hospitales
JOIN especialidades ON hospitales.hospital_id = especialidades.hospital_id
WHERE hospitales.hospital_id = 105
;

-- » 4. Digues quants hospitals tenen dades a la taula "hospitales", però no tenen dades a la taula de "pacientes".
;

SELECT COUNT(DISTINCT hospitales.hospital_id) AS num_hospitals_sin_pacientes
FROM hospitales
LEFT JOIN pacientes ON hospitales.hospital_id = pacientes.hospital_id
WHERE pacientes.hospital_id IS NULL
;

-- » 5. Mostra el nom de l'hospital que té menys especialitats fixes.

-- Solucion con JOIN NO Dinamica

SELECT  hospitales.hospital_id,
        hospitales.nombre,
        especialidades.hospital_id,
        COUNT (especialidades.fija) AS num_especialidades_fijas
FROM hospitales
JOIN especialidades ON hospitales.hospital_id = especialidades.hospital_id
WHERE especialidades.fija = 'S'
GROUP BY hospitales.hospital_id
ORDER BY num_especialidades_fijas
LIMIT 3
;

-- Solucion con SUBQUERY - Dinamica

SELECT hospitales.nombre, 
         fijas_hospital.num_fijas
        
FROM hospitales
JOIN (SELECT especialidades.hospital_id, 
        COUNT (*) AS num_fijas
        FROM especialidades
        WHERE especialidades.fija = 'S'
        GROUP BY especialidades.hospital_id
        ) AS fijas_hospital
ON hospitales.hospital_id = fijas_hospital.hospital_id
WHERE fijas_hospital.num_fijas = (
    SELECT MIN (num_fijas)
    FROM (
        SELECT especialidades.hospital_id, 
        COUNT (*) AS num_fijas
        FROM especialidades
        WHERE especialidades.fija = 'S'
        GROUP BY especialidades.hospital_id
        ) AS min_fijas
)
;

-- Solucion con Subquery CTE "WITH"

WITH fijas_hospital AS (  
    SELECT  especialidades.hospital_id, 
            COUNT (*) AS num_fijas
    FROM especialidades
    WHERE especialidades.fija = 'S'
    GROUP BY especialidades.hospital_id
),

min_fijas AS (
    SELECT MIN (fijas_hospital.num_fijas) AS min_num
    FROM (
        SELECT  especialidades.hospital_id, 
                COUNT (*) AS num_fijas
        FROM especialidades
        WHERE especialidades.fija = 'S'
        GROUP BY especialidades.hospital_id
        ) AS fijas_hospital
)

SELECT  hospitales.nombre,
        fijas_hospital.num_fijas
FROM hospitales
JOIN fijas_hospital ON hospitales.hospital_id = fijas_hospital.hospital_id
JOIN min_fijas ON fijas_hospital.num_fijas = min_fijas.min_num
;