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
