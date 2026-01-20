/* 
1.Mostra el nom del llibre i el nom de l'autor dels llibres que són d'abans del 1927.
2.Sobre la pregunta anterior, quin és l'autor amb més llibres publicats abans de 1927?
3.Mostra el nom dels llibres i la quantitat de vegades que han estat retornats amb retard. També s'ha de mostrar la mitjana dels dies de retard.
4.Mostra la quantitat d'usuaris que no han realitzat cap préstec.
5.Mostra el nom dels 3 usuaris que han fet més préstecs.
6.Mostra el nom i l'ID dels usuaris estrangers i que han hagut de pagar una multa per retard en la devolució del préstec superior a 10 euros.
7.Mostra l'autor nascut després de 1980 que ha generat més préstecs en usuaris espanyols. A més, només s'han de comptabilitzar els préstecs finalitzats (ok o amb retard).
8.Quina és la categoria de llibres que més demanen en préstec les persones que tenen targeta de fidelitat?
 */ ;

 -- ===============================================

 -- 1.Mostra el nom del llibre i el nom de l'autor dels llibres que són d'abans del 1927.
 ;

 SELECT libros.titulo,
    autores.nombre,
    libros.año_publicacion
 FROM libros
 JOIN autores ON libros.autor_id = autores.autor_id
 WHERE libros.año_publicacion < 1927
 ORDER BY autores.nombre;

 -- 2.Sobre la pregunta anterior, quin és l'autor amb més llibres publicats abans de 1927?
 ;

 SELECT autores.nombre,
    COUNT(libros.libro_id) AS libros_publicados
 FROM libros
 JOIN autores 
 ON libros.autor_id = autores.autor_id
 WHERE libros.año_publicacion < 1927
 GROUP BY autores.nombre
 ORDER BY libros_publicados DESC
 LIMIT 1;

-- 3.Mostra el nom dels llibres i la quantitat de vegades que han estat retornats amb retard. 
-- També s'ha de mostrar la mitjana dels dies de retard.
;

SELECT libros.titulo,
    COUNT (prestamos.prestamo_id) AS num_retrasos_devolucion,
    ROUND (AVG (prestamos.dias_retraso), 1) AS media_dias_retrasados
FROM libros
INNER JOIN prestamos 
ON libros.libro_id = prestamos.libro_id
WHERE prestamos.estado_prestamo = 'finalizado con retraso'
GROUP BY libros.titulo
ORDER BY num_retrasos_devolucion DESC, media_dias_retrasados DESC;

-- 4.Mostra la quantitat d'usuaris que no han realitzat cap préstec.
;

SELECT COUNT (usuarios.usuario_id) AS usuarios_sin_prestamo
FROM usuarios
LEFT JOIN prestamos ON usuarios.usuario_id = prestamos.usuario_id
WHERE prestamos.prestamo_id is NULL
;

-- 5.Mostra el nom dels 3 usuaris que han fet més préstecs.
;

SELECT usuarios.usuario_id,
    usuarios.nombre,
    usuarios.apellido,
    COUNT (prestamos.prestamo_id) AS num_prestamos
FROM usuarios
INNER JOIN prestamos ON usuarios.usuario_id = prestamos.usuario_id
GROUP BY usuarios.usuario_id
ORDER BY num_prestamos DESC, usuarios.usuario_id
LIMIT 3
;