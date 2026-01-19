/* 
1) Mostra la quantitat de pacients que hi ha a la taula "pacientes".

2) Mostra la quantitat de pacients que té cada "hospital_id" de la taula "pacientes".

3) Mostra el "numero_dias_ingreso" màxim de cada "hospital_id" de la taula "pacientes".

4) Mostra el "indice_satisfaccion" mig de cada comunitat autònoma i província de la taula "hospitals".

5) Mostra el "num_camas" total de cada comunitat autònoma.

6) Mostra el "porcentaje_ocupacion" més petit de cada província de cada comunitat autònoma.

7) Mostra quantes províncies i localitats té cada comunitat autònoma.

8) Mostra les comunitats autònomes que tenen menys de 5 hospitals.

9) Mostra la quantitat d'hospitals per "especialidad" i per "fija". És a dir, quants hospitals tenen una especialitat en funció de si és fixa o no.

 */;

 -- ===============================
 ;

-- 1) Mostra la quantitat de pacients que hi ha a la taula "pacientes".
;

SELECT COUNT (paciente_id) AS total_pacientes
FROM pacientes;

-- 2) Mostra la quantitat de pacients que té cada "hospital_id" de la taula "pacientes".
;

SELECT  hospital_id,
        COUNT (paciente_id) AS quantitat_pacients
FROM pacientes
GROUP BY hospital_id;

-- 3) Mostra el "numero_dias_ingreso" màxim de cada "hospital_id" de la taula "pacientes".
;

SELECT  hospital_id, 
        MAX(numero_dias_ingreso) AS max_dias_ingreso
FROM pacientes
GROUP BY hospital_id;

-- 4) Mostra el "indice_satisfaccion" mig de cada comunitat autònoma i província de la taula "hospitals".
;

SELECT  comunidad_autonoma,
        provincia,
        round (AVG(indice_satisfaccion),2)
FROM hospitales
GROUP BY comunidad_autonoma, provincia;

-- 5) Mostra el "num_camas" total de cada comunitat autònoma.
;

SELECT comunidad_autonoma,
    SUM (num_camas) AS total_camas
FROM hospitales
GROUP BY comunidad_autonoma;

-- 6) Mostra el "porcentaje_ocupacion" més petit de cada província de cada comunitat autònoma.
;

SELECT comunidad_autonoma,
    provincia,
    MIN (porcentaje_ocupacion) AS menor_porcentaje_ocupacion
FROM hospitales
GROUP BY comunidad_autonoma, provincia;

-- 7) Mostra quantes províncies i localitats té cada comunitat autònoma.
;
SELECT comunidad_autonoma,
    COUNT (DISTINCT provincia) AS num_provincias,
    COUNT (DISTINCT localidad) AS num_localidades
FROM hospitales
GROUP BY comunidad_autonoma;

-- 8) Mostra les comunitats autònomes que tenen menys de 5 hospitals.
;

SELECT comunidad_autonoma,
    COUNT(*) AS num_hospitales
FROM hospitales
GROUP BY comunidad_autonoma
HAVING num_hospitales < 5
ORDER BY num_hospitales DESC;

-- 9) Mostra la quantitat d'hospitals per "especialidad" i per "fija". És a dir, quants hospitals tenen una especialitat en funció de si és fixa o no.
;

SELECT especialidad,
    fija,
    COUNT(hospital_id) AS num_hospitales
FROM especialidades
GROUP BY especialidad, fija
ORDER BY especialidad, fija;
